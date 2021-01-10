import 'package:flutter/cupertino.dart';

class BandeDessinees with ChangeNotifier {
  String idBd;
  String titleBd;
  String imageBd;
  String prixBd;
  String categorieBd;
  String statutBd;
  String creatAt;
  bool isFavorite;

  BandeDessinees({
    this.idBd,
    this.titleBd,
    this.imageBd,
    this.prixBd,
    this.categorieBd,
    this.statutBd,
    this.creatAt,
    this.isFavorite = false,
  });

  BandeDessinees.fromJson(Map<String, dynamic> json) {
    idBd = json['idBd'];
    titleBd = json['titleBd'];
    imageBd = json['imageBd'];
    prixBd = json['prixBd'];
    categorieBd = json['categorieBd'];
    statutBd = json['statutBd'];
    creatAt = json['creatAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBd'] = this.idBd;
    data['titleBd'] = this.titleBd;
    data['imageBd'] = this.imageBd;
    data['prixBd'] = this.prixBd;
    data['categorieBd'] = this.categorieBd;
    data['statutBd'] = this.statutBd;
    data['creatAt'] = this.creatAt;
    return data;
  }

  void favoriteToggle() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
