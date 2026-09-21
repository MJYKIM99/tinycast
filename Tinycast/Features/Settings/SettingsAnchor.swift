/// One `Section` inside a pane, named once so the catalog and the pane cannot disagree: the search
/// result carries the anchor, the pane's `.settingsAnchor(_:)` marks the section it scrolls to.
struct SettingsAnchor: Hashable, Sendable {
    let tab: SettingsTab
    /// The `Section`'s own header text, which is also what a result's breadcrumb reads.
    let title: String
}

// Named `<pane><Section>` throughout, so the constant for a section is always guessable from it.
extension SettingsAnchor {
    static let generalGlobalShortcuts = Self(tab: .general, title: String(localized: "Global Shortcuts"))
    static let generalSearch = Self(tab: .general, title: String(localized: "Search"))
    static let generalHyperKey = Self(tab: .general, title: String(localized: "Hyper Key"))
    static let generalAppearance = Self(tab: .general, title: String(localized: "Appearance"))
    static let generalCalculator = Self(tab: .general, title: String(localized: "Calculator"))
    static let generalGeneral = Self(tab: .general, title: String(localized: "General"))

    static let applicationsSearchScopes = Self(tab: .applications, title: String(localized: "Search Scopes"))
    static let applicationsApplications = Self(tab: .applications, title: String(localized: "Applications"))

    static let systemSettingsSystemSettings = Self(
        tab: .systemSettings, title: String(localized: "System Settings"))

    static let systemActionsSystemActions = Self(
        tab: .systemActions, title: String(localized: "System Actions"))

    static let commandsCommands = Self(tab: .commands, title: String(localized: "Commands"))
    static let commandsCustomCommands = Self(tab: .commands, title: String(localized: "Custom Commands"))

    static let quicklinksQuicklinks = Self(tab: .quicklinks, title: String(localized: "Quicklinks"))
    static let quicklinksCommands = Self(tab: .quicklinks, title: String(localized: "Commands"))
    static let quicklinksBehaviour = Self(tab: .quicklinks, title: String(localized: "Behaviour"))
    static let quicklinksImportExport = Self(tab: .quicklinks, title: String(localized: "Import & Export"))

    static let appleShortcutsAppleShortcuts = Self(
        tab: .appleShortcuts, title: String(localized: "Apple Shortcuts"))
    static let appleShortcutsShortcuts = Self(tab: .appleShortcuts, title: String(localized: "Shortcuts"))

    static let fallbacksFallbacks = Self(tab: .fallbacks, title: String(localized: "Fallbacks"))

    static let aiAI = Self(tab: .ai, title: String(localized: "AI"))
    static let aiProviders = Self(tab: .ai, title: String(localized: "Providers"))
    static let aiDefault = Self(tab: .ai, title: String(localized: "Default"))
    static let aiChat = Self(tab: .ai, title: String(localized: "Chat"))
    static let aiConversations = Self(tab: .ai, title: String(localized: "Conversations"))
    static let aiSystemPrompt = Self(tab: .ai, title: String(localized: "System prompt"))
    static let aiInstalledAI = Self(tab: .ai, title: String(localized: "Installed AI"))
    static let aiAPIConnections = Self(tab: .ai, title: String(localized: "API Connections"))
    static let aiMCPServers = Self(tab: .ai, title: String(localized: "MCP Servers"))
    static let aiCommands = Self(tab: .ai, title: String(localized: "Commands"))

    static let quickActionsQuickActions = Self(tab: .quickActions, title: String(localized: "Quick Actions"))
    static let quickActionsActions = Self(tab: .quickActions, title: String(localized: "Actions"))
    static let quickActionsModel = Self(tab: .quickActions, title: String(localized: "Model"))
    static let quickActionsTranslate = Self(tab: .quickActions, title: String(localized: "Translate"))

    static let fileSearchFileSearch = Self(tab: .fileSearch, title: String(localized: "File Search"))
    static let fileSearchCommands = Self(tab: .fileSearch, title: String(localized: "Commands"))
    static let fileSearchSearchScopes = Self(tab: .fileSearch, title: String(localized: "Search Scopes"))
    static let fileSearchIgnorePatterns = Self(tab: .fileSearch, title: String(localized: "Ignore Patterns"))

