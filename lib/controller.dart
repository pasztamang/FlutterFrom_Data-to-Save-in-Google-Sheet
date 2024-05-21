import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'model/form.dart';

class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL = "https://script.google.com/macros/s/AKfycbw-NAEp7DJ8uGhBa5Vb2NyMMhQO-UFRFi-mMVCGW4LUT9D-YIsJ2NSgNN37dFJAqaUe/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      // Log the parameters for debugging
      print('Submitting form with the following parameters: ${feedbackForm.toParams()}');

      // Create URI and encode parameters
      final uri = Uri.parse(URL);
      final newUri = uri.replace(queryParameters: feedbackForm.toParams());

      // Log the full URL for debugging
      print('Requesting URL: $newUri');

      final response = await http.get(newUri);

      // Log the response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseBody = convert.jsonDecode(response.body);

      // Log the parsed JSON for debugging
      print('Parsed response: $responseBody');

      callback(responseBody['status']);
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
