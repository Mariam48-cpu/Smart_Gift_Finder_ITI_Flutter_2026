sealed class ResetPasswordState {}

final class ResetPasswordInitialState extends ResetPasswordState {}

final class ResetPasswordLoadingState extends ResetPasswordState {}

final class ResetPasswordSuccessState extends ResetPasswordState {
  final String message;
  ResetPasswordSuccessState(this.message);
}

final class ResetPasswordErrorState extends ResetPasswordState {
  final String error;
  ResetPasswordErrorState(this.error);
}