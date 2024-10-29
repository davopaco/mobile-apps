import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:instamess/components/login/login_view.dart';
import 'package:instamess/components/messages/messages_view.dart';
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
  // UseCases Factory
  static LoginUseCase getLoginUseCase() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    FirebaseRepository firebaseRepository = FirebaseRepository();

    //Services
    LoginService loginService = LoginService(
        loginRepository: loginRepository,
        firebaseRepository: firebaseRepository);

    //UseCases
    return LoginUseCase(loginService: loginService);
  }

  static UserUsecase getUserUseCase() {
    //Repositories
    LoginRepository loginRepository = LoginRepository();
    UserRepository userRepository =
        UserRepository(loginRepository: loginRepository);

    //Services
    UserService userService = UserService(userRepository: userRepository);

    //UseCases
    return UserUsecase(userService: userService);
  }

  static MessageUsecase getMessageUseCase() {
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
    return MessageUsecase(
        messageService: messageService, userService: userService);
  }

  // Views Factory
  static Widget getUsersView() {
    return UsersView(
      userUsecase: getUserUseCase(),
      messageUsecase: getMessageUseCase(),
      loginUsecase: getLoginUseCase(),
    );
  }

  static Widget getMessagesView() {
    return MessagesView(
        messageUsecase: getMessageUseCase(), loginUsecase: getLoginUseCase());
  }

  static Widget getLoginView() {
    return LoginView(loginUsecase: getLoginUseCase());
  }

  static Widget getRegisterView() {
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
