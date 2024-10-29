import 'package:instamess/model/user.dart';
import 'package:instamess/services/user_service.dart';

class UserUsecase {
  final UserService _userService;

  UserUsecase({required UserService userService}) : _userService = userService;

  Future<List<User>> getAllUsers() async {
    return await _userService.getAllUsers();
  }
}
