class Guest {
  String? name;
  String? code;
  String? phone;
  String? fileName;
  String? fileUrl;

  Guest({
    this.name,
    this.code,
    this.phone,
    this.fileName,
    this.fileUrl,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
    name: json["name"],
    code: json["code"],
    phone: json["phone"],
    fileName: json["file_name"],
    fileUrl: json["file_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "phone": phone,
    "file_name": fileName,
    "file_url": fileUrl,
  };
}