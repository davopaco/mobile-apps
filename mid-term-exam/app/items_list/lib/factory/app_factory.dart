import 'package:items_list/components/items/items_view.dart';
import 'package:items_list/components/login/login_view.dart';
import 'package:items_list/repositories/api_fav_items_repository.dart';
import 'package:items_list/repositories/fav_items_repository.dart';
import 'package:items_list/repositories/items_repository.dart';
import 'package:items_list/services/items_service.dart';
import 'package:items_list/items_manager_app.dart';
import 'package:items_list/repositories/login_repository.dart';
import 'package:items_list/services/login_service.dart';
import 'package:items_list/usecases/items_manager_usecase.dart';
import 'package:items_list/usecases/items_usecase.dart';
import 'package:items_list/usecases/login_usecase.dart';
import 'package:items_list/util/sqlite_dbc.dart';

class AppFactory {
  static Future<ItemsManagerApp> getItemsManagerApp() async {
    //Repositories
    LoginRepository loginRepository = LoginRepository();

    //Services
    LoginService loginService = LoginService(loginRepository: loginRepository);

    //UseCase
    ItemsManagerUseCase itemsManagerUseCase =
        ItemsManagerUseCase(loginService: loginService);

    return ItemsManagerApp(itemManagerUseCase: itemsManagerUseCase);
  }

  static LoginView getLoginView() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();

    //Services
    LoginService loginService = LoginService(loginRepository: loginRepository);

    //UseCase
    LoginUsecase loginUseCase = LoginUsecase(loginService: loginService);

    return LoginView(
      loginUsecase: loginUseCase,
    );
  }

  static Future<ItemsView> getItemsView({required bool isFavoriteView}) async {
    SqliteDbc sqliteDbc = await SqliteDbc.createInstance();

    //Repositories
    LoginRepository loginRepository = LoginRepository();
    ItemsRepository itemsRepository =
        ItemsRepository(loginRepository: loginRepository);
    FavItemsRepository favItemsRepository =
        FavItemsRepository(sqliteDbc: sqliteDbc);
    APIFavItemsRepository apiFavItemsRepository =
        APIFavItemsRepository(loginRepository: loginRepository);

    //Services
    ItemsService itemsService = await ItemsService.createInstance(
        apiFavItemsRepository, favItemsRepository, itemsRepository);
    LoginService loginService = LoginService(loginRepository: loginRepository);

    //UseCase
    ItemsUseCase itemsUseCase = ItemsUseCase(itemsService: itemsService);
    LoginUsecase loginUseCase = LoginUsecase(loginService: loginService);

    return ItemsView(
      loginUsecase: loginUseCase,
      isFavoriteView: isFavoriteView,
      itemsUseCase: itemsUseCase,
    );
  }
}
