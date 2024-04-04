import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterProductPage extends StatefulWidget {
  @override
  _RegisterProductPageState createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = 'http://bls-lynia-shop-com.ibrave.host/api/';
  List<String> _userIds = [];
  List<String> _userNames = [];
  String? _selectedUserId;
  String? _selectedUserName;

  TextEditingController nameController = TextEditingController();
  TextEditingController typeproductController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceunitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  Future<void> createProduct() async {
    try {
      var response = await http.post(
        Uri.parse(apiUrl + 'product'),
        body: {
          'name': nameController.text,
          'type_product': typeproductController.text,
          'quantity': quantityController.text,
          'price_unit': priceunitController.text,
          'description': descriptionController.text,
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
            content: Text('Produit créé avec succès.'),
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
        print('Product created successfully');
      } else {
        print('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire de Produit'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              image: DecorationImage(
                                image: AssetImage("assets/images/product.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Nom du produit',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              prefixIcon:
                                  Icon(Icons.shopping_bag, color: Colors.green),
                            ),
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer le nom du produit';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: typeproductController,
                            decoration: InputDecoration(
                              labelText: 'Type de produit',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              prefixIcon:
                                  Icon(Icons.category, color: Colors.green),
                            ),
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer le type de produit';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              labelText: 'Quantité',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              prefixIcon: Icon(Icons.format_list_numbered,
                                  color: Colors.green),
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer la quantité';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: priceunitController,
                            decoration: InputDecoration(
                              labelText: 'Prix unitaire',
                              prefix: Text('€',
                                  style: TextStyle(color: Colors.green)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              prefixIcon:
                                  Icon(Icons.attach_money, color: Colors.green),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer le prix unitaire';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              prefixIcon:
                                  Icon(Icons.description, color: Colors.green),
                            ),
                            maxLines: 3,
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer une description';
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
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.green),
                            ),
                            value: _selectedUserName,
                            onChanged: (value) {
                              setState(() {
                                _selectedUserName = value.toString();
                                // Find corresponding user ID
                                int index =
                                    _userNames.indexOf(value.toString());
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
                                createProduct();
                              }
                            },
                            child: Text(
                              'Enregistrer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
