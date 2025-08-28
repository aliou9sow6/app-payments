class Payment {
  final int id;
  final int userId;
  final double amount;
  final String? description;
  final String currency;
  final String paymentMethod;
  final String? proof;
  final String status;

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    this.description,
    required this.currency,
    required this.paymentMethod,
    this.proof,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      description: json['description'],
      currency: json['currency'],
      paymentMethod: json['payment_method'],
      proof: json['proof'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'description': description,
      'currency': currency,
      'payment_method': paymentMethod,
      'proof': proof,
      'status': status,
    };
  }
}
