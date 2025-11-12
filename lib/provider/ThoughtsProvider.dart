import 'package:flutter/material.dart';



class Thoughtsprovider extends ChangeNotifier {

  bool _Analyzed = false;
  bool _FillTitle = false;
  bool _FillText = false;
  String _NoteText = "";
  String _Advice = "";
  String _Emotion = "";



  bool get isAnalyzed => _Analyzed;
  bool get isFillTitle => _FillTitle;
  bool get isFillText => _FillText;
  String get NoteText => _NoteText;
  String get Advice => _Advice;
  String get Emotion => _Emotion;



  void ToggleAnalyzed(bool value){
    _Analyzed = value;
    notifyListeners();
  }

  void ToggleEmptyTitle(bool value){
    _FillTitle = value;
    notifyListeners();
  }

  void ToggleEmptyText(bool value){
    _FillText = value;
    notifyListeners();
  }


  void UpdateNote(String NoteText){
    _NoteText = NoteText;
    notifyListeners();
  }

  void UpdateAdvice(String Advice){
    _Advice = Advice;
    notifyListeners();
  }

  void UpdateEmotion(String Emotion){
    _Emotion = Emotion;
    notifyListeners();
  }


  void ResetAll() {
    _Analyzed = false;
    _FillText = false;
    _FillTitle = false;
  }

}