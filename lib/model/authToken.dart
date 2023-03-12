class AuthToken {
  static final AuthToken _singleton = AuthToken._internal();

  factory AuthToken() {
    return _singleton;
  }

  String _token = '';

  String get token => _token;


  set token(String token) {
    _token = token;
  }


  AuthToken._internal();
}