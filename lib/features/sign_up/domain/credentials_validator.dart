import 'package:injectable/injectable.dart';
import 'package:test_task_clario/features/sign_up/domain/email_validation_result.dart';
import 'package:test_task_clario/features/sign_up/domain/password_validation_result.dart';

@injectable
class Validator {
  const Validator();

  EmailValidationResult validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return EmailValidationResult.empty;
    }

    final bool emailValid =
        RegExp(r'^[\w-+\\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (emailValid) {
      return EmailValidationResult.valid;
    } else {
      return EmailValidationResult.invalid;
    }
  }

  List<PasswordValidationResult> validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return [PasswordValidationResult.empty];
    }

    final validationResults = <PasswordValidationResult>[];

    if (password.length < 8) {
      validationResults.add(PasswordValidationResult.tooShort);
    }

    if (password.length > 64) {
      validationResults.add(PasswordValidationResult.tooLong);
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      validationResults.add(PasswordValidationResult.noUppercase);
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      validationResults.add(PasswordValidationResult.noDigit);
    }

    if (password.contains(RegExp(r'\s'))) {
      validationResults.add(PasswordValidationResult.spaces);
    }

    if (validationResults.isEmpty) {
      return [PasswordValidationResult.valid];
    } else {
      return validationResults;
    }
  }
}
