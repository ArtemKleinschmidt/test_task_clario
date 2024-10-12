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
  final Validator validator;

  SignUpBloc(this.validator) : super(const SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
      _processEvent(event, emit);
    });
  }

  void _processEvent(SignUpEvent event, Emitter<SignUpState> emit) {
    switch (event) {
      case SignUpEmailPasswordEvent():
        final SignUpEmailPasswordEvent emailPasswordEvent = event;
        final String email = emailPasswordEvent.email;
        final String password = emailPasswordEvent.password;

        final emailValidationResult = validator.validateEmail(email);
        final passwordValidationResult = validator.validatePassword(password);

        if (emailValidationResult == EmailValidationResult.valid &&
            passwordValidationResult.isValid) {
          emit(const SignUpSuccessState(showSuccessMessage: true));
        } else {
          emit(SignUpErrorState(
            emailValidationResult: emailValidationResult,
            passwordValidationResults: passwordValidationResult,
          ));
        }

      case DialogDismissedEvent():
        emit(const SignUpSuccessState(showSuccessMessage: false));
        break;

      default:
        throw Exception('Unknown event: $event');
    }
  }
}
