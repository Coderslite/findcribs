class FavouriteStoryListModel {
  int id;
  int userid;
  String descr;
  String createdat;
  String type;
  String fonttype;
  int fontsize;
  String color;
  String bgcolor;
  String updatedat;

  FavouriteStoryListModel({
    required this.id,
    required this.userid,
    required this.descr,
    required this.createdat,
    required this.type,
    required this.fonttype,
    required this.fontsize,
    required this.color,
    required this.bgcolor,
    required this.updatedat,
  });

  factory FavouriteStoryListModel.fromJson(Map<String, dynamic> json) {
    return FavouriteStoryListModel(
      id: json['id'],
      userid: json['id'],
      descr: json['descr'],
      createdat: json['created_at'],
      type: json['type'],
      fonttype: json['font_type'],
      fontsize: json['font_size'],
      color: json['color'],
      bgcolor: json['bkg_color'],
      updatedat: json['updated_at'],
    );
  }
}