    static let notesNotes = Self(tab: .notes, title: String(localized: "Notes"))
    static let notesCommands = Self(tab: .notes, title: String(localized: "Commands"))

    static let snippetsSnippets = Self(tab: .snippets, title: String(localized: "Snippets"))
    static let snippetsCommands = Self(tab: .snippets, title: String(localized: "Commands"))
    static let snippetsLibrary = Self(tab: .snippets, title: String(localized: "Library"))

    static let navigationNavigation = Self(tab: .navigation, title: String(localized: "Navigation"))
    static let navigationCommands = Self(tab: .navigation, title: String(localized: "Commands"))
    static let navigationMenuSearch = Self(
        tab: .navigation, title: String(localized: "Search Menu Bar Items"))

    static let windowManagementWindowManagement = Self(
        tab: .windowManagement, title: String(localized: "Window Management"))
    static let windowManagementLayouts = Self(
        tab: .windowManagement, title: String(localized: "Window Layouts"))
    static let windowManagementLayoutCommands = Self(
        tab: .windowManagement, title: String(localized: "Layout Commands"))
    static let windowManagementOptions = Self(tab: .windowManagement, title: String(localized: "Options"))
    static let windowManagementCustomSizes = Self(
        tab: .windowManagement, title: String(localized: "Custom Sizes"))

    static let clipboardClipboard = Self(tab: .clipboard, title: String(localized: "Clipboard"))
    static let clipboardCommands = Self(tab: .clipboard, title: String(localized: "Commands"))
    static let clipboardHistory = Self(tab: .clipboard, title: String(localized: "History"))
    static let clipboardDisabledApplications = Self(
        tab: .clipboard, title: String(localized: "Disabled Applications"))

    static let emojiCommands = Self(tab: .emoji, title: String(localized: "Commands"))
    static let emojiAppearance = Self(tab: .emoji, title: String(localized: "Appearance"))

    static let calendarCalendar = Self(tab: .calendar, title: String(localized: "Calendar"))
    static let calendarCommands = Self(tab: .calendar, title: String(localized: "Commands"))
    static let calendarSchedule = Self(tab: .calendar, title: String(localized: "Schedule"))
    static let calendarJoining = Self(tab: .calendar, title: String(localized: "Joining"))
    static let calendarMenuBar = Self(tab: .calendar, title: String(localized: "Menu Bar"))
    static let calendarCalendars = Self(tab: .calendar, title: String(localized: "Calendars"))

    static let extensionsExtensions = Self(tab: .extensions, title: String(localized: "Extensions"))
    static let extensionsCompatibility = Self(tab: .extensions, title: String(localized: "Compatibility"))
    static let extensionsInstalled = Self(tab: .extensions, title: String(localized: "Installed"))
    static let extensionsInstall = Self(tab: .extensions, title: String(localized: "Install"))
    static let extensionsStorage = Self(tab: .extensions, title: String(localized: "Storage"))

    static let permissionsAccessibility = Self(tab: .permissions, title: String(localized: "Accessibility"))
    static let permissionsCalendars = Self(tab: .permissions, title: String(localized: "Calendars"))

    static let backupExport = Self(tab: .backup, title: String(localized: "Export"))
    static let backupImport = Self(tab: .backup, title: String(localized: "Import"))
    static let backupImportFromRaycast = Self(tab: .backup, title: String(localized: "Import from Raycast"))

    static let aboutAbout = Self(tab: .about, title: String(localized: "About"))
    static let aboutLinks = Self(tab: .about, title: String(localized: "Links"))
}

/// Where a search result lands: a whole section, or one row inside it.
enum SettingsTarget: Hashable, Sendable {
    case section(SettingsAnchor)
    /// The row's visible title, which is also the catalog entry's — they are the same string.
    case row(SettingsAnchor, String)

    var anchor: SettingsAnchor {
        switch self {
        case .section(let anchor), .row(let anchor, _): return anchor
        }
    }

    var tab: SettingsTab { anchor.tab }
}

/// One jump asked for by a search result. The token is what makes picking the same result twice
/// scroll and pulse again, rather than comparing equal and doing nothing.
struct SettingsScrollRequest: Equatable, Sendable {
    let target: SettingsTarget
    let token: Int
}
