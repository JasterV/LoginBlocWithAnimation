import 'dart:async';
import 'dart:core';

class Validators{
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains("@")){
        sink.add(email);
      }else{
        sink.addError('Invalid email');
      }
    }
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length > 4){
        sink.add(password);
      }else{
        sink.addError('Invalid password');
      }
    }
  );
}