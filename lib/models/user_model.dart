class UserModel {
  final int? id;
  final String email;
  final String password;
  final String nickname;
  final String uid;
  final String currentRank;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.nickname,
    required this.uid,
    required this.currentRank,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nickname': nickname,
      'uid': uid,
      'current_rank': currentRank,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      nickname: map['nickname'],
      uid: map['uid'],
      currentRank: map['current_rank'],
    );
  }
}

class AuthService {
  static UserModel? currentUser;
}