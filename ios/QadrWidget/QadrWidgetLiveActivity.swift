//
//  QadrWidgetLiveActivity.swift
//  QadrWidget
//
//  Created by Vyacheslav Pak on 23/04/2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct QadrWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct QadrWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: QadrWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension QadrWidgetAttributes {
    fileprivate static var preview: QadrWidgetAttributes {
        QadrWidgetAttributes(name: "World")
    }
}

extension QadrWidgetAttributes.ContentState {
    fileprivate static var smiley: QadrWidgetAttributes.ContentState {
        QadrWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: QadrWidgetAttributes.ContentState {
         QadrWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: QadrWidgetAttributes.preview) {
   QadrWidgetLiveActivity()
} contentStates: {
    QadrWidgetAttributes.ContentState.smiley
    QadrWidgetAttributes.ContentState.starEyes
}
