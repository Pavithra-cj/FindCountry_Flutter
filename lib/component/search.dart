import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SearchComponent extends StatefulWidget {
  final Function(Map<String, dynamic>) onSearchResult;

  const SearchComponent({Key? key, required this.onSearchResult}) : super(key: key);

  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  bool _isSearching = false;

  void _handleSearch() async {
    final searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await _dio.get('https://restcountries.com/v3.1/name/$searchText?fields=name,capital,flags,population,languages');
      final data = (response.data as List).first;

      if (data != null) {
        widget.onSearchResult(data);
      } else {
        _showAlertDialog('404: Country does not exist.');
      }
    } catch (e) {
      _showAlertDialog('Error fetching country details: $e');
    }

    setState(() {
      _isSearching = false;
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Country Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _isSearching ? null : _handleSearch,
          child: _isSearching ? CircularProgressIndicator() : Text('Search'),
        ),
      ],
    );
  }
}