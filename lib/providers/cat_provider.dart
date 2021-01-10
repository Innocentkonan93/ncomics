import 'package:flutter/material.dart';
import 'package:ncomics/providers/categories.dart';

class CatProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<Categories> _listCat = [];

  bool get isProcessing => _isProcessing;

  List<Categories> get listCat {
    return [..._listCat];
  }

  setCatList(List<Categories> list) {
    _listCat = list;
    notifyListeners();
  }

  setIsProcessing(value) {
    _isProcessing = value;
    notifyListeners();
  }
}
