import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:test_task_clario/features/sign_up/domain/credentials_validator.dart';
import 'package:test_task_clario/features/sign_up/domain/email_validation_result.dart';

import '../../domain/password_validation_result.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final Validator _validator;

  SignUpBloc(this._validator) : super(const SignUpInitial()) {
    on<SignUpEmailPasswordEvent>((event, emit) {
      _onSignUpEmailPasswordEvent(event, emit);
    });
    on<DialogDismissedEvent>((event, emit) {
      _onDialogDismissedEvent(event, emit);
    });
  }

  void _onSignUpEmailPasswordEvent(
      SignUpEmailPasswordEvent event, Emitter<SignUpState> emit) {
    final SignUpEmailPasswordEvent emailPasswordEvent = event;
    final String email = emailPasswordEvent.email;
    final String password = emailPasswordEvent.password;

    final emailValidationResult = _validator.validateEmail(email);
    final passwordValidationResult = _validator.validatePassword(password);

    if (emailValidationResult == EmailValidationResult.valid &&
        passwordValidationResult.isValid) {
      emit(const SignUpSuccessState(showSuccessMessage: true));
    } else {
      emit(SignUpErrorState(
        emailValidationResult: emailValidationResult,
        passwordValidationResults: passwordValidationResult,
      ));
    }
  }

  void _onDialogDismissedEvent(
      DialogDismissedEvent event, Emitter<SignUpState> emit) {
    emit(const SignUpSuccessState(showSuccessMessage: false));
  }
}
