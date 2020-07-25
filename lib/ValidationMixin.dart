mixin Validation {
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? true;

  bool validateEmailAddress(String email) {
    if (email == null) {
      return false;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}

enum FieldError { Empty, Invalid }

abstract class FormScreenEvent {}

class FormScreenEventSubmit extends FormScreenEvent {
  final String email;

  FormScreenEventSubmit(this.email);
}

class FormScreenSate {
  final bool isBusy;
  final FieldError emailError;
  final bool submissSuccess;

  FormScreenSate({this.isBusy= false, this.emailError, this.submissSuccess= false});
}
