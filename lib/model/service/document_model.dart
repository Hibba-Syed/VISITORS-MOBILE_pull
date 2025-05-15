class Document {
  int? id;
  int? companyId;
  dynamic userId;
  int? objectId;
  String? objectType;
  String? name;
  dynamic label;
  dynamic folderName;
  dynamic description;
  String? path;
  String? fileType;
  String? mimeType;
  String? fileExt;
  dynamic issueDate;
  dynamic expiryDate;
  String? status;
  dynamic type;
  String? category;
  dynamic note;
  dynamic shareWith;
  dynamic shareEndDate;
  dynamic shareWithUnit;
  dynamic shareEndDateUnit;
  dynamic emailSent;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? pathUrl;

  Document({
    this.id,
    this.companyId,
    this.userId,
    this.objectId,
    this.objectType,
    this.name,
    this.label,
    this.folderName,
    this.description,
    this.path,
    this.fileType,
    this.mimeType,
    this.fileExt,
    this.issueDate,
    this.expiryDate,
    this.status,
    this.type,
    this.category,
    this.note,
    this.shareWith,
    this.shareEndDate,
    this.shareWithUnit,
    this.shareEndDateUnit,
    this.emailSent,
    this.createdAt,
    this.updatedAt,
    this.pathUrl,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"],
    companyId: json["company_id"],
    userId: json["user_id"],
    objectId: json["object_id"],
    objectType: json["object_type"],
    name: json["name"],
    label: json["label"],
    folderName: json["folder_name"],
    description: json["description"],
    path: json["path"],
    fileType: json["file_type"],
    mimeType: json["mime_type"],
    fileExt: json["file_ext"],
    issueDate: json["issue_date"],
    expiryDate: json["expiry_date"],
    status: json["status"],
    type: json["type"],
    category: json["category"],
    note: json["note"],
    shareWith: json["share_with"],
    shareEndDate: json["share_end_date"],
    shareWithUnit: json["share_with_unit"],
    shareEndDateUnit: json["share_end_date_unit"],
    emailSent: json["email_sent"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pathUrl: json["path_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "user_id": userId,
    "object_id": objectId,
    "object_type": objectType,
    "name": name,
    "label": label,
    "folder_name": folderName,
    "description": description,
    "path": path,
    "file_type": fileType,
    "mime_type": mimeType,
    "file_ext": fileExt,
    "issue_date": issueDate,
    "expiry_date": expiryDate,
    "status": status,
    "type": type,
    "category": category,
    "note": note,
    "share_with": shareWith,
    "share_end_date": shareEndDate,
    "share_with_unit": shareWithUnit,
    "share_end_date_unit": shareEndDateUnit,
    "email_sent": emailSent,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "path_url": pathUrl,
  };
}