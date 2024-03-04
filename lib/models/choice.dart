import 'package:chatlily/models/ai_message.dart';

class Choice {
  final int? index;
  final AiMessage? message;
  final String? finishReason;

  Choice(this.index, this.message, this.finishReason);

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      json['index'],
      AiMessage.fromJson(json['message']),
      json['finish_reason'],
    );
  }
}
