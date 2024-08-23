import 'package:flutter/material.dart';

class UserDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserDetailsDialog({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(userData['avatar']),
            ),
            const SizedBox(height: 16),
            Text("ID: ${userData['id']}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Name: ${userData['first_name']}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
