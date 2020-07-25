import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validation_with_bloc/ValidationMixin.dart';

import 'FormScreenBloc.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final _emailController = TextEditingController();

  FormScreenBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    this._bloc =FormScreenBloc(FormScreenSate());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _bloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<FormScreenBloc, FormScreenSate>(
      cubit: this._bloc,
      listener: (context,state){
        if( state.submissSuccess){
          showDialog(context: context,child: AlertDialog(
            title: Text('Submission suceess'),
            content: Text("Your submission waw a success"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: ()=> Navigator.of(context).pop(),
              )
            ],
          ));
        }
      },
      child:  Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: BlocBuilder<FormScreenBloc, FormScreenSate>(
              cubit: this._bloc,
                builder: (context, state){
                  return AbsorbPointer(
                    absorbing: state.isBusy,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              controller: this._emailController,
                              style: TextStyle(
                                  color: this._hasEmailError(state)? Colors.red : Colors.black
                              ),
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelStyle: TextStyle(
                                    color: this._hasEmailError(state) ? Colors.red :Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                      color: this._hasEmailError(state) ? Colors.red : Colors.black
                                  ),
                                  enabledBorder: this._renderBorder(state),
                                  focusedBorder: this._renderBorder(state)
                              ),
                            ),
                            if(this._hasEmailError(state))...[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                this._emailErrorText(state.emailError),
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                            SizedBox(height: 30,),
                            RaisedButton(
                              child: Text('Submit'),
                              onPressed: ()=>this._bloc.add(FormScreenEventSubmit(this._emailController.text)),
                            )
                          ],
                        ),
                      if(state.isBusy)...[Center(child: CircularProgressIndicator())]
                      ],
                    ),

                  );
                },
            ),
          ),
        ),
      ),
    );
  }
  bool _hasEmailError(FormScreenSate state) => state.emailError!=null;

  UnderlineInputBorder _renderBorder(FormScreenSate state) => UnderlineInputBorder(
    borderSide: BorderSide(
      color: this._hasEmailError(state) ? Colors.red : Colors.black,
    )
  );

  String _emailErrorText(FieldError err){
    switch(err){
      case FieldError.Empty:
        return 'You need to enter an email address';
      case FieldError.Invalid:
        return 'Email addreess invalid';
      default:
        return '';
    }
  }
}
