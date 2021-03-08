class ImageBd {
  String idImageBd;
  String fileName;
  String numEpisode;
  String idBd;
  String creatAt;

  ImageBd(
      {this.idImageBd,
      this.fileName,
      this.numEpisode,
      this.idBd,
      this.creatAt});

  ImageBd.fromJson(Map<String, dynamic> json) {
    idImageBd = json['idImageBd'];
    fileName = json['fileName'];
    numEpisode = json['numEpisode'];
    idBd = json['idBd'];
    creatAt = json['creatAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idImageBd'] = this.idImageBd;
    data['fileName'] = this.fileName;
    data['numEpisode'] = this.numEpisode;
    data['idBd'] = this.idBd;
    data['creatAt'] = this.creatAt;
    return data;
  }
}
