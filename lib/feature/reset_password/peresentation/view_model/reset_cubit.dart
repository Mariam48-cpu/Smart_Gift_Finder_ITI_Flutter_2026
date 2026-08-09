import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/feature/reset_password/domain/usecase/reset_password_use_case.dart';
import 'reset_states.dart';

@injectable
class ResetCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetCubit(this.resetPasswordUseCase) : super(ResetPasswordInitialState());

  Future<void> sendResetEmail(String email) async {
    emit(ResetPasswordLoadingState());
    try {
      await resetPasswordUseCase.invoke(email);
      emit(
        ResetPasswordSuccessState(
          'Password reset link has been sent to your email.',
        ),
      );
    } catch (e) {
      emit(ResetPasswordErrorState(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
