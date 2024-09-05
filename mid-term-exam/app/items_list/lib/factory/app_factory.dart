import 'package:items_list/repositories/api_fav_items_repository.dart';
import 'package:items_list/repositories/fav_items_repository.dart';
import 'package:items_list/repositories/items_repository.dart';
import 'package:items_list/services/items_service.dart';
import 'package:items_list/items_manager_app.dart';
import 'package:items_list/repositories/login_repository.dart';
import 'package:items_list/services/login_service.dart';
import 'package:items_list/usecases/items_manager_usecase.dart';
import 'package:items_list/util/sqlite_dbc.dart';

class AppFactory {
  static Future<ItemsManagerApp> getItemsManagerApp() async {
    SqliteDbc sqliteDbc = await SqliteDbc.createInstance();

    //Repositories
    LoginRepository loginRepository = LoginRepository();
    ItemsRepository itemsRepository = ItemsRepository();
    FavItemsRepository favItemsRepository =
        FavItemsRepository(sqliteDbc: sqliteDbc);
    APIFavItemsRepository apiFavItemsRepository = APIFavItemsRepository();

    //Services
    LoginService loginService = LoginService(loginRepository: loginRepository);
    ItemsService itemsService = await ItemsService.createInstance(
        apiFavItemsRepository, favItemsRepository, itemsRepository);

    //UseCase
    ItemsManagerUseCase itemsManagerUseCase = ItemsManagerUseCase(
        loginService: loginService, itemsService: itemsService);

    return ItemsManagerApp(loginUseCase: itemsManagerUseCase);
  }
}
