import 'package:e_commerce_machinetest/model/user.dart';
import 'package:e_commerce_machinetest/services/local/local_service.dart';
import 'package:e_commerce_machinetest/services/remote/auth/firebase_auth_service.dart';
import 'package:e_commerce_machinetest/services/remote/firestore/user_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final LocalService _localService = LocalService();
  final UserFirestore _userFirestore = UserFirestore();

  User? _currentUser;

  User? get user => _currentUser;

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<Logout>(_onLogout);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    _currentUser = await _localService.getUser();
    if (_currentUser != null) {
      emit(AuthAuthenticated(_currentUser!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLoginWithGoogle(LoginWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      _currentUser = await _firebaseAuthService.signInWithGoogle();
      if (_currentUser != null) {
        await _localService.saveUser(_currentUser!);
        await _userFirestore.addUser(_currentUser!);
        emit(AuthAuthenticated(_currentUser!));
      } else {
        emit(AuthUnauthenticated()); // User canceled login
      }
    } catch (e) {
      emit(AuthError("Failed to sign in: ${e.toString()}"));
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) async {
    try {
      await _firebaseAuthService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError("Failed to log out: ${e.toString()}"));
    }
  }
}
