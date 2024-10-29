import 'package:instamess/model/user.dart';
import 'package:instamess/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository;

  UserService({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<List<User>> getAllUsers() async {
    return await _userRepository.getUsers();
  }
}
