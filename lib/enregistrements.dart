import 'package:flutter/material.dart';
import 'register_users.dart';
import 'register_field.dart';
import 'register_product.dart';
import 'register_harvest.dart';

class EnregistrementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enregistrements',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/farm.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildElevatedButton(
                    context,
                    text: 'Enregistrer agriculteur',
                    destination: RegisterUsersPage(),
                  ),
                  SizedBox(height: 20),
                  _buildElevatedButton(
                    context,
                    text: 'Enregistrer champ',
                    destination: RegisterFieldPage(),
                  ),
                  SizedBox(height: 20),
                  _buildElevatedButton(
                    context,
                    text: 'Enregistrer produit',
                    destination: RegisterProductPage(),
                  ),
                  SizedBox(height: 20),
                  _buildElevatedButton(
                    context,
                    text: 'Enregistrer récolte',
                    destination: RegisterHarvestPage(),
                  ),
                  SizedBox(height: 20), // Ajout d'un espace en bas
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context,
      {required String text, required Widget destination}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
