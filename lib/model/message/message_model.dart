import '../attachment_model.dart';
import '../user_model.dart';

class MessageModel {
  int? id;
  int? visitorChatId;
  int? assigneeId;
  int? userId;
  String? by;
  String? message;
  int? isVisitorRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Attachment>? attachments;
  User? user;

  MessageModel({
    this.id,
    this.visitorChatId,
    this.assigneeId,
    this.userId,
    this.by,
    this.message,
    this.isVisitorRead,
    this.createdAt,
    this.updatedAt,
    this.attachments,
    this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"],
    visitorChatId: json["visitor_chat_id"],
    assigneeId: json["assignee_id"],
    userId: json["user_id"],
    by: json["by"],
    message: json["message"],
    isVisitorRead: json["is_visitor_read"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visitor_chat_id": visitorChatId,
    "assignee_id": assigneeId,
    "user_id": userId,
    "by": by,
    "message": message,
    "is_visitor_read": isVisitorRead,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}