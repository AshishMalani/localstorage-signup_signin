import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConfigController extends GetxController {
  bool isDbConfig = false;
  late Database database;

  @override
  void onInit() {
    dbConfig();
    super.onInit();
  }

  void dbConfig() async {
    isDbConfig = true;
    update();

    await Future.delayed(Duration(seconds: 3));
    database = await openDatabase(
      join(await getDatabasesPath(), 'demo.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE `user`(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` VARCHAR(255), `email` VARCHAR(255),`password` VARCHAR(255))',
        );
      },
      version: 1,
    );

    isDbConfig = false;
    update();
  }
}
