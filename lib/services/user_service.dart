import '../models/user_model.dart';

class UserService {
  // Simulamos una API externa usando Future.delayed
  Future<List<UserModel>> getAllUsers() async {
    await Future.delayed(const Duration(seconds: 1)); // simula red

    return [
      UserModel(id: 1, name: "Fernando García", email: "fernando@example.com", website: "https://fernando.dev"),
      UserModel(id: 2, name: "Laura Martínez", email: "laura@example.com", website: "https://laura.com"),
    ];
  }

  Future<UserModel> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500)); // simula red

    // Datos ficticios
    return UserModel(id: id, name: "Usuario #$id", email: "user$id@example.com", website: "https://website$id.com");
  }
}
