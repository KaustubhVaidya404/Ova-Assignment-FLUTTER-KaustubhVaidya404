class AiMessage {
  final String? role;
  final String? content;

  AiMessage({this.role, this.content});

  factory AiMessage.fromJson(Map<String, dynamic> json) {
    return AiMessage(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
