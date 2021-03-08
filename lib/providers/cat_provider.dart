import 'package:flutter/cupertino.dart';
import 'package:ncomics/providers/category.dart';

class CatProvider with ChangeNotifier {
  bool _isProcessing = true;
  List<Category> _categoryList = [];

  bool get isProcessing => _isProcessing;
  List<Category> get categoryList {
    return _categoryList;
  }
  

  setIsProcessing(value) {
    _isProcessing = value;
    notifyListeners();
  }

  setCategoryList(List<Category> list) {
    _categoryList = list;
    notifyListeners();
  }
}
