import WidgetKit
import SwiftUI

private let appGroupId = "group.com.diegolousx.kt_challenge"

struct CharacterWidgetEntry: TimelineEntry {
    let date: Date
    let favoritesCount: Int
    let lastUpdated: String
}

struct CharacterWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> CharacterWidgetEntry {
        CharacterWidgetEntry(date: Date(), favoritesCount: 0, lastUpdated: "—")
    }

    func getSnapshot(in context: Context, completion: @escaping (CharacterWidgetEntry) -> Void) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CharacterWidgetEntry>) -> Void) {
        let entry = loadEntry()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date().addingTimeInterval(1800)
        completion(Timeline(entries: [entry], policy: .after(refreshDate)))
    }

    private func loadEntry() -> CharacterWidgetEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let favoritesCount = defaults?.integer(forKey: "favorites_count") ?? 0
        let lastUpdated = defaults?.string(forKey: "last_updated") ?? "—"
        return CharacterWidgetEntry(date: Date(), favoritesCount: favoritesCount, lastUpdated: lastUpdated)
    }
}

struct CharacterWidgetEntryView: View {
    var entry: CharacterWidgetProvider.Entry

    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.95, blue: 0.88)
            VStack(alignment: .leading, spacing: 6) {
                Text(LocalizedStringKey("widget_title"))
                    .font(.headline)
                    .foregroundColor(Color(red: 0.9, green: 0.38, blue: 0.0))
                Text(LocalizedStringKey("widget_favorites"))
                    .font(.caption)
                    .foregroundColor(Color(red: 0.43, green: 0.3, blue: 0.25))
                Text("\(entry.favoritesCount)")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.9, green: 0.38, blue: 0.0))
                Text("\(LocalizedStringKey(\"widget_updated\")) \(entry.lastUpdated)")
                    .font(.caption2)
                    .foregroundColor(Color(red: 0.55, green: 0.43, blue: 0.39))
            }
            .padding(12)
        }
    }
}

@main
struct CharacterWidget: Widget {
    let kind: String = "CharacterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CharacterWidgetProvider()) { entry in
            CharacterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(LocalizedStringKey("widget_display_name"))
        .description(LocalizedStringKey("widget_description"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
