class StateLgaModel {
  String? state;
  String? alias;
  List? lgas;

  StateLgaModel({this.state, this.alias, this.lgas});

  factory StateLgaModel.fromJson(Map<String, dynamic> json) {
    return StateLgaModel(
        state: json['state'], alias: json['alias'], lgas: json['lgas']);
  }
}
