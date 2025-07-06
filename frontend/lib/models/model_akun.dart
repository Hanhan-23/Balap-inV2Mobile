class ModelAkunMasyarakat {
  final dynamic id;
  final String token;

  ModelAkunMasyarakat({
    required this.id,
    required this.token,
  });

  factory ModelAkunMasyarakat.fromJson(Map<String, dynamic> json) {
    return ModelAkunMasyarakat(
      id: json['id'],
      token: json['token']
    );
  }
}