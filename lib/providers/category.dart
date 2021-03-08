import 'package:flutter/cupertino.dart';

class Category with ChangeNotifier {

  String idCategorie;
  String categories;
  Null categorieSlug;

  Category(
      {
      this.idCategorie,
      this.categories,
      this.categorieSlug});

  Category.fromJson(Map<String, dynamic> json) {
    idCategorie = json['idCategorie'];
    categories = json['categories'];
    categorieSlug = json['categorieSlug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idCategorie'] = this.idCategorie;
    data['categories'] = this.categories;
    data['categorieSlug'] = this.categorieSlug;
    return data;
  }
}

