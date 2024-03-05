import 'dart:convert';
import 'package:chatlily/models/choice.dart';
import 'package:chatlily/models/usage.dart';
import 'package:http/http.dart';

class ResponseModel {
  final String? id;
  final String object;
  final int? created;
  final String? model;
  final List<Choice>? choices;
  final Usage usage;

  const ResponseModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory ResponseModel.fromResponse(Response response) {
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> parsedBody = json.decode(responseBody);
    return ResponseModel(
      id: parsedBody['id'],
      object: parsedBody['object'],
      created: parsedBody['created'],
      model: parsedBody['model'],
      choices: List<Choice>.from(
          parsedBody['choices'].map((choice) => Choice.fromJson(choice))),
      usage: Usage.fromJson(parsedBody['usage']),
    );
  }
}
