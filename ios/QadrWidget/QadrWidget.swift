//
//  QadrWidget.swift
//  QadrWidget
//

import WidgetKit
import SwiftUI

private let appGroup = "group.com.qadrapp"

// MARK: - Entry

struct PrayerEntry: TimelineEntry {
    let date: Date
    let prayerName: String
    let prayerTime: Date
    let cityName: String
}

// MARK: - Provider

struct QadrWidgetProvider: AppIntentTimelineProvider {

    func placeholder(in context: Context) -> PrayerEntry {
        PrayerEntry(
            date: .now,
            prayerName: "Asr",
            prayerTime: .now.addingTimeInterval(5400),
            cityName: ""
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> PrayerEntry {
        makeEntry()
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<PrayerEntry> {
        let entry = makeEntry()
        // Reload after the prayer time — the app will write fresh data on next open
        return Timeline(entries: [entry], policy: .after(entry.prayerTime))
    }

    private func makeEntry() -> PrayerEntry {
        let defaults = UserDefaults(suiteName: appGroup)
        let name     = defaults?.string(forKey: "qadr_next_prayer_name") ?? "–"
        let city     = defaults?.string(forKey: "qadr_city_name") ?? ""
        let timeISO  = defaults?.string(forKey: "qadr_next_prayer_time") ?? ""
        let time     = ISO8601DateFormatter().date(from: timeISO) ?? .now.addingTimeInterval(5400)
        return PrayerEntry(date: .now, prayerName: name, prayerTime: time, cityName: city)
    }
}

// MARK: - View

struct QadrWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let entry: PrayerEntry

    var body: some View {
        switch family {
        case .accessoryRectangular:
            rectangularView
        case .accessoryCircular:
            circularView
        case .accessoryInline:
            inlineView
        default:
            mediumView
        }
    }

    private var mediumView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Text("Qadr")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                Spacer()
                if !entry.cityName.isEmpty {
                    Text(entry.cityName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()

            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("🕌")
                    .font(.system(size: 28))

                VStack(alignment: .leading, spacing: 3) {
                    Text(entry.prayerName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    Text(entry.prayerTime, style: .time)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(entry.prayerTime, style: .relative)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }

            Spacer()
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }

    private var rectangularView: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text("🕌")
                Text(entry.prayerName)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            Text(entry.prayerTime, style: .time)
                .font(.subheadline)
            Text(entry.prayerTime, style: .relative)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }

    private var circularView: some View {
        VStack(spacing: 2) {
            Text("🕌")
                .font(.title3)
            Text(entry.prayerName)
                .font(.caption2)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.7)
            Text(entry.prayerTime, style: .timer)
                .font(.caption2)
                .minimumScaleFactor(0.5)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }

    private var inlineView: some View {
        Label {
            Text("\(entry.prayerName) · ") + Text(entry.prayerTime, style: .relative)
        } icon: {
            Text("🕌")
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

// MARK: - Widget

struct QadrWidget: Widget {
    let kind: String = "QadrWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: QadrWidgetProvider()
        ) { entry in
            QadrWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Qadr")
        .description("Следующий намаз")
        .supportedFamilies([.systemMedium, .accessoryRectangular, .accessoryCircular, .accessoryInline])
    }
}

// MARK: - Preview

#Preview(as: .systemMedium) {
    QadrWidget()
} timeline: {
    PrayerEntry(date: .now, prayerName: "Asr",    prayerTime: .now.addingTimeInterval(5400), cityName: "Kazan")
    PrayerEntry(date: .now, prayerName: "Maghrib", prayerTime: .now.addingTimeInterval(9000), cityName: "Kazan")
}

#Preview(as: .accessoryRectangular) {
    QadrWidget()
} timeline: {
    PrayerEntry(date: .now, prayerName: "Asr", prayerTime: .now.addingTimeInterval(5400), cityName: "Kazan")
}

#Preview(as: .accessoryCircular) {
    QadrWidget()
} timeline: {
    PrayerEntry(date: .now, prayerName: "Asr", prayerTime: .now.addingTimeInterval(5400), cityName: "Kazan")
}
