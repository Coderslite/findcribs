class UserUnFavouritedAgentModel {
  int? id;
  int? connection;
  int? userId;
  int? friendId;
  String? createdAt;
  String? updatedAt;
  String? profilePic;
  String? businessName;
  String? category;
  bool? isVerified;

  UserUnFavouritedAgentModel({
    this.id,
    this.connection,
    this.userId,
    this.friendId,
    this.createdAt,
    this.updatedAt,
    this.profilePic,
    this.businessName,
    this.category,
    this.isVerified,
  });

  factory UserUnFavouritedAgentModel.fromJson(Map<String, dynamic> json) {
    return UserUnFavouritedAgentModel(
      id: json['id'],
      // connection: json['connection'],
      userId: json['agent']['userId'],
      // friendId: json['friendId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      profilePic: json['profile_pic'],
      businessName: json['agent']['business_name'],
      category: json['agent']['category'],
      isVerified: json['is_verified'],
    );
  }
}
