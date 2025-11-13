import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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



static Future<void> saveUserState({required String Value}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('Loggedin', Value);
}

static Future<String> loadUserState() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Loggedin') ?? "No";
  } catch (e) {
    return "No";
  }
}




}