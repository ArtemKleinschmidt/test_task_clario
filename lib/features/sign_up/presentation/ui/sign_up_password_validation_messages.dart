part of 'sign_up_screen.dart';

class _PasswordValidationMessages extends StatelessWidget {
  const _PasswordValidationMessages(this._state);

  final SignUpState _state;

  @override
  Widget build(BuildContext context) {
    bool tooShortPassword = false;
    bool tooLongPassword = false;
    bool noUppercasePassword = false;
    bool noDigitPassword = false;

    final state = _state;

    if (state is SignUpErrorState) {
      if (state.passwordValidationResults.tooShort ||
          state.passwordValidationResults.empty) {
        tooShortPassword = true;
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

    final nonErrorColor = state is SignUpInitial
        ? Colors.black.withOpacity(0.6)
        : AppColors.green;

    return SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          context.l10n.eightCharactersOrMore,
          style: TextStyle(
            color: tooShortPassword ? Colors.red : nonErrorColor,
          ),
        ),
        Text(
          context.l10n.sixtyFourCharactersOrLess,
          style: TextStyle(
            color: tooLongPassword ? Colors.red : nonErrorColor,
          ),
        ),
        Text(
          context.l10n.atLeastOneUpperCaseLetter,
          style: TextStyle(
            color: noUppercasePassword ? Colors.red : nonErrorColor,
          ),
        ),
        Text(
          context.l10n.atLeastOneDigit,
          style: TextStyle(
            color: noDigitPassword ? Colors.red : nonErrorColor,
          ),
        ),
      ]),
    );
  }
}
