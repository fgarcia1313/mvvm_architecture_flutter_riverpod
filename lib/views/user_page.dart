import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/user_viewmodel.dart';
import 'user_detail_page.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: switch (state) {
      // ------------------------------------
      // 🔵 LOADING
      // ------------------------------------
        AsyncLoading() =>
        const Center(child: CircularProgressIndicator()),

      // ------------------------------------
      // 🔴 ERROR
      // ------------------------------------
        AsyncError(:final error) =>
            Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),

      // ------------------------------------
      // 🟢 LISTA DE USUARIOS
      // ------------------------------------
        AsyncData(value: final users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, i) {
            final user = users[i];

            return ListTile(
              title: Text(user.name),
              subtitle: Text("${user.email} | Website: ${user.website}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserDetailPage(userId: user.id),
                  ),
                );
              },
            );
          },
        ),
      },
    );
  }
}
