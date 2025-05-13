
class SendModel {
  String? message;
  String? by;
  String? assigneeId;
  String? visitorChatId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  SendModel({
    this.message,
    this.by,
    this.assigneeId,
    this.visitorChatId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory SendModel.fromJson(Map<String, dynamic> json) => SendModel(
    message: json["message"],
    by: json["by"],
    assigneeId: json["assignee_id"],
    visitorChatId: json["visitor_chat_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "by": by,
    "assignee_id": assigneeId,
    "visitor_chat_id": visitorChatId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}