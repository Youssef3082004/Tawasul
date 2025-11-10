import 'package:flutter/material.dart';



class Thoughtsprovider extends ChangeNotifier {

  bool _Analyzed = false;
  bool _FillTitle = false;
  bool _FillText = false;


  bool get isAnalyzed => _Analyzed;
  bool get isFillTitle => _FillTitle;
  bool get isFillText => _FillText;


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


  void ResetAll() {
    _Analyzed = false;
    _FillText = false;
    _FillTitle = false;
  }

}