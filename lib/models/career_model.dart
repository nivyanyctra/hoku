class CareerModel {
  final int? id;
  final int creatorId;
  final String teamName,
      role,
      lane,
      type,
      salary,
      currency,
      locationType,
      city,
      country,
      requirements,
      applyLink,
      deadline,
      createdAt;
  final String? creatorName;

  CareerModel({
    this.id,
    required this.creatorId,
    required this.teamName,
    required this.role,
    this.lane = "",
    required this.type,
    this.salary = "",
    this.currency = "IDR",
    required this.locationType,
    required this.city,
    required this.country,
    required this.requirements,
    required this.applyLink,
    this.deadline = "",
    required this.createdAt,
    this.creatorName,
  });

  // Digunakan untuk INSERT (id biasanya null agar auto-increment)
  Map<String, dynamic> toMap() {
    return {
      'creator_id': creatorId,
      'team_name': teamName,
      'role': role,
      'lane': lane,
      'type': type,
      'salary': salary,
      'currency': currency,
      'location_type': locationType,
      'city': city,
      'country': country,
      'requirements': requirements,
      'apply_link': applyLink,
      'deadline': deadline,
      'created_at': createdAt,
    };
  }

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id'],
      creatorId: map['creator_id'],
      teamName: map['team_name'] ?? "",
      role: map['role'] ?? "",
      lane: map['lane'] ?? "",
      type: map['type'] ?? "",
      salary: map['salary'] ?? "",
      currency: map['currency'] ?? "IDR",
      locationType: map['location_type'] ?? "",
      city: map['city'] ?? "",
      country: map['country'] ?? "",
      requirements: map['requirements'] ?? "",
      applyLink: map['apply_link'] ?? "",
      deadline: map['deadline'] ?? "",
      createdAt: map['created_at'] ?? "",
      creatorName: map['creator_name'],
    );
  }
}
