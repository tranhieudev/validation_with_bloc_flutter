import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validation_with_bloc/ValidationMixin.dart';

class FormScreenBloc extends Bloc<FormScreenEvent, FormScreenSate> with Validation{
  FormScreenSate get initialState => FormScreenSate(submissSuccess: false, isBusy: false, emailError: null);
  FormScreenBloc(FormScreenSate initialState ) : super(initialState);

  @override
  Stream<FormScreenSate> mapEventToState(FormScreenEvent event) async* {
    // TODO: implement mapEventToState
    if(event is FormScreenEventSubmit){
      yield FormScreenSate(isBusy: true);

      if(this.isFieldEmpty(event.email)){
        yield FormScreenSate(emailError: FieldError.Empty);
        return;
      }

      if(!this.validateEmailAddress(event.email)){
        yield FormScreenSate(emailError: FieldError.Invalid);
        return;
      }

      yield FormScreenSate(isBusy:  true);
    }
  }



}