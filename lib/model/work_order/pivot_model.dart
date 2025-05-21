class Pivot {
  int? jpJobId;
  int? jpAssetId;

  Pivot({
    this.jpJobId,
    this.jpAssetId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    jpJobId: json["jp_job_id"],
    jpAssetId: json["jp_asset_id"],
  );

  Map<String, dynamic> toJson() => {
    "jp_job_id": jpJobId,
    "jp_asset_id": jpAssetId,
  };
}