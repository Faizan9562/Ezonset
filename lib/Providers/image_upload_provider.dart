import 'package:ezonset/Enums/viewState.dart';
import 'package:flutter/material.dart';

class ImageUploadProvider with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;
  ViewState get getviewState => _viewState;

  void setToLoading(){
    _viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle(){
    _viewState = ViewState.IDLE;
    notifyListeners();
  }
}