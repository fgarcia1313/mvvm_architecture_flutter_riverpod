import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/user_viewmodel.dart';

class UserDetailPage extends ConsumerWidget {
  final int userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(userNotifierProvider.notifier);

    return FutureBuilder(
      future: vm.loadUserById(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text(user.name)),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${user.id}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),

                Text('Name: ${user.name}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),

                Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),

                Text('Website: ${user.website}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
      },
    );
  }
}
