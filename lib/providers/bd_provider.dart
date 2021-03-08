import 'package:flutter/cupertino.dart';
import 'package:ncomics/providers/Bd.dart';
import 'dart:math';

class BdProvider with ChangeNotifier {
  // declaration
  bool _isProcessing = true;
  List<BandeDessinees> _listbd = [];

  // attribution
  bool get isProcessing => _isProcessing;

  List<BandeDessinees> get listbd {
    return [..._listbd];
  }

  List<BandeDessinees> get favoriteItems {
    return _listbd.where((prodItem) => prodItem.isFavorite).toList();
  }

  List<BandeDessinees> bycatprod(String id) {
    return _listbd.where((catList) => catList.categorieBd == id).toList();
  }

  BandeDessinees findById(String id) {
    return _listbd.firstWhere((bd) => bd.idBd == id);
  }

  findByCat(String idcat) {
    _listbd.where((element) => element.categorieBd == idcat);
    notifyListeners();
  }

  //fonction

  setIsProcessing(value) {
    _isProcessing = value;

    notifyListeners();
  }

  setBdList(List<BandeDessinees> list) {
    _listbd = list;
    notifyListeners();
  }

  getBdByCat(String cat) {
    _listbd = listbd.where((element) => element.categorieBd == cat);
    notifyListeners();
  }
}
