class UserModel {
  final String email;
  final bool isPurchase;
  final bool isAdmin;
  final String stringSpare1;
  final String stringSpare2;
  final int intSpare1;
  final dynamic dynamicSpare1;
  final dynamic dynamicSpare2;

  const UserModel({
    required this.email,
    required this.isPurchase,
    required this.isAdmin,
    this.stringSpare1 = '',
    this.stringSpare2 = '',
    this.intSpare1 = 0,
    this.dynamicSpare1,
    this.dynamicSpare2,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isPurchase': isPurchase,
      'isAdmin': isAdmin,
      'stringSpare1': stringSpare1,
      'stringSpare2': stringSpare2,
      'intSpare1': intSpare1,
      'dynamicSpare1': dynamicSpare1,
      'dynamicSpare2': dynamicSpare2,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      isPurchase: json['isPurchase'],
      isAdmin: json['isAdmin'],
      stringSpare1: json['stringSpare1'],
      stringSpare2: json['stringSpare2'],
      intSpare1: json['intSpare1'],
      dynamicSpare1: json['dynamicSpare1'],
      dynamicSpare2: json['dynamicSpare2'],
    );
  }

  UserModel copyWith({
    String? email,
    bool? isPurchase,
    bool? isAdmin,
    String? stringSpare1,
    String? stringSpare2,
    int? intSpare1,
    dynamic dynamicSpare1,
    dynamic dynamicSpare2,
  }) {
    return UserModel(
      email: email ?? this.email,
      isPurchase: isPurchase ?? this.isPurchase,
      isAdmin: isAdmin ?? this.isAdmin,
      stringSpare1: stringSpare1 ?? this.stringSpare1,
      stringSpare2: stringSpare2 ?? this.stringSpare2,
      intSpare1: intSpare1 ?? this.intSpare1,
      dynamicSpare1: dynamicSpare1 ?? this.dynamicSpare1,
      dynamicSpare2: dynamicSpare2 ?? this.dynamicSpare2,
    );
  }
}
