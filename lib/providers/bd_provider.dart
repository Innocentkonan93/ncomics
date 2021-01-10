import 'package:flutter/cupertino.dart';
import 'package:ncomics/providers/Bd.dart';

class BdProvider extends ChangeNotifier {
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

  BandeDessinees findById(String id) {
    return _listbd.firstWhere((bd) => bd.idBd == id);
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

  addBdList(List<BandeDessinees> list) {
    _listbd.addAll(list);
    notifyListeners();
  }

  getBdById(List<BandeDessinees> list, String categorie) {
    _listbd = list.where((element) => element.categorieBd == categorie);
    notifyListeners();
  }

  getBdByCat(String cat) {
    _listbd = listbd.where((element) => element.categorieBd == cat);
    notifyListeners();
  }
}
