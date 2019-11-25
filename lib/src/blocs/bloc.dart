import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (email, password) => true);

  submit(){
    final validEmail = _email.value;
    final validPassword = _password.value;
    print('$validEmail');
    print('$validPassword');
  }

  dispose(){
    _email.close();
    _password.close();
  }
}