abstract class LoginState {}

class LoginInitial extends LoginState {}
class ChangeAgree extends LoginState {}
class ChangeOtpCode extends LoginState {}

class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}

class LoginError extends LoginState {}
class IncorrectOtpLoading extends LoginState {}
class IncorrectOtpSuccess extends LoginState {}

class IncorrectOtpError extends LoginState {}
class RegisterLoading extends LoginState {}
class RegisterSuccess extends LoginState {}

class RegisterError extends LoginState {}
class ForgetPasswordLoading extends LoginState {}
class ForgetPasswordSuccess extends LoginState {}

class ForgetPasswordError extends LoginState {}
class VerifyLoading extends LoginState {}
class VerifySuccess extends LoginState {}

class VerifyError extends LoginState {}