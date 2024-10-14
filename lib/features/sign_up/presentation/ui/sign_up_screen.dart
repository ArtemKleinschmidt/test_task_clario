import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_clario/common/presentation/context_extensions.dart';

import '../../../../common/di/get_it.dart';
import '../../../../common/presentation/ui/colors.dart';
import '../../../../common/presentation/ui/text_styles.dart';
import '../../../../common/presentation/ui/widgets/app_button.dart';
import '../../../../common/presentation/ui/widgets/app_input_field.dart';
import '../../domain/email_validation_result.dart';
import '../../domain/password_validation_result.dart';
import '../bloc/sign_up_bloc.dart';

part 'sign_up_password_validation_messages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showingDialog = false;
  late double statusBarHeight;

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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((value) {
      // This block is executed when the dialog is dismissed
      setState(() {
        _showingDialog = false;
      });
      signUpBloc.add(const DialogDismissedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightBlue1,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.lightBlue2,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: BlocProvider(
          create: (context) => getIt<SignUpBloc>(),
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              final signUpBloc = BlocProvider.of<SignUpBloc>(context);
              if (state is SignUpSuccessState && state.showSuccessMessage) {
                Future.microtask(() {
                  if (context.mounted && !_showingDialog) {
                    _showSuccessDialog(context, signUpBloc);
                  }
                });
              }
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.lightBlue1,
                      AppColors.lightBlue2,
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120 + statusBarHeight,
                    ),
                    Text(
                      context.l10n.signUp,
                      style: AppTextStyles.title,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AppInputField(
                      isError: state is SignUpErrorState &&
                          state.emailValidationResult !=
                              EmailValidationResult.valid,
                      isSuccess: isEmailValid(state),
                      textEditingController: emailController,
                      hintText: context.l10n.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AppInputField(
                      showHideIcon: true,
                      isError: state is SignUpErrorState &&
                          !state.passwordValidationResults.isValid,
                      isSuccess: isPasswordValid(state),
                      textEditingController: passwordController,
                      hintText: context.l10n.createYourPassword,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _PasswordValidationMessages(state),
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      context.l10n.signUp,
                      onTap: () {
                        signUpBloc.add(
                          SignUpEmailPasswordEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    statusBarHeight = MediaQuery.of(context).padding.top;
  }
}
