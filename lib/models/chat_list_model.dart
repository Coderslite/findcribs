class ChatMessageModel {
  int? id;
  List? users;
  List? messages;
  Map? count;
  Map? lastMessage;
  // int? chatId;
  // String? message;
  // String? type;
  // String? fileUrl;
  // String? fileName;
  // String? status;
  // int? senderId;
  // int? receiverId;
  // int? propertyId;
  // String? createdAt;
  // String? updatedAt;

  ChatMessageModel({
    this.id,
    this.users,
    this.messages,
    this.count,
    this.lastMessage,
    // this.chatId,
    // this.message,
    // this.type,
    // this.fileUrl,
    // this.fileName,
    // this.status,
    // this.receiverId,
    // this.senderId,
    // this.propertyId,
    // this.createdAt,
    // this.updatedAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      users: json['users'],
      messages: json['messages'],
      count: json['_count'],
      lastMessage: json['lastMessage'],
      // chatId: json['chatId'],
      // message: json['message'],
      // type: json['type'],
      // fileUrl: json['fileUrl'],
      // fileName: json['fileName'],
      // status: json['status'],
      // senderId: json['senderId'],
      // receiverId: json['receiverId'],
      // propertyId: json['propertyId'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
    );
  }
}
