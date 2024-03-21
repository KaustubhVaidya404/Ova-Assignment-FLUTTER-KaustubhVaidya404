import 'package:chatlily/api/apikey.dart';
import 'package:chatlily/models/ai_message.dart';
import 'package:chatlily/models/request_model.dart';
import 'package:chatlily/models/response_model.dart';
import 'package:http/http.dart' as http;

class AiService {
  static final Uri chatUri =
      Uri.parse('https://api.openai.com/v1/chat/completions');

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey.apikey}',
  };

  Future<String?> promptRequest(String prompt) async {
    try {
      RequestModel requestModel = RequestModel(
          model: "gpt-4",
          messages: [
            AiMessage(
                role: "system",
                content:
                    prompt)
          ],
          maxTokens: 150);
      if (prompt.isEmpty) {
        return null;
      }
      http.Response response = await http.post(
        chatUri,
        headers: headers,
        body: requestModel.toJson(),
      );
      ResponseModel responseModel = ResponseModel.fromResponse(response);
      //print(responseModel.choices?[0].message?.content);
      return responseModel.choices?[0].message?.content;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
