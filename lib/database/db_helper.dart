import 'package:devlearning_indo/models/form_input.dart';
import 'package:devlearning_indo/models/user_login_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  final List<FormInput> _formInputs = [];
  final List<UserModelSQL> _users = [];

  List<FormInput> get formInputs => List.unmodifiable(_formInputs);

  Future<void> insertFormInput(FormInput formInput) async {
    _formInputs.add(formInput);
  }

  Future<void> clearFormInputs() async {
    _formInputs.clear();
  }

  Future<bool> registerUser(UserModelSQL user) async {
    if (_users.any((item) => item.email == user.email)) {
      return false;
    }
    _users.add(user);
    return true;
  }

  Future<UserModelSQL?> loginUser(String email, String password) async {
    for (final user in _users) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return null;
  }
}
