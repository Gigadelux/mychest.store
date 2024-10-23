class CreditCard{
  String cardNumber;
  String passCode;
  String expireTime;
  CreditCard({
    required this.cardNumber,
    required this.passCode,
    required this.expireTime,
  });
  factory CreditCard.empty() => CreditCard(cardNumber: "", passCode: "", expireTime: "");
  bool get isEmpty {
    return cardNumber.isEmpty &&
           passCode.isEmpty &&
           expireTime.isEmpty;
  }
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardNumber: json['card_number'] as String,
      passCode: json['pass_code'] as String,
      expireTime: json['expire_time'] as String,
    );
  }
}