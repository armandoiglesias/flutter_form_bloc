import 'dart:async';
import 'package:form_validation/scr/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  final _emailController = BehaviorSubject<String>();
  final _pwdController = BehaviorSubject<String>();

  Stream<String> get emailStram => _emailController.stream.transform(validarEmail);
  Stream<String> get emailPwd => _pwdController.stream.transform( validarPwd );

  Stream<bool> get formValidStream => CombineLatestStream.combine2(emailStram, emailPwd, (ab,b) => true );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePwd => _pwdController.sink.add;

  String get email => _emailController.value;
  String get password => _pwdController.value;

  dispose(){
    _emailController.close();
    _pwdController.close();
  }


  
}

