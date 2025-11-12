import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:http/http.dart' as http;

class PublicFunction{

  static Future<String> GiminiAdvice({required String usernote , required String emotion}) async{

    final Prompt = """
    You are an empathetic advisor. Read the following user note and its detected sentiment, then provide a short personalized piece of advice.  
    The advice must:  
    - Be exactly 20–25 words long.  
    - Match the sentiment and context of the note.  
    - Sound natural, motivational, and emotionally appropriate.  

    User note: "{{$usernote}}"  
    Detected sentiment: "{{$emotion}}"  

    Give your response as plain text only.

    """;

    final parts = [Part.text(Prompt)];
    final response = await Gemini.instance.prompt(parts: parts);
    return response?.output?? 'No response generated';

  }

  static Future<bool> hasInternet() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }



}