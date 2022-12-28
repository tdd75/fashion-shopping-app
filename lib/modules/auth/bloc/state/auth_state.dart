enum AuthStatus {
  authenticated,
  unauthenticated,
  tokenExpired,
}

class AuthState {
  final AuthStatus authStatus;

  AuthState({
    this.authStatus = AuthStatus.unauthenticated,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
