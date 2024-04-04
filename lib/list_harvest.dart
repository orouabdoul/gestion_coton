import 'package:flutter/material.dart';

class Harvest {
  final String weightCoton;
  final double priceUnit;
  final DateTime date;
  final String observation;
  final String userField;

  Harvest({
    required this.weightCoton,
    required this.priceUnit,
    required this.date,
    required this.observation,
    required this.userField,
  });
}

class ListHarvestPage extends StatefulWidget {
  @override
  _ListHarvestPageState createState() => _ListHarvestPageState();
}

class _ListHarvestPageState extends State<ListHarvestPage> {
  final List<Harvest> harvests = [
    Harvest(
      weightCoton: '50 kg',
      priceUnit: 2.5,
      date: DateTime(2022, 10, 15),
      observation: 'Good quality cotton',
      userField: 'Field A',
    ),
    Harvest(
      weightCoton: '45 kg',
      priceUnit: 2.7,
      date: DateTime(2022, 11, 20),
      observation: 'Slight impurities',
      userField: 'Field B',
    ),
    Harvest(
      weightCoton: '55 kg',
      priceUnit: 2.6,
      date: DateTime(2022, 12, 5),
      observation: 'Excellent yield',
      userField: 'Field C',
    ),
  ];

  List<Harvest> filteredHarvests = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredHarvests = harvests;
    _searchController.addListener(() {
      filterHarvests();
    });
  }

  void filterHarvests() {
    String query = _searchController.text;
    List<Harvest> filteredList = harvests.where((harvest) {
      String harvestWeight = harvest.weightCoton.toLowerCase();
      return harvestWeight.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredHarvests = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des récoltes'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _searchController.clear();
                filteredHarvests = harvests;
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
                    hintText: 'Rechercher une récolte...', // Ajoute un texte d'aide
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
        itemCount: filteredHarvests.length,
        itemBuilder: (context, index) {
          final harvest = filteredHarvests[index];
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
                harvests.removeAt(index);
                filteredHarvests.removeAt(index);
              });
            },
            direction: DismissDirection.startToEnd,
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text('Weight: ${harvest.weightCoton}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: \$${harvest.priceUnit.toString()}'),
                    Text('Date: ${harvest.date.day}/${harvest.date.month}/${harvest.date.year}'),
                    Text('User Field: ${harvest.userField}'),
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
                              title: Text('Détails de la récolte'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Poids: ${harvest.weightCoton}'),
                                  Text('Price: \$${harvest.priceUnit.toString()}'),
                                  Text('Date: ${harvest.date.day}/${harvest.date.month}/${harvest.date.year}'),
                                  Text('Observation: ${harvest.observation}'),
                                  Text(
                                      'Champ utilisateur: ${harvest.userField}'),
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

class _DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Not required for now
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Not required for now
    return Container();
  }
}
