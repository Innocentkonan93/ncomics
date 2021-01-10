class ImageBd {

  String idImageBd;
  String nameFile;
  String idBd;
  String creatAt;

  ImageBd(
      {
      this.idImageBd,
      this.nameFile,
      this.idBd,
      this.creatAt});

  ImageBd.fromJson(Map<String, dynamic> json) {
   
    idImageBd = json['idImageBd'];
    nameFile = json['nameFile'];
    idBd = json['idBd'];
    creatAt = json['creatAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['idImageBd'] = this.idImageBd;
    data['nameFile'] = this.nameFile;
    data['idBd'] = this.idBd;
    data['creatAt'] = this.creatAt;
    return data;
  }
}

