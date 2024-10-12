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
      cardNumber: json['cardNumber'] as String,
      passCode: json['passCode'] as String,
      expireTime: json['expireTime'] as String,
    );
  }
}