import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'countrydetails.dart';
import 'component/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Country> countries = [];
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final response = await dio.get('https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,population');
      final data = (response.data as List).map((json) => Country.fromJson(json)).toList();

      setState(() {
        countries = data;
      });
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  void _onCountrySelected(Map<String, dynamic> countryData) {
    showDialog(
      context: context,
      builder: (context) => CountryDetailsDialog(countryData: countryData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Countries")),
      body: SafeArea(
        child: Column(
          children: [
            // Search component
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchComponent(onSearchResult: _onCountrySelected),
            ),
            const SizedBox(height: 10),
            // Country list
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return GestureDetector(
                    onTap: () => _onCountrySelected(country.toJson()),
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
                              backgroundImage: NetworkImage(country.flag),
                              radius: 25,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${country.name}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                Text("Capital: ${country.capital}",
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
          ],
        ),
      ),
    );
  }
}

class Country {
  String name;
  String capital;
  String flag;

  Country({required this.name, required this.capital, required this.flag});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: (json['capital'] as List).first,
      flag: json['flags']['png'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capital': capital,
      'flag': flag,
    };
  }
}