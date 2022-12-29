class StoryListModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;
  List? moment;

  StoryListModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePic,
    this.moment,
  });

  factory StoryListModel.fromJson(Map<String, dynamic> json) {
    return StoryListModel(
        id: json['friend']['id'],
        firstName: json['friend']['first_name'],
        lastName: json['friend']['last_name'],
        email: json['friend']['email'],
        profilePic: json['friend']['profile_pic'],
        moment: json['friend']['moment']);
  }
}
