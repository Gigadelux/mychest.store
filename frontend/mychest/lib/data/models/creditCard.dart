class CreditCard{
  String postalCode;
  String cardNumber;
  String passCode;
  String expireTime;
  CreditCard({
    required this.postalCode,
    required this.cardNumber,
    required this.passCode,
    required this.expireTime,
  });
  factory CreditCard.empty() => CreditCard(postalCode: "", cardNumber: "", passCode: "", expireTime: "");
  bool get isEmpty {
    return postalCode.isEmpty &&
           cardNumber.isEmpty &&
           passCode.isEmpty &&
           expireTime.isEmpty;
  }
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      postalCode: json['postalCode'] as String,
      cardNumber: json['cardNumber'] as String,
      passCode: json['passCode'] as String,
      expireTime: json['expireTime'] as String,
    );
  }
}