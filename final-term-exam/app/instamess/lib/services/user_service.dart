import 'package:instamess/model/position.dart';
import 'package:instamess/model/user.dart';
import 'package:instamess/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository;

  UserService({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<List<User>> getAllUsers() async {
    return await _userRepository.getUsers();
  }

  Future<User> getUserByEmail(String email) async {
    return await _userRepository.getUser(email);
  }

  Future<List<Position>> getAllPositions() async {
    return await _userRepository.getAllPositions();
  }
}
