import Foundation

/// Built-in launcher actions, surfaced alongside the user-authored ones.
enum CommandID: String, CaseIterable, Sendable {
    case aiChat = "command:ai-chat"
    case fixGrammar = "command:fix-grammar"
    case rewrite = "command:rewrite"
    case translate = "command:translate"
    case summarize = "command:summarize"
    case calculatorHistory = "command:calculator-history"
    case clipboardHistory = "command:clipboard-history"
    case searchEmoji = "command:search-emoji"
    case searchFiles = "command:search-files"
    case searchMenuItems = "command:search-menu-items"
    case switchWindows = "command:switch-windows"
    case openCamera = "command:open-camera"
    case openInBrowser = "command:open-in-browser"
    case runShellCommand = "command:run-shell-command"
    case define = "command:define"
    case joinNextMeeting = "command:join-next-meeting"
    case mySchedule = "command:my-schedule"
    case createEvent = "command:create-event"
    case copyMeetingLink = "command:copy-meeting-link"
    case openInCalendar = "command:open-in-calendar"
    case showNotes = "command:show-notes"
    case createNote = "command:create-note"
    case searchNotes = "command:search-notes"
    case createWindowLayout = "command:create-window-layout"
    case captureWindowLayout = "command:capture-window-layout"
    case createQuicklink = "command:create-quicklink"
    case searchQuicklinks = "command:search-quicklinks"
    case importQuicklinks = "command:import-quicklinks"
    case exportQuicklinks = "command:export-quicklinks"
    case searchSnippets = "command:search-snippets"
    case createSnippet = "command:create-snippet"
    case exportSettings = "command:export-settings"
    case importSettings = "command:import-settings"
    case importFromRaycast = "command:import-from-raycast"
    case checkForUpdates = "command:check-for-updates"
    case settings = "command:settings"
    case about = "command:about"
    case support = "command:support"
    case quit = "command:quit"

    var name: String {
        switch self {
        case .aiChat: return String(localized: "AI Chat")
        case .fixGrammar: return BuiltInQuickAction.fixGrammar.title
        case .rewrite: return BuiltInQuickAction.rewrite.title
        case .translate: return BuiltInQuickAction.translate.title
        case .summarize: return BuiltInQuickAction.summarize.title
        case .calculatorHistory: return String(localized: "Calculator History")
        case .clipboardHistory: return String(localized: "Clipboard History")
        case .searchEmoji: return String(localized: "Search Emoji & Symbols")
        case .searchFiles: return String(localized: "Search Files")
        case .searchMenuItems: return String(localized: "Search Menu Bar Items")
        case .switchWindows: return String(localized: "Switch Windows")
        case .openCamera: return String(localized: "Open Camera")
        case .openInBrowser: return String(localized: "Open in Browser")
        case .runShellCommand: return String(localized: "Run Shell Command")
        case .define: return String(localized: "Define Word")
        case .joinNextMeeting: return String(localized: "Join Next Meeting")
        case .mySchedule: return String(localized: "My Schedule")
        case .createEvent: return String(localized: "Create Event")
        case .copyMeetingLink: return String(localized: "Copy Meeting Link")
        case .openInCalendar: return String(localized: "Open in Calendar")
        case .showNotes: return String(localized: "Show Notes")
        case .createNote: return String(localized: "Create Note")
        case .searchNotes: return String(localized: "Search Notes")
        case .createWindowLayout: return String(localized: "Create Window Layout")
        case .captureWindowLayout: return String(localized: "Create Layout from Current Windows")
        case .createQuicklink: return String(localized: "Create Quicklink")
        case .searchQuicklinks: return String(localized: "Search Quicklinks")
        case .importQuicklinks: return String(localized: "Import Quicklinks")
        case .exportQuicklinks: return String(localized: "Export Quicklinks")
        case .searchSnippets: return String(localized: "Search Snippets")
        case .createSnippet: return String(localized: "Create Snippet")
        case .exportSettings: return String(localized: "Export Backup")
        case .importSettings: return String(localized: "Import Backup")
        case .importFromRaycast: return String(localized: "Import from Raycast")
        case .checkForUpdates: return String(localized: "Check for Updates")
        case .settings: return String(localized: "Settings")
        case .about: return String(localized: "About Tinycast")
        case .support: return String(localized: "Support Tinycast")
        case .quit: return String(localized: "Quit Tinycast")
        }
    }

    var sfSymbol: String {
        switch self {
        case .aiChat: return "sparkles"
        case .fixGrammar: return BuiltInQuickAction.fixGrammar.symbol
        case .rewrite: return BuiltInQuickAction.rewrite.symbol
        case .translate: return BuiltInQuickAction.translate.symbol
        case .summarize: return BuiltInQuickAction.summarize.symbol
        case .calculatorHistory: return "plus.forwardslash.minus"
        case .clipboardHistory: return "doc.on.clipboard"
        case .searchEmoji: return "face.smiling"
        case .searchFiles: return "doc.text.magnifyingglass"
        case .searchMenuItems: return "menubar.rectangle"
        case .switchWindows: return "macwindow.on.rectangle"
        case .openCamera: return "camera"
        case .openInBrowser: return "globe"
        case .runShellCommand: return "terminal"
        case .define: return "book.closed"
        case .joinNextMeeting: return "video.fill"
        case .mySchedule: return "calendar"
        case .createEvent: return "calendar.badge.plus"
        case .copyMeetingLink: return "link"
        case .openInCalendar: return "calendar.badge.clock"
        case .showNotes: return "text.page"
        case .createNote: return "note.text.badge.plus"
        case .searchNotes: return "text.magnifyingglass"
        case .createWindowLayout: return "plus.rectangle.on.rectangle"
        case .captureWindowLayout: return "macwindow.badge.plus"
        case .createQuicklink: return "link.badge.plus"
        case .searchQuicklinks: return Quicklink.sfSymbol
        case .importQuicklinks: return "square.and.arrow.down"
        case .exportQuicklinks: return "square.and.arrow.up"
        case .searchSnippets: return "curlybraces"
        case .createSnippet: return "plus.rectangle.on.rectangle"
        case .exportSettings: return "square.and.arrow.up"
        case .importSettings: return "square.and.arrow.down"
        case .importFromRaycast: return "arrow.down.doc"
        case .checkForUpdates: return "arrow.down.circle"
        case .settings: return "gearshape"
        case .about: return "info.circle"
        case .support: return "heart"
        case .quit: return "power"
        }
    }

    /// Exhaustive, so a fifth shipped action cannot reach the launcher without a row here.
    init(_ action: BuiltInQuickAction) {
        switch action {
        case .fixGrammar: self = .fixGrammar
        case .rewrite: self = .rewrite
        case .translate: self = .translate
        case .summarize: self = .summarize
        }
    }

    var builtInQuickAction: BuiltInQuickAction? {
        switch self {
        case .fixGrammar: return .fixGrammar
        case .rewrite: return .rewrite
        case .translate: return .translate
        case .summarize: return .summarize
        default: return nil
        }
    }

    /// Query-driven: the typed text is their input, so they are built where offered, never listed.
    var isQueryDriven: Bool {
        self == .openInBrowser || self == .runShellCommand
    }

    /// A chord carries no query, and none should be able to terminate the app outright.
    var hotKeyAction: HotKeyAction? {
        isQueryDriven || self == .quit ? nil : .command(self)
    }
}
