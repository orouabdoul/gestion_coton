import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterUsersPage extends StatefulWidget {
  @override
  _RegisterUsersPageState createState() => _RegisterUsersPageState();
}

class _RegisterUsersPageState extends State<RegisterUsersPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> roles = [];
  String? selectedRole;
  final String apiUrl = 'http://bls-lynia-shop-com.ibrave.host/api/';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController boroughController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      var response = await http.get(Uri.parse(apiUrl + 'role'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> rolesData = responseData['body'];

        List<String> roleNames =
            rolesData.map((role) => role['name'].toString()).toList();

        setState(() {
          roles = roleNames;
        });
      } else {
        print('Failed to load roles: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching roles: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        var response = await http.post(
          Uri.parse(apiUrl + 'user'),
          body: {
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            'sexe': sexeController.text,
            'phone': phoneController.text,
            'department': departmentController.text,
            'common': communeController.text,
            'borough': boroughController.text,
            'neighborhood': neighborhoodController.text,
            'password': passwordController.text,
            'role_id': selectedRole != null
                ? (roles.indexOf(selectedRole!) + 1).toString()
                : '1',
          },
        );

        if (response.statusCode == 200) {
          // Afficher une alerte de succès
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Succès'),
              content: Text('Utilisateur créé avec succès.'),
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
          print('User created successfully');
        } else {
          print('Failed to create user: ${response.statusCode}');
          // Afficher une alerte ou effectuer une action en cas d'échec de la requête
        }
      } catch (e) {
        print('Error creating user: $e');
        // Afficher une alerte ou effectuer une action en cas d'erreur
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter des agriculteurs'),
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
                          image: AssetImage(
                            "assets/images/regist.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                        hintText: 'Entrez votre prénom',
                        prefixIcon: Icon(Icons.person, color: Colors.green),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre prénom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Ajoutez d'autres champs de formulaire ici
                    // Exemple de champ de formulaire supplémentaire
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom de famille',
                        hintText: 'Entrez votre nom de famille',
                        prefixIcon:
                            Icon(Icons.person_outline, color: Colors.green),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre nom de famille';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Exemple de champ de formulaire supplémentaire
                    TextFormField(
                      controller: sexeController,
                      decoration: InputDecoration(
                        labelText: 'Sexe',
                        hintText: 'Entrez votre sexe',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon:
                            Icon(Icons.accessibility, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre sexe';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Téléphone',
                        hintText: 'Entrez votre numéro de téléphone',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.phone, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre numéro de téléphone';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Other form fields go here
                    // Exemple de champ de formulaire supplémentaire
                    TextFormField(
                      controller: departmentController,
                      decoration: InputDecoration(
                        labelText: 'Département',
                        hintText: 'Entrez votre département',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon:
                            Icon(Icons.location_city, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre département';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Exemple de champ de formulaire supplémentaire
                    TextFormField(
                      controller: communeController,
                      decoration: InputDecoration(
                        labelText: 'Commune',
                        hintText: 'Entrez votre commune',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.location_city_outlined,
                            color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre commune';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Exemple de champ de formulaire supplémentaire
                    TextFormField(
                      controller: boroughController,
                      decoration: InputDecoration(
                        labelText: 'Arrondissement',
                        hintText: 'Entrez votre arrondissement',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon:
                            Icon(Icons.location_pin, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre arrondissement';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Exemple de champ de formulaire supplémentaire
                    TextFormField(
                      controller: neighborhoodController,
                      decoration: InputDecoration(
                        labelText: 'Quartier',
                        hintText: 'Entrez votre quartier',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.pin_drop, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre quartier';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer un mot de passe';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Rôle',
                        hintText: 'Sélectionnez votre rôle',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.person_add, color: Colors.green),
                      ),
                      style: TextStyle(color: Colors.black),
                      value: selectedRole,
                      items: roles.map((String role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value as String?;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner un rôle';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Soumettre',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 15),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(10),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.grey[800]!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
