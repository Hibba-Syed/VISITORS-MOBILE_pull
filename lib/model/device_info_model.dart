class DeviceInfo {
  int? id;
  int? applicationAccessDeviceId;
  String? deviceType;
  int? deviceCount;
  int? cost;
  int? accountId;
  String? incomeType;
  dynamic convenienceFee;
  dynamic convenienceFeeAccount;
  int? isCommunityDetailHidden;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DeviceInfo({
    this.id,
    this.applicationAccessDeviceId,
    this.deviceType,
    this.deviceCount,
    this.cost,
    this.accountId,
    this.incomeType,
    this.convenienceFee,
    this.convenienceFeeAccount,
    this.isCommunityDetailHidden,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    id: json["id"],
    applicationAccessDeviceId: json["application_access_device_id"],
    deviceType: json["device_type"],
    deviceCount: json["device_count"],
    cost: json["cost"],
    accountId: json["account_id"],
    incomeType: json["income_type"],
    convenienceFee: json["convenience_fee"],
    convenienceFeeAccount: json["convenience_fee_account"],
    isCommunityDetailHidden: json["is_community_detail_hidden"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "application_access_device_id": applicationAccessDeviceId,
    "device_type": deviceType,
    "device_count": deviceCount,
    "cost": cost,
    "account_id": accountId,
    "income_type": incomeType,
    "convenience_fee": convenienceFee,
    "convenience_fee_account": convenienceFeeAccount,
    "is_community_detail_hidden": isCommunityDetailHidden,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}