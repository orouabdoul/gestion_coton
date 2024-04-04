import 'package:flutter/material.dart';

class ListProductPage extends StatefulWidget {
  @override
  _ListProductPageState createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  List<Product> filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    _searchController.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    String query = _searchController.text;
    List<Product> filteredList = products.where((product) {
      String productName = product.name.toLowerCase();
      return productName.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des produits'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _searchController.clear();
                filteredProducts = products;
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
                    hintText: 'Rechercher un produit...', // Ajoute un texte d'aide
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
        itemCount: filteredProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: filteredProducts[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String type;
  final int quantity;
  final double price;
  final String userName;

  Product({
    required this.name,
    required this.type,
    required this.quantity,
    required this.price,
    required this.userName,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(product.name),
      onDismissed: (direction) {
        // Action pour supprimer le produit
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text(
            product.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getColorForProduct(product.name),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${product.type}'),
              Text('Quantité: ${product.quantity.toString()}'),
              Text('Prix unitaire: ${product.price.toString()}'),
              Text('Utilisateur: ${product.userName}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  // Action pour visualiser le produit
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Détails du produit'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nom: ${product.name}'),
                            Text('Type: ${product.type}'),
                            Text('Quantité: ${product.quantity}'),
                            Text('Prix unitaire: ${product.price}'),
                            Text('Utilisateur: ${product.userName}'),
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
                  // Action pour mettre à jour le produit
                },
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          dense: true,
        ),
      ),
    );
  }

  Color _getColorForProduct(String productName) {
    // Logique pour attribuer des couleurs en fonction du nom du produit
    // Retourne une couleur fixe pour l'exemple
    return Colors.blue;
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

// Listes de produits fictifs pour les tests
List<Product> products = [
  Product(
    name: 'Produit 1',
    type: 'Type 1',
    quantity: 10,
    price: 15.99,
    userName: 'Utilisateur 1',
  ),
  Product(
    name: 'Produit 2',
    type: 'Type 2',
    quantity: 5,
    price: 25.99,
    userName: 'Utilisateur 2',
  ),
  Product(
    name: 'Produit 3',
    type: 'Type 1',
    quantity: 20,
    price: 10.99,
    userName: 'Utilisateur 3',
  ),
];
