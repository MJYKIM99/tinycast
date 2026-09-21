import Foundation

/// Guards the shipped translation tables.
///
/// The tables are data, so no compiler reads them, and every way they can go wrong is silent at
/// runtime: a specifier dropped from a value risks a `String(format:)` mismatch, and a key spelled
/// with the wrong quote character never matches, so the surface quietly stays English. Both are
/// caught here. See docs/localization.md.
@main
@MainActor
struct LocalizationTests {
    static var failures = 0
    static var passes = 0

    static func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
        if condition() { passes += 1 } else { failures += 1; print("FAIL: \(message)") }
    }

    /// `%@`, `%lld` and `%lf` are the three specifiers SwiftUI's own interpolation produces.
    static func specifiers(_ text: String) -> [String] {
        let pattern = try? NSRegularExpression(pattern: "%(?:@|lld|lf)")
        let range = NSRange(text.startIndex..., in: text)
        return (pattern?.matches(in: text, range: range) ?? []).compactMap {
            Range($0.range, in: text).map { String(text[$0]) }
        }.sorted()
    }

    /// Every string literal the app sources hold, decoded the way Swift decodes it.
    ///
    /// Comparing with the raw file text would be wrong: the sources spell curly quotes as
    /// `\u{201C}` escapes, while the key the runtime asks for holds the character.
    static func sourceLiterals() -> Set<String> {
        var literals: Set<String> = []
        let root = URL(fileURLWithPath: "Tinycast")
        let walker = FileManager.default.enumerator(at: root, includingPropertiesForKeys: nil)
        for case let url as URL in walker ?? FileManager.DirectoryEnumerator() {
            guard url.pathExtension == "swift",
                let text = try? String(contentsOf: url, encoding: .utf8)
            else { continue }
            let characters = Array(text)
            var index = 0
            while index < characters.count {
                guard characters[index] == "\"" else { index += 1; continue }
                var literal = ""
                var cursor = index + 1
                var closed = false
                var isTemplate = false
                while cursor < characters.count {
                    let character = characters[cursor]
                    if character == "\"" { closed = true; cursor += 1; break }
                    if character == "\\" {
                        let next = cursor + 1 < characters.count ? characters[cursor + 1] : " "
                        if next == "u", cursor + 2 < characters.count, characters[cursor + 2] == "{" {
                            var hex = ""
                            var scan = cursor + 3
                            while scan < characters.count, characters[scan] != "}" {
                                hex.append(characters[scan])
                                scan += 1
                            }
                            if let value = UInt32(hex, radix: 16), let scalar = Unicode.Scalar(value) {
                                literal.unicodeScalars.append(scalar)
                                cursor = min(scan + 1, characters.count)
                                continue
                            }
                        }
                        // An interpolation makes this a template, whose key SwiftUI computes.
                        if next == "(" { isTemplate = true; cursor += 2; continue }
                        let escapes: [Character: Character] = [
                            "n": "\n", "t": "\t", "r": "\r", "0": "\0", "\"": "\"", "'": "'",
                            "\\": "\\"
                        ]
                        literal.append(escapes[next] ?? next)
                        cursor += 2
                        continue
                    }
                    literal.append(character)
                    cursor += 1
                }
                if closed, !isTemplate { literals.insert(literal) }
                index = max(cursor, index + 1)
            }
        }
        return literals
    }

    static func main() {
        let resources = URL(fileURLWithPath: "Tinycast/Resources")
        let locales =
            (try? FileManager.default.contentsOfDirectory(
                at: resources, includingPropertiesForKeys: nil)) ?? []
        let tables = locales.filter { $0.pathExtension == "lproj" }.sorted { $0.path < $1.path }

        expect(!tables.isEmpty, "at least one .lproj ships in Tinycast/Resources")
        let literals = sourceLiterals()
        expect(
            literals.count > 2_000,
            "the app sources are readable from the suite's working directory — \(literals.count) literals")

        let infoPlist =
            (try? String(
                contentsOf: URL(fileURLWithPath: "Tinycast/Info.plist"), encoding: .utf8)) ?? ""

        for locale in tables {
            let language = locale.deletingPathExtension().lastPathComponent
            let table = locale.appendingPathComponent("Localizable.strings")
            guard let entries = NSDictionary(contentsOf: table) as? [String: String] else {
                expect(false, "\(language): Localizable.strings parses")
                continue
            }
            expect(entries.count > 1_000, "\(language): the table is populated — \(entries.count)")

            var emptyValues: [String] = []
            var specifierDrift: [String] = []
            var orphanKeys: [String] = []
            for (key, value) in entries {
                if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    emptyValues.append(key)
                }
                // A translated value must carry exactly its key's specifiers, or `String(format:)`
                // would read an argument that is not there.
                if specifiers(key) != specifiers(value) {
                    specifierDrift.append(key)
                    continue
                }
                // A plain key has to exist in the sources verbatim, or nothing can ever ask for it.
                // An interpolated key is computed at the call site, so it is exempt.
                if specifiers(key).isEmpty, !literals.contains(key) {
                    orphanKeys.append(key)
                }
            }
            expect(emptyValues.isEmpty, "\(language): no empty value — \(emptyValues.prefix(4))")
            expect(
                specifierDrift.isEmpty,
                "\(language): every value keeps its key's specifiers — \(specifierDrift.prefix(4))")
            expect(
                orphanKeys.isEmpty,
                "\(language): every plain key exists in the sources — \(orphanKeys.prefix(4))")

            let info = locale.appendingPathComponent("InfoPlist.strings")
            if let plist = NSDictionary(contentsOf: info) as? [String: String] {
                for key in plist.keys {
                    expect(
                        infoPlist.contains("<key>\(key)</key>"),
                        "\(language): \(key) is a real Info.plist key")
                }
            }
        }

        print("\(passes) passed, \(failures) failed")
        if failures > 0 { exit(1) }
    }
}
