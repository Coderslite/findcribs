// // To parse this JSON data, do
// //
// //     final unfavouritedAgentModel = unfavouritedAgentModelFromJson(jsonString);

// import 'dart:convert';

// UnfavouritedAgentModel unfavouritedAgentModelFromJson(String str) => UnfavouritedAgentModel.fromJson(json.decode(str));

// String unfavouritedAgentModelToJson(UnfavouritedAgentModel data) => json.encode(data.toJson());

// class UnfavouritedAgentModel {
//     UnfavouritedAgentModel({
//       required this.status,
//       required  this.message,
//       required  this.data,
//     });

//     bool status;
//     String message;
//     Data data;

//     factory UnfavouritedAgentModel.fromJson(Map<String, dynamic> json) => UnfavouritedAgentModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     Data({
//         required this.agents,
//        required this.pagination,
//     });

//     List<AgentElement> agents;
//     Pagination pagination;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         agents: List<AgentElement>.from(json["agents"].map((x) => AgentElement.fromJson(x))),
//         pagination: Pagination.fromJson(json["pagination"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "agents": List<dynamic>.from(agents.map((x) => x.toJson())),
//         "pagination": pagination.toJson(),
//     };
// }

// class AgentElement {
//     AgentElement({
//     required   this.id,
//     required   this.lastName,
//     required   this.firstName,
//     required   this.email,
//     required   this.password,
//     required   this.phoneNumber,
//    required    this.profilePic,
//    required    this.profilePicKey,
//    required    this.isVerified,
//    required    this.verifyEmail,
//    required    this.favoriteCount,
//    required    this.listingCount,
//    required    this.availability,
//    required    this.deviceToken,
//    required    this.category,
//    required    this.address,
//       required  this.googleId,
//       required  this.googleAccessToken,
//       required  this.facebookId,
//       required  this.facebookAccessToken,
//       required  this.createdAt,
//       required  this.updatedAt,
//       required  this.agent,
//       required  this.friend,
//     });

//     int id;
//     String lastName;
//     String firstName;
//     String email;
//     String password;
//     String phoneNumber;
//     String profilePic;
//     dynamic profilePicKey;
//     bool isVerified;
//     bool verifyEmail;
//     int favoriteCount;
//     int listingCount;
//     String availability;
//     String deviceToken;
//     String category;
//     String address;
//     dynamic googleId;
//     dynamic googleAccessToken;
//     dynamic facebookId;
//     dynamic facebookAccessToken;
//     DateTime createdAt;
//     DateTime updatedAt;
//     AgentAgent agent;
//     List<dynamic> friend;

//     factory AgentElement.fromJson(Map<String, dynamic> json) => AgentElement(
//         id: json["id"],
//         lastName: json["last_name"],
//         firstName: json["first_name"],
//         email: json["email"],
//         password: json["password"],
//         phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
//         profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
//         profilePicKey: json["profile_pic_key"],
//         isVerified: json["is_verified"],
//         verifyEmail: json["verify_email"],
//         favoriteCount: json["favorite_count"],
//         listingCount: json["listing_count"],
//         availability: json["availability"] == null ? null : json["availability"],
//         deviceToken: json["deviceToken"] == null ? null : json["deviceToken"],
//         category: json["category"],
//         address: json["address"] == null ? null : json["address"],
//         googleId: json["googleId"],
//         googleAccessToken: json["googleAccessToken"],
//         facebookId: json["facebookId"],
//         facebookAccessToken: json["facebookAccessToken"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         agent: AgentAgent.fromJson(json["agent"]),
//         friend: List<dynamic>.from(json["friend"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "last_name": lastName,
//         "first_name": firstName,
//         "email": email,
//         "password": password,
//         "phone_number": phoneNumber == null ? null : phoneNumber,
//         "profile_pic": profilePic == null ? null : profilePic,
//         "profile_pic_key": profilePicKey,
//         "is_verified": isVerified,
//         "verify_email": verifyEmail,
//         "favorite_count": favoriteCount,
//         "listing_count": listingCount,
//         "availability": availability == null ? null : availability,
//         "deviceToken": deviceToken == null ? null : deviceToken,
//         "category": category,
//         "address": address == null ? null : address,
//         "googleId": googleId,
//         "googleAccessToken": googleAccessToken,
//         "facebookId": facebookId,
//         "facebookAccessToken": facebookAccessToken,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "agent": agent.toJson(),
//         "friend": List<dynamic>.from(friend.map((x) => x)),
//     };
// }

// class AgentAgent {
//     AgentAgent({
//       required  this.id,
//       required  this.parentId,
//       required  this.userId,
//       required  this.category,
//       required  this.staffNo,
//       required  this.fullName,
//       required  this.isVerified,
//       required  this.phoneNumber,
//       required  this.businessName,
//        required this.about,
//       required  this.availability,
//       required  this.systemManaged,
//       required  this.createdAt,
//       required  this.updatedAt,
//     });

//     int id;
//     dynamic parentId;
//     int userId;
//     String category;
//     String staffNo;
//     String fullName;
//     bool isVerified;
//     String phoneNumber;
//     String businessName;
//     String about;
//     String availability;
//     bool systemManaged;
//     DateTime createdAt;
//     DateTime updatedAt;

//     factory AgentAgent.fromJson(Map<String, dynamic> json) => AgentAgent(
//         id: json["id"],
//         parentId: json["parentId"],
//         userId: json["userId"],
//         category: json["category"],
//         staffNo: json["staff_no"] == null ? null : json["staff_no"],
//         fullName: json["full_name"],
//         isVerified: json["is_verified"],
//         phoneNumber: json["phone_number"],
//         businessName: json["business_name"],
//         about: json["about"],
//         availability: json["availability"],
//         systemManaged: json["systemManaged"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "parentId": parentId,
//         "userId": userId,
//         "category": category,
//         "staff_no": staffNo == null ? null : staffNo,
//         "full_name": fullName,
//         "is_verified": isVerified,
//         "phone_number": phoneNumber,
//         "business_name": businessName,
//         "about": about,
//         "availability": availability,
//         "systemManaged": systemManaged,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//     };
// }

// class Pagination {
//     Pagination({
//         required this.currentPage,
//         required this.pageSize,
//         required this.totalPages,
//     });

//     int currentPage;
//     int pageSize;
//     int totalPages;

//     factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         currentPage: json["currentPage"],
//         pageSize: json["pageSize"],
//         totalPages: json["totalPages"],
//     );

//     Map<String, dynamic> toJson() => {
//         "currentPage": currentPage,
//         "pageSize": pageSize,
//         "totalPages": totalPages,
//     };
// }
