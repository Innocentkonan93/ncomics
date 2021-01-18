import 'package:flutter/cupertino.dart';

class BandeDessinees with ChangeNotifier {
  String idBd;
  String titleBd;
  String imageBd;
  String nomAuteur;
  String prixBd;
  String categorieBd;
  Null statutBd;
  String isRating;
  String ratingBd;
  String creatAt;
  String idUser;
  bool isFavorite;
  int likeCount;

  BandeDessinees({
    this.idBd,
      this.titleBd,
      this.imageBd,
      this.nomAuteur,
      this.prixBd,
      this.categorieBd,
      this.statutBd,
      this.isRating,
      this.ratingBd,
      this.creatAt,
      this.idUser,
    this.isFavorite = false,
    this.likeCount = 0,
  });

  BandeDessinees.fromJson(Map<String, dynamic> json) {
   idBd = json['idBd'];
    titleBd = json['titleBd'];
    imageBd = json['imageBd'];
    nomAuteur = json['nomAuteur'];
    prixBd = json['prixBd'];
    categorieBd = json['categorieBd'];
    statutBd = json['statutBd'];
    isRating = json['isRating'];
    ratingBd = json['ratingBd'];
    creatAt = json['creatAt'];
    idUser = json['idUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   data['idBd'] = this.idBd;
    data['titleBd'] = this.titleBd;
    data['imageBd'] = this.imageBd;
    data['nomAuteur'] = this.nomAuteur;
    data['prixBd'] = this.prixBd;
    data['categorieBd'] = this.categorieBd;
    data['statutBd'] = this.statutBd;
    data['isRating'] = this.isRating;
    data['ratingBd'] = this.ratingBd;
    data['creatAt'] = this.creatAt;
    data['idUser'] = this.idUser;
    return data;
  }

  void favoriteToggle() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  int _counter = 0;

  getCounter() => _counter;
  setCounter(int counter) => _counter = counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
