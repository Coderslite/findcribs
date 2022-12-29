class MostFavouritedModel {
  int? id;
  // int? parentId;
  int? userId;
  String? category;
  // int? staffNo;
  String? fullName;
  bool? isVerified;
  String? phoneNumber;
  String? businessName;
  String? about;
  String? availability;
  String? manageBy;
  String? createdAt;
  String? updatedAt;
  String? profileImg;
  MostFavouritedModel({
    this.id,
    // this.parentId,
    this.userId,
    this.category,
    // this.staffNo,
    this.fullName,
    this.isVerified,
    this.phoneNumber,
    this.businessName,
    this.about,
    this.availability,
    this.manageBy,
    this.createdAt,
    this.updatedAt,
    this.profileImg,
  });
  factory MostFavouritedModel.fromJson(Map<String, dynamic> json) {
    return MostFavouritedModel(
        id: json['id'],
        // parentId: json['parentId'],
        userId: json['userId'],
        category: json['category'],
        // staffNo: json['staff_no'],
        fullName: json['full_name'],
        isVerified: json['is_verified'],
        phoneNumber: json['phone_number'],
        businessName: json['business_name'],
        about: json['about'],
        availability: json['availability'],
        manageBy: json['manage_by'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        profileImg: json['user']['profile_pic']);
  }
}
