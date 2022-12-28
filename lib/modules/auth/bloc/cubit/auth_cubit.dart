import 'package:fashion_shopping_app/core/api/client.dart';
import 'package:fashion_shopping_app/modules/auth/bloc/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  void updateState({
    AuthStatus? authStatus,
  }) {
    emit(state.copyWith(
      authStatus: authStatus,
    ));
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('access')) {
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
      Client.setToken(prefs.getString('access')!);
      return true;
    } else {
      return false;
    }
  }
}
