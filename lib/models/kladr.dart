class Kladr {
  String code;
  String name;
  String fullName;
  String okato;
  String postIndex;

  Kladr(this.code, this.name, this.fullName, this.okato, this.postIndex);

  Kladr.fromJson(Map<String, dynamic> json)
      : code = json['Code'],
        name = json['Name'],
        fullName = json['FullName'],
        okato = json['Okato'],
        postIndex = json['PostIndex'];
}