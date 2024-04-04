import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
      ),
      body: ListView.builder(
        itemCount: agriculteurs.length,
        itemBuilder: (context, index) {
          final agriculteur = agriculteurs[index];
          return Card(
            child: ListTile(
              title: Text(agriculteur.nom),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Champs: ${agriculteur.champs}'),
                  Text('Produits: ${agriculteur.produits.join(", ")}'),
                  Text('Type: ${agriculteur.types.join(", ")}'),
                  Text('Récolte: ${agriculteur.recolte}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Handle action for arrondissement balance
            },
            tooltip: 'Arrondissement',
            child: Icon(Icons.location_city),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Handle action for communale balance
            },
            tooltip: 'Communale',
            child: Icon(Icons.location_on),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Handle action for departementale balance
            },
            tooltip: 'Départementale',
            child: Icon(Icons.location_searching),
          ),
        ],
      ),
    );
  }
}

class Agriculteur {
  final String nom;
  final String champs;
  final List<String> produits;
  final List<String> types;
  final double recolte;

  Agriculteur({
    required this.nom,
    required this.champs,
    required this.produits,
    required this.types,
    required this.recolte,
  });
}

List<Agriculteur> agriculteurs = [
  Agriculteur(
    nom: 'Agriculteur 1',
    champs: 'Champs 1',
    produits: ['Produit 1', 'Produit 2'],
    types: ['Type 1', 'Type 2'],
    recolte: 100.0,
  ),
  Agriculteur(
    nom: 'Agriculteur 2',
    champs: 'Champs 2',
    produits: ['Produit 3', 'Produit 4'],
    types: ['Type 3', 'Type 4'],
    recolte: 150.0,
  ),
  Agriculteur(
    nom: 'Agriculteur 3',
    champs: 'Champs 3',
    produits: ['Produit 5', 'Produit 6'],
    types: ['Type 5', 'Type 6'],
    recolte: 200.0,
  ),
];
