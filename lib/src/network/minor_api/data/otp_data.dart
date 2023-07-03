class OtpData {
  String? refCode;
  String? otp;

  OtpData({
    this.refCode,
    this.otp,
  });

  OtpData.fromJson(dynamic json) {
    refCode = json['ref_code'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ref_code'] = refCode;
    map['otp'] = otp;
    return map;
  }
}
