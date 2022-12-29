class NotificationModel {
  int? id;
  int? userId;
  String? type;
  String? description;
  int? refId;
  bool? isRead;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.userId,
    this.type,
    this.description,
    this.refId,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      description: json['description'],
      refId: json['refId'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
