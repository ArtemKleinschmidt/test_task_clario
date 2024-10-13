part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {
  const SignUpEvent();
}

@immutable
final class SignUpEmailPasswordEvent extends SignUpEvent {
  const SignUpEmailPasswordEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

@immutable
final class DialogDismissedEvent extends SignUpEvent {
  const DialogDismissedEvent();
}
