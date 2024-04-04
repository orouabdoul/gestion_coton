import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Farmer {
  final String firstName;
  final String lastName;
  final String commune;
  final String arrondissement;

  Farmer({
    required this.firstName,
    required this.lastName,
    required this.commune,
    required this.arrondissement,
  });
}

class ListUsersPage extends StatefulWidget {
  @override
  _ListUsersPageState createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  List<Farmer> farmers = [];
  bool isLoading = false;
  String errorMessage = '';

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFarmers();
    _searchController.addListener(() {
      filterFarmers();
    });
  }

  Future<void> fetchFarmers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http
          .get(Uri.parse('http://bls-lynia-shop-com.ibrave.host/api/user'));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        if (data != null && data is List) {
          setState(() {
            farmers = data
                .map((item) => Farmer(
                      firstName: item['first_name'],
                      lastName: item['last_name'],
                      commune: item['common'],
                      arrondissement: item['borough'],
                    ))
                .toList();
            isLoading = false;
            errorMessage = '';
          });
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load farmers: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void filterFarmers() {
    // Implement your filtering logic here if needed
    // For example, you can filter the farmers based on their names
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des agriculteurs'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchFarmers,
          ),
        ],
        // Add search functionality if needed
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: farmers.length,
                  itemBuilder: (context, index) {
                    final farmer = farmers[index];
                    return ListTile(
                      title: Text(
                        '${farmer.firstName} ${farmer.lastName}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text('${farmer.commune}, ${farmer.arrondissement}'),
                      // Add additional actions or functionality here
                    );
                  },
                ),
    );
  }
}
