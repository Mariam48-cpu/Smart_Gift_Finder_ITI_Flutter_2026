abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class RegisterSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}