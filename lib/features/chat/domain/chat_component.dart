/// Mixin for chat component widgets that the LLM can render.
///
/// Every widget displayed in the chat as a component must implement this mixin.
/// It provides a contract for serializing the widget's display data to JSON,
/// enabling the LLM to maintain context about what was shown to the user.
mixin ChatComponent {
  /// Returns the component's display data as a JSON-serializable map.
  ///
  /// The map must include a `type` key identifying the component type
  /// and all relevant data the LLM needs to understand what was shown.
  Map<String, dynamic> toContextJson();
}
