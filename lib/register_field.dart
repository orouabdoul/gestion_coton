import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterFieldPage extends StatefulWidget {
  @override
  _RegisterFieldPageState createState() => _RegisterFieldPageState();
}

class _RegisterFieldPageState extends State<RegisterFieldPage> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = 'http://bls-lynia-shop-com.ibrave.host/api/';
  List<String> _userIds = [];
  List<String> _userNames = [];
  String? _selectedUserId;
  String? _selectedUserName;

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();
  TextEditingController observationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      var response = await http.get(Uri.parse(apiUrl + 'user'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> usersData = responseData['body'];

        List<String> userIds =
            usersData.map((user) => user['id'].toString()).toList();
        List<String> userNames = usersData
            .map((user) => '${user['first_name']} ${user['last_name']}')
            .toList();

        setState(() {
          _userIds = userIds;
          _userNames = userNames;
          _selectedUserId = _userIds.isNotEmpty ? _userIds[0] : null;
          _selectedUserName = _userNames.isNotEmpty ? _userNames[0] : null;
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> createField() async {
    try {
      var response = await http.post(
        Uri.parse(apiUrl + 'field'),
        body: {
          'name': nameController.text,
          'location': locationController.text,
          'surface': surfaceController.text,
          'observation': observationController.text,
          'user_id': _selectedUserId != null
              ? (_userIds.indexOf(_selectedUserId!) + 1).toString()
              : '1',
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Succès'),
            content: Text('Champ enregistré avec succès.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        print('Field created successfully');
      } else {
        print('Failed to create field: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating field: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Champ'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/field.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.person, color: Colors.green),
                  ),
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'lieu du champ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.location_on, color: Colors.green),
                  ),
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer lieu du champ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: surfaceController,
                  decoration: InputDecoration(
                    labelText: 'Surface',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.square_foot, color: Colors.green),
                  ),
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer une surface';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: observationController,
                  decoration: InputDecoration(
                    labelText: 'Observation',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.notes, color: Colors.green),
                  ),
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer une observation';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Agriculteur',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.person, color: Colors.green),
                  ),
                  value: _selectedUserName,
                  onChanged: (value) {
                    setState(() {
                      _selectedUserName = value.toString();
                      // Find corresponding user ID
                      int index = _userNames.indexOf(value.toString());
                      _selectedUserId = _userIds[index];
                    });
                  },
                  items: _userNames.map((userName) {
                    return DropdownMenuItem(
                      value: userName,
                      child: Text(userName),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner un utilisateur';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createField();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Enregistrer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 27, 27, 27),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterFieldPage(),
  ));
}
