class ValidData {
  bool? isValid;

  ValidData({
    this.isValid,
  });

  ValidData.fromJson(dynamic json) {
    isValid = json['is_valid'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_valid'] = isValid;
    return map;
  }
}
