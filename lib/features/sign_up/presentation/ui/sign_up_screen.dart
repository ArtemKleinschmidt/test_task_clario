import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_clario/common/presentation/context_extensions.dart';

import '../../../../common/di/get_it.dart';
import '../../../../common/presentation/ui/widgets/input_field.dart';
import '../../domain/email_validation_result.dart';
import '../../domain/password_validation_result.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool _showingDialog = false;

  bool isEmailValid(SignUpState state) {
    if (state is SignUpErrorState) {
      return state.emailValidationResult == EmailValidationResult.valid;
    }
    return state is SignUpSuccessState;
  }

  bool isPasswordValid(SignUpState state) {
    if (state is SignUpErrorState) {
      return state.passwordValidationResults.isValid;
    }
    return state is SignUpSuccessState;
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  void _showSuccessDialog(BuildContext context, SignUpBloc signUpBloc) {
    setState(() {
      _showingDialog = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.l10n.success),
          content: Text(context.l10n.signUpSuccessMessage),
          actions: <Widget>[
            TextButton(
              child: Text(context.l10n.ok),
              onPressed: () {
                setState(() {
                  _showingDialog = false;
                });
                Navigator.of(context).pop();
                signUpBloc.add(const DialogDismissedEvent());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<SignUpBloc>(),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            debugPrint('state: $state');
            final signUpBloc = BlocProvider.of<SignUpBloc>(context);
            if (state is SignUpSuccessState && state.showSuccessMessage) {
              Future.microtask(() {
                if (context.mounted && !_showingDialog) {
                  _showSuccessDialog(context, signUpBloc);
                }
              });
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.signUp,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  InputField(
                    isError: state is SignUpErrorState &&
                        state.emailValidationResult !=
                            EmailValidationResult.valid,
                    isSuccess: isEmailValid(state),
                    textEditingController: emailController,
                  ),
                  const SizedBox(height: 16),
                  InputField(
                      showHideIcon: true,
                      isError: state is SignUpErrorState &&
                          !state.passwordValidationResults.isValid,
                      isSuccess: isPasswordValid(state),
                      textEditingController: passwordController),
                  ..._buildPasswordValidationMessages(state, context),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      signUpBloc.add(
                        SignUpEmailPasswordEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    child: Text(context.l10n.signUp),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildPasswordValidationMessages(
      SignUpState state, BuildContext context) {
    bool tooShortPassword = false;
    bool tooLongPassword = false;
    bool noUppercasePassword = false;
    bool noDigitPassword = false;

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

    final nonErrorColor =
        state is SignUpInitial ? Colors.black.withOpacity(0.6) : Colors.green;

    return [
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
    ];
  }
}
