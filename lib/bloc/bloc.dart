import 'dart:async';

import 'package:flash_chat/bloc/validators.dart';

class Bloc extends Object with Validators {
  final _emailStreamController = StreamController<String>();
  final _passwordStreamController = StreamController<String>();

  Stream<String> get email =>
      _emailStreamController.stream.transform(validateEmail());
  Stream<String> get password =>
      _passwordStreamController.stream.transform(validatePassword());

  Function(String) get changeEmail => _emailStreamController.sink.add;
  Function(String) get changePassword => _passwordStreamController.sink.add;
}
