//
//  AppIntent.swift
//  QadrWidget
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Qadr Prayer Widget" }
    static var description: IntentDescription { "Следующий намаз" }
    // No configurable parameters — widget reads data from the app automatically
}
