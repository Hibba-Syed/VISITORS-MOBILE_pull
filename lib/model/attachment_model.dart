class Attachment {
  int? id;
  int? visitorChatMessageId;
  String? file;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fileUrl;

  Attachment({
    this.id,
    this.visitorChatMessageId,
    this.file,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.fileUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    visitorChatMessageId: json["visitor_chat_message_id"],
    file: json["file"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fileUrl: json["file_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visitor_chat_message_id": visitorChatMessageId,
    "file": file,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "file_url": fileUrl,
  };
}