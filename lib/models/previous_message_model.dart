class PreviousMessageModel {
  int? id;
  String? messageType;
  String? content;
  String? chatId;
  int? senderId;
  int? recieverId;
  String? createdAt;
  String? updatedAt;

  PreviousMessageModel({
    this.id,
    this.messageType,
    this.content,
    this.chatId,
    this.senderId,
    this.recieverId,
    this.createdAt,
    this.updatedAt,
  });

  factory PreviousMessageModel.fromJson(Map<String, dynamic> json) {
    return PreviousMessageModel(
      id: json['id'],
      messageType: json['message_type'],
      content: json['content'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      recieverId: json['reciever_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
