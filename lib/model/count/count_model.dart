
class CountModel {
  int? total;
  int? jobs;
  int? guests;
  int? messages;
  int? service;

  CountModel({
    this.total,
    this.jobs,
    this.guests,
    this.messages,
    this.service,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
    total: json["total"],
    jobs: json["jobs"],
    guests: json["guests"],
    messages: json["messages"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "jobs": jobs,
    "guests": guests,
    "messages": messages,
    "service": service,
  };
}