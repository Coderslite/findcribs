class UserProfile {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImg;
  String? phoneNumber;
  String? category;
  bool? verifyEmail;
  Map? agent;
  int? storyCount;
  int? listingCount;
  String? createdAt;
  String? updatedAt;
  // String? businessName;

  UserProfile({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImg,
    this.phoneNumber,
    this.category,
    this.verifyEmail,
    this.createdAt,
    this.updatedAt,
    this.agent,
    this.storyCount,
    this.listingCount,
    // this.businessName,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImg: json['profile_pic'],
      phoneNumber: json['phone_number'],
      category: json['category'],
      verifyEmail: json['verify_email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      agent: json['agent'],
      storyCount: json['story_count'],
      listingCount: json['listing_count'],
      // businessName: json['agent']['business_name'],
    );
  }
}
