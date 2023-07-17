class SearchAgentModel {
  int? id;
  String? firstName;
  String? lastName;
  String? businessName;
  bool? verified;
  List? followers;
  String? profilePic;

  SearchAgentModel({
    this.id,
    this.firstName,
    this.lastName,
    this.businessName,
    this.verified,
    this.followers,
    this.profilePic,
  });

  factory SearchAgentModel.fromJson(Map<String, dynamic> json) {
    return SearchAgentModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      businessName: json['agent']['business_name'],
      verified: json['is_verified'],
      followers: json['friend'],
      profilePic: json['profile_pic'],
    );
  }
}
