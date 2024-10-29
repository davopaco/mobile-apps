import 'package:instamess/model/position.dart';
import 'package:instamess/model/user.dart';
import 'package:instamess/services/user_service.dart';

class UserUsecase {
  final UserService _userService;

  UserUsecase({required UserService userService}) : _userService = userService;

  Future<List<User>> getAllUsers() async {
    List<User> users = await _userService.getAllUsers();

    users.sort((a, b) {
      if (a.sameUser && !b.sameUser) {
        return -1;
      } else if (!a.sameUser && b.sameUser) {
        return 1;
      } else {
        return 0;
      }
    });
    return users;
  }

  Future<List<Position>> getAllPositions() async {
    return await _userService.getAllPositions();
  }
}
