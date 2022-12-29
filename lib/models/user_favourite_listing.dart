class UserFavouritedListingModel {
  int? id;
  int? userId;
  int? listingId;
  bool? isLiked;
  String? createdAt;
  String? updatedAt;
  Map? listing;

  UserFavouritedListingModel({
    this.id,
    this.userId,
    this.listingId,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
    this.listing,
  });

  factory UserFavouritedListingModel.fromJson(Map<String, dynamic> json) {
    return UserFavouritedListingModel(
        id: json['id'],
        userId: json['userId'],
        listingId: json['listingId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        listing: json['listing']);
  }
}
