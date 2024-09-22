class CreditCard{
  int postalCode;
  String cardNumber;
  int passCode;
  String expireTime;
  CreditCard({
    required this.postalCode,
    required this.cardNumber,
    required this.passCode,
    required this.expireTime,
  });
  factory CreditCard.empty() => CreditCard(postalCode: 0, cardNumber: "", passCode: 0, expireTime: "");
  bool get isEmpty {
    return postalCode == 0 &&
           cardNumber.isEmpty &&
           passCode == 0 &&
           expireTime.isEmpty;
  }
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      postalCode: json['postalCode'] as int,
      cardNumber: json['cardNumber'] as String,
      passCode: json['passCode'] as int,
      expireTime: json['expireTime'] as String,
    );
  }
}