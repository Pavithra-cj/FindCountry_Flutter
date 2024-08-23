import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:find_country_flutter/component/search.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];
  final Dio dio = Dio();
  int page = 1;
  Map<String, dynamic>? popupData;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await dio.get('https://reqres.in/api/users?page=$page');
      final data = (response.data['data'] as List).map((json) => User.fromJson(json)).toList();

      setState(() {
        users = data;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  // Triggered when a search result or a card view is selected
  void _onUserSelected(Map<String, dynamic> data) {
    setState(() {
      popupData = data;
    });
  }

  // Close the popup window
  void _closePopup() {
    setState(() {
      popupData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Users")),
      body: SafeArea(
        child: Column(
          children: [
            // Search component at the top
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchComponent(onSearchResult: _onUserSelected),
            ),
            const SizedBox(height: 10),
            // User list
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return GestureDetector(
                    onTap: () => _onUserSelected(user.toJson()), // Open popup when tapping a card
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(user.avatar),
                              radius: 25,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID: ${user.id}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                Text("Name: ${user.first_name}",
                                    style: const TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Popup to show user details
            if (popupData != null) _buildPopup(),
          ],
        ),
      ),
    );
  }

  // Popup window to display user details
  Widget _buildPopup() {
    return AlertDialog(
      title: Text("User Details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(popupData!['avatar']),
            radius: 50,
          ),
          const SizedBox(height: 10),
          Text("ID: ${popupData!['id']}"),
          Text("Name: ${popupData!['first_name']}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _closePopup,
          child: Text("Close"),
        ),
      ],
    );
  }
}

class User {
  int id;
  String first_name;
  String avatar;

  User({required this.id, required this.first_name, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'avatar': avatar,
    };
  }
}
