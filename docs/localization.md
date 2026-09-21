# Localization

Tinycast ships English and Simplified Chinese. The English source text is the key: there is no
invented identifier layer, so a string in the code is also the string in the table.

Two mechanisms reach the same table, and the first needs no source change at all.

## What SwiftUI resolves on its own

`Text("Settings")`, `Button("Cancel")`, `Label("…", systemImage:)`, `.help("…")` and
`.accessibilityLabel("…")` take a `LocalizedStringKey`, and a string *literal* handed to one **is**
the key. SwiftUI looks it up in `Localizable.strings` for the current language and falls back to the
literal when there is no entry. Those call sites are localized purely by shipping the table.

## What a plain `String` needs

The same words stop being keys once they leave a literal. A computed property, a function return, or
a `title:` argument is a `String` by the time a view sees it, and `Text(someString)` renders
verbatim. Those sites ask for the lookup explicitly:

```swift
var title: String { String(localized: "Window Layouts") }
```

`String(localized:)` derives its key exactly as SwiftUI does, interpolation included: an
interpolated literal becomes a format string, `\(name)` is `%@`, `\(count)` is `%lld` and a `Double`
is `%lf`. So `String(localized: "Quit \(appName)")` looks up `Quit %@`, which is the key a
`Text("Quit \(appName)")` would have computed. One table serves both paths.

## Where copy lives

- **Copy belongs in the table, not in a view.** A new user-facing string is a literal under one of
  the two mechanisms above; nothing else is translated.
- **Identifiers are not copy.** SF Symbol names, keycap glyphs, URL query-parameter names, bundle
  identifiers and queue labels are never translated. A keycap still reads `Space`, a query
  parameter stays `page`.
- **A `+`-concatenated sentence is not translated.** Chinese word order differs, so the pieces cannot
  move independently. Those stay English until someone rewrites the sentence as one literal.
- **Product names stay in Latin script** — Tinycast, Raycast, macOS, Spotlight, GitHub, Homebrew.

## Files

- `Tinycast/Resources/<lang>.lproj/Localizable.strings` — the table, keyed by the English source.
- `Tinycast/Resources/<lang>.lproj/InfoPlist.strings` — the permission prompts and the exported
  type's name, keyed by `Info.plist` key. macOS shows these in the TCC prompts.
- `Tinycast/Info.plist` carries `CFBundleLocalizations`, so a Chinese Mac resolves to `zh-Hans` even
  though the development region is English.

The inventory and translation tooling that produced the first table is not committed: it was a
one-off pass over the sources. `Tests/l10n-test.swift` is what keeps the table honest afterwards.

## Adding a string

1. Write the English literal where it renders, or wrap a `String` source in `String(localized:)`.
2. Add `"<English text>" = "<translation>";` to each `Localizable.strings`, keeping every `%@`,
   `%lld` and `%lf` exactly as the key has it — same count, same order. Reordering the words around
   them is expected; changing the specifiers is not.
3. `./Scripts/run-tests.sh l10n-test`.

## Verification

`Tests/l10n-test.swift` reads the shipped tables and fails on the three silent mistakes: a value that
lost or gained a format specifier, an empty value, and a plain key that appears nowhere in the
sources, which means nothing can ever ask for it and the surface stays English. It also checks that
every `InfoPlist.strings` key is a real `Info.plist` key.

To confirm a build actually resolves the table, read the bundle the way the app does — from inside
it, because a bundle loaded by path does not re-read the user's language unless the process is that
app.

Adding a language is a table plus an `Info.plist` entry: both mechanisms handle any `.lproj` the
bundle ships, and the test walks every one it finds.
