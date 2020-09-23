import 'dart:async';

class Validators {
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final passwordRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]");

  StreamTransformer validateEmail() =>
      StreamTransformer<String, String>.fromHandlers(handleData: (email, skin) {
        if (emailRegExp.hasMatch(email)) {
          skin.add(email);
        } else {
          skin.addError('Invalid Email');
        }
      });

  StreamTransformer validatePassword() =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, skin) {
        if (passwordRegExp.hasMatch(password)) {
          skin.add(password);
        } else {
          skin.addError('Invalid Password');
        }
      });
}
