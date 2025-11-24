import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

// -----------------------------------------------------
// PROVIDER DEL SERVICE
// -----------------------------------------------------
final userServiceProvider = Provider((ref) => UserService());

// -----------------------------------------------------
// PROVIDER DEL VIEWMODEL (USANDO ASYNCNOTIFIER)
// -----------------------------------------------------
final userNotifierProvider =
AsyncNotifierProvider<UserViewModel, List<UserModel>>(
  UserViewModel.new,
);

// -----------------------------------------------------
// VIEWMODEL / LOGICA DE PRESENTACION
// -----------------------------------------------------
class UserViewModel extends AsyncNotifier<List<UserModel>> {
  late final UserService _service;

  @override
  Future<List<UserModel>> build() async {
    // inyección del service
    _service = ref.read(userServiceProvider);

    // carga inicial automática (equivalente a onInit())
    return await _service.getAllUsers();
  }

  // ----------------------------------------
  // CARGAR TODOS LOS USUARIOS
  // ----------------------------------------
  Future<void> loadUsers() async {
    state = const AsyncLoading();

    try {
      final users = await _service.getAllUsers();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // ----------------------------------------
  // CARGAR UN USUARIO POR ID
  // ----------------------------------------
  Future<UserModel?> loadUserById(int id) async {
    try {
      final user = await _service.getUserById(id);
      return user;
    } catch (e) {
      return null;
    }
  }
}
