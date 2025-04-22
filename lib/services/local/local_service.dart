import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';

class LocalService {
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    final name = prefs.getString('name');
    final email = prefs.getString('email');
    if (id != null && name != null && email != null) {
      return User(id: id, name: name, email: email);
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.id!);
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.email);
  }
}
