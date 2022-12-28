class LoginState {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  String? get validateEmail {
    if (email.trim().isEmpty) {
      return 'Please input email';
    }
    return null;
  }

  String? get validatePassword {
    if (password.length < 6) {
      return 'Password too short';
    }
    return null;
  }
}
