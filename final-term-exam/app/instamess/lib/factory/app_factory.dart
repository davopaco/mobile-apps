import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:instamess/components/login/login_view.dart';
import 'package:instamess/components/users/users_view.dart';
import 'package:instamess/repositories/firebase_repository.dart';
import 'package:instamess/repositories/login_repository.dart';
import 'package:instamess/repositories/message_repository.dart';
import 'package:instamess/repositories/user_repository.dart';
import 'package:instamess/services/login_service.dart';
import 'package:instamess/services/message_service.dart';
import 'package:instamess/services/user_service.dart';
import 'package:instamess/usecases/app_usecase.dart';
import 'package:instamess/usecases/login_usecase.dart';
import 'package:instamess/usecases/message_usecase.dart';
import 'package:instamess/usecases/user_usecase.dart';

class AppFactory {
  static Widget getUsersView() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    MessageRepository messageRepository =
        MessageRepository(loginRepository: loginRepository);
    UserRepository userRepository =
        UserRepository(loginRepository: loginRepository);

    //Services
    MessageService messageService =
        MessageService(messageRepository: messageRepository);
    UserService userService = UserService(userRepository: userRepository);

    //UseCases
    UserUsecase userUsecase = UserUsecase(userService: userService);
    MessageUsecase messageUsecase = MessageUsecase(
        messageService: messageService, userService: userService);

    return UsersView(userUsecase: userUsecase, messageUsecase: messageUsecase);
  }

  static Widget getMessagesView() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    MessageRepository messageRepository =
        MessageRepository(loginRepository: loginRepository);
    UserRepository userRepository =
        UserRepository(loginRepository: loginRepository);

    //Services
    MessageService messageService =
        MessageService(messageRepository: messageRepository);
    UserService userService = UserService(userRepository: userRepository);

    //UseCases
    UserUsecase userUsecase = UserUsecase(userService: userService);
    MessageUsecase messageUsecase = MessageUsecase(
        messageService: messageService, userService: userService);

    return Container();
  }

  static Widget getLoginView() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    FirebaseRepository firebaseRepository = FirebaseRepository();

    //Services
    LoginService loginService = LoginService(
        loginRepository: loginRepository,
        firebaseRepository: firebaseRepository);

    //UseCases
    LoginUsecase loginUsecase = LoginUsecase(loginService: loginService);

    return LoginView(loginUsecase: loginUsecase);
  }

  static Widget getRegisterView() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    UserRepository userRepository =
        UserRepository(loginRepository: loginRepository);

    //Services
    UserService userService = UserService(userRepository: userRepository);

    //UseCases
    UserUsecase userUsecase = UserUsecase(userService: userService);

    return Container();
  }

  static Future<Widget> getInstamessView() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    FirebaseRepository firebaseRepository = FirebaseRepository();

    //Services
    LoginService loginService = LoginService(
        loginRepository: loginRepository,
        firebaseRepository: firebaseRepository);

    //UseCases
    AppUsecase appUsecase = AppUsecase(loginService: loginService);

    return appUsecase.getInstamessView();
  }
}
