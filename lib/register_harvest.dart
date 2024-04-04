import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterHarvestPage extends StatefulWidget {
  @override
  _RegisterHarvestPageState createState() => _RegisterHarvestPageState();
}

class _RegisterHarvestPageState extends State<RegisterHarvestPage> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = 'http://bls-lynia-shop-com.ibrave.host/api/';
  List<String> _fieldIds = [];
  List<String> _fieldNames = [];
  String? _selectedFieldId;
  String? _selectedFieldName;

  TextEditingController weightController = TextEditingController();
  TextEditingController priceUnitController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController observationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFields();
  }

  Future<void> _fetchFields() async {
    try {
      var response = await http.get(Uri.parse(apiUrl + 'field'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> fieldsData = responseData['body'];

        List<String> fieldIds =
            fieldsData.map((field) => field['id'].toString()).toList();
        List<String> fieldNames =
            fieldsData.map((field) => '${field['name']}').toList();

        setState(() {
          _fieldIds = fieldIds;
          _fieldNames = fieldNames;
          _selectedFieldId = _fieldIds.isNotEmpty ? _fieldIds[0] : null;
          _selectedFieldName = _fieldNames.isNotEmpty ? _fieldNames[0] : null;
        });
      } else {
        print('Failed to load fields: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching fields: $e');
    }
  }

  Future<void> createHarvest() async {
    try {
      var response = await http.post(
        Uri.parse(apiUrl + 'harvest'),
        body: {
          'weight_coton': weightController.text,
          'price_unit': priceUnitController.text,
          'date': dateController.text,
          'observation': observationController.text,
          'field_id': _selectedFieldId != null
              ? (_fieldIds.indexOf(_selectedFieldId!) + 1).toString()
              : '1',
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Succès'),
            content: Text('Pesage de recolte de coton enregistré avec succès.'),
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
        print('Harvest created successfully');
      } else {
        print('Failed to create harvest: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating harvest: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter les récoltes'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage("assets/images/harv.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Poids de coton',
                    prefixIcon: Icon(Icons.widgets, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer le poids de coton';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: priceUnitController,
                  decoration: InputDecoration(
                    labelText: 'Prix unitaire',
                    prefix: Text('€', style: TextStyle(color: Colors.green)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.green),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer le prix unitaire';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: dateController,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        // Formatage de la date pour afficher uniquement la date (sans heure)
                        dateController.text =
                            pickedDate.toLocal().toString().split(' ')[0];
                      });
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez sélectionner une date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: observationController,
                  decoration: InputDecoration(
                    labelText: 'Observation',
                    prefixIcon: Icon(Icons.note, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
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
                    labelText: 'Champs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    prefixIcon: Icon(Icons.person, color: Colors.green),
                  ),
                  value: _selectedFieldName,
                  onChanged: (value) {
                    setState(() {
                      _selectedFieldName = value.toString();
                      // Trouvez l'ID du champ correspondant
                      int index = _fieldNames.indexOf(value.toString());
                      _selectedFieldId = _fieldIds[index];
                    });
                  },
                  items: _fieldNames.map((fieldName) {
                    return DropdownMenuItem(
                      value: fieldName,
                      child: Text(fieldName),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner un champ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createHarvest();
                    }
                  },
                  child: Text(
                    'Soumettre',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
