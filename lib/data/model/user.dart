class User {
  final int id;
  final String userNum;
  final String token;

  const User({this.id = -1, this.userNum = '', this.token =''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userNum': userNum,
      'token': token
    };
  }
}