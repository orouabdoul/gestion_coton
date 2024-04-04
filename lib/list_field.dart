import 'package:flutter/material.dart';

class Field {
  final String name;
  final String location;
  final double surface;
  final String observation;
  final String userName;

  Field({
    required this.name,
    required this.location,
    required this.surface,
    required this.observation,
    required this.userName,
  });
}

class ListFieldPage extends StatefulWidget {
  @override
  _ListFieldPageState createState() => _ListFieldPageState();
}

class _ListFieldPageState extends State<ListFieldPage> {
  final List<Field> fields = [
    Field(
      name: 'Champ A',
      location: 'Localisation A',
      surface: 10.5,
      observation: 'Observation du champ A',
      userName: 'Utilisateur 1',
    ),
    Field(
      name: 'Champ B',
      location: 'Localisation B',
      surface: 8.2,
      observation: 'Observation du champ B',
      userName: 'Utilisateur 2',
    ),
    Field(
      name: 'Champ C',
      location: 'Localisation C',
      surface: 12.0,
      observation: 'Observation du champ C',
      userName: 'Utilisateur 3',
    ),
  ];

  List<Field> filteredFields = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredFields = fields;
    _searchController.addListener(() {
      filterFields();
    });
  }

  void filterFields() {
    String query = _searchController.text;
    List<Field> filteredList = fields.where((field) {
      String fieldName = field.name.toLowerCase();
      return fieldName.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredFields = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des champs'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _searchController.clear();
                filteredFields = fields;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // Augmente la hauteur
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), // Ajoute de la marge en haut et en bas
            child: Container(
              width: double.infinity, // Utilise toute la largeur disponible
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0), // Ajoute une bordure arrondie
                border: Border.all(color: Colors.grey), // Ajoute une bordure grise
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0), // Augmente l'espacement horizontal
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher un champ...', // Ajoute un texte d'aide
                    border: InputBorder.none, // Supprime la bordure par défaut du TextField
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
      body: ListView.builder(
        itemCount: filteredFields.length,
        itemBuilder: (context, index) {
          final field = filteredFields[index];
          return Dismissible(
            key: Key(index.toString()),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                fields.removeAt(index);
                filteredFields.removeAt(index);
              });
            },
            direction: DismissDirection.startToEnd,
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text('Nom: ${field.name}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Surface: ${field.surface.toString()} ha'),
                    Text('Nom utilisateur: ${field.userName}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Détails du champ'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nom: ${field.name}'),
                                  Text('Localisation: ${field.location}'),
                                  Text(
                                      'Surface: ${field.surface.toString()} ha'),
                                  Text('Observation: ${field.observation}'),
                                  Text('Nom utilisateur: ${field.userName}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Fermer'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Action de mise à jour
                        // À implémenter
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
