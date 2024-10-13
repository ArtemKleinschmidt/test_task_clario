part of 'sign_up_screen.dart';

class _PasswordValidationMessages extends StatelessWidget {
  const _PasswordValidationMessages(this._state);

  final SignUpState _state;

  @override
  Widget build(BuildContext context) {
    bool tooShortOrSpacesPassword = false;
    bool tooLongPassword = false;
    bool noUppercasePassword = false;
    bool noDigitPassword = false;

    final state = _state;

    if (state is SignUpErrorState) {
      if (state.passwordValidationResults.tooShort ||
          state.passwordValidationResults.spaces ||
          state.passwordValidationResults.empty) {
        tooShortOrSpacesPassword = true;
      }
      if (state.passwordValidationResults.tooLong ||
          state.passwordValidationResults.empty) {
        tooLongPassword = true;
      }
      if (state.passwordValidationResults.noUppercase ||
          state.passwordValidationResults.empty) {
        noUppercasePassword = true;
      }
      if (state.passwordValidationResults.noDigit ||
          state.passwordValidationResults.empty) {
        noDigitPassword = true;
      }
    }

    final nonErrorStyle = state is SignUpInitial
        ? AppTextStyles.smallTextDefault
        : AppTextStyles.smallTextSuccess;

    return SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          context.l10n.eightCharactersOrMore,
          style: tooShortOrSpacesPassword
              ? AppTextStyles.smallTextError
              : nonErrorStyle,
        ),
        Text(
          context.l10n.sixtyFourCharactersOrLess,
          style: tooLongPassword ? AppTextStyles.smallTextError : nonErrorStyle,
        ),
        Text(
          context.l10n.atLeastOneUpperCaseLetter,
          style: noUppercasePassword
              ? AppTextStyles.smallTextError
              : nonErrorStyle,
        ),
        Text(
          context.l10n.atLeastOneDigit,
          style: noDigitPassword ? AppTextStyles.smallTextError : nonErrorStyle,
        ),
      ]),
    );
  }
}
