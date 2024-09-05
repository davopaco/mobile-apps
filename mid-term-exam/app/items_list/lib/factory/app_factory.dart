import 'package:items_list/items_manager_app.dart';
import 'package:items_list/login/login_repository.dart';
import 'package:items_list/login/login_service.dart';
import 'package:items_list/login/login_use_case.dart';
import 'package:items_list/util/sqlite_dbc.dart';

class AppFactory {
  static Future<ItemsManagerApp> getItemsManagerApp() async {
    SqliteDbc sqliteDbc = await SqliteDbc.createInstance();
    LoginRepository loginRepository = LoginRepository(sqliteDbc: sqliteDbc);
    LoginService loginService = LoginService(loginRepository: loginRepository);
    LoginUseCase loginUseCase = LoginUseCase(loginService: loginService);
    return ItemsManagerApp(loginUseCase: loginUseCase);
  }
}
