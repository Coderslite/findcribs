class StoryModel {
  int? id;
  String? mediaUrl;
  String? mimeType;
  String? mediaName;
  int? userId;
  String? caption;
  int? view;
  int? listingId;
  String? createdAt;

  StoryModel({
    this.id,
    this.mediaUrl,
    this.mimeType,
    this.mediaName,
    this.userId,
    this.caption,
    this.view,
    this.listingId,
    this.createdAt,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      mediaUrl: json['mediaUrl'],
      mimeType: json['mimeType'],
      userId: json['userId'],
      caption: json['caption'],
      view: json['view'],
      listingId: json['listingId'],
      createdAt: json['createdAt'],
    );
  }
}
