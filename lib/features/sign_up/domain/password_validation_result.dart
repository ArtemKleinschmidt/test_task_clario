enum PasswordValidationResult {
  valid,
  empty,
  tooShort,
  tooLong,
  noUppercase,
  noDigit,
  spaces,
}

extension PasswordValidationResultExtensions on List<PasswordValidationResult> {
  bool get isValid => length == 1 && contains(PasswordValidationResult.valid);

  bool get tooShort => contains(PasswordValidationResult.tooShort);

  bool get tooLong => contains(PasswordValidationResult.tooLong);

  bool get noUppercase => contains(PasswordValidationResult.noUppercase);

  bool get noDigit => contains(PasswordValidationResult.noDigit);

  bool get spaces => contains(PasswordValidationResult.spaces);

  bool get empty => contains(PasswordValidationResult.empty);
}
