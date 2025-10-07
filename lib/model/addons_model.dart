class AddonsModel {
  AddonsModel({
      this.id, 
      this.applicationFitOutId, 
      this.serviceName, 
      this.servicePrice, 
      this.createdAt, 
      this.updatedAt,});

  AddonsModel.fromJson(dynamic json) {
    id = json['id'];
    applicationFitOutId = json['application_fit_out_id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? applicationFitOutId;
  String? serviceName;
  int? servicePrice;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['application_fit_out_id'] = applicationFitOutId;
    map['service_name'] = serviceName;
    map['service_price'] = servicePrice;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}