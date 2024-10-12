part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {
  const SignUpState();
}

@immutable
final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

@immutable
final class SignUpSuccessState extends SignUpState {
  const SignUpSuccessState({required this.showSuccessMessage});

  final bool showSuccessMessage;
}

final class SignUpErrorState extends SignUpState {
  const SignUpErrorState(
      {required this.emailValidationResult,
      required this.passwordValidationResults});

  final EmailValidationResult? emailValidationResult;
  final List<PasswordValidationResult> passwordValidationResults;

  @override
  String toString() =>
      'SignUpErrorState(emailValidationResult: $emailValidationResult, passwordValidationResults: $passwordValidationResults)';
}
