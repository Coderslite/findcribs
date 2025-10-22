class UserProfile {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImg;
  String? phoneNumber;
  String? category;
  String? whatsappNo;
  bool? verifyEmail;
  Map? agent;
  int? storyCount;
  int? listingCount;
  int? favouritedAgentCount;
  int? favouritingAgentCount;
  String? createdAt;
  String? updatedAt;
  Map? subscriptionLogs;
  // String? businessName;

  UserProfile({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImg,
    this.phoneNumber,
    this.whatsappNo,
    this.category,
    this.verifyEmail,
    this.createdAt,
    this.updatedAt,
    this.agent,
    this.favouritedAgentCount,
    this.favouritingAgentCount,
    this.storyCount,
    this.listingCount,
    this.subscriptionLogs,
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
      whatsappNo: json['whatsapp_number'].toString(),
      category: json['category'],
      verifyEmail: json['verify_email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      agent: json['agent'],
      storyCount: json['story_count'],
      favouritedAgentCount: json['favouritedAgentCount'],
      favouritingAgentCount: json['favouritingAgentCount'],
      listingCount: json['listing_count'],
      subscriptionLogs: json['subscriptionLogs'],
      // businessName: json['agent']['business_name'],
    );
  }
}
