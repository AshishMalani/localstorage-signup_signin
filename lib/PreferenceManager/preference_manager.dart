import 'package:get_storage/get_storage.dart';

class PreferencesManager {
  final box = GetStorage();

  String isLogin = 'isLogin';

  Future<void> setLogin() async {
    await box.write(isLogin, true);
  }

  getLogin() {
    return box.read(isLogin);
  }

  Future<void> logOut() async {
    await box.erase();
  }
}
