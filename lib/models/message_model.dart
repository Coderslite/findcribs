class MessageModel {
  int? id;
  int? chatId;
  int? receiverId;
  String? message;
  String? type;
  String? status;
  Map? sender;
  String? createdAt;
  String? updatedAt;

  MessageModel({
    this.id,
    this.chatId,
    this.receiverId,
    this.message,
    this.type,
    this.status,
    this.sender,
    this.createdAt,
    this.updatedAt,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      chatId: json['chatId'],
      receiverId: json['receiverId'],
      message: json['message'],
      type: json['type'],
      status: json['status'],
      sender: json['sender'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
