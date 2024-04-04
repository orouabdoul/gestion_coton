import 'package:flutter/material.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connectez-vous',
          style: TextStyle(
            fontSize: 20, // Taille de la police
            fontWeight: FontWeight.bold, // Gras
          ),
        ),
        centerTitle: true, // Centre le titre de l'app bar
        backgroundColor: Colors.green, // Couleur de l'app bar
      ),
      body: Container(
        color: Colors.white, // Couleur de fond de la page
        child: Center(
          child: SingleChildScrollView(
            child: LoginForm(), // Utilisez le widget du formulaire de connexion
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white, // Couleur de fond du conteneur
        borderRadius: BorderRadius.circular(10.0), // Bord arrondi du conteneur
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50, // Ajustez la taille du cercle selon vos besoins
            backgroundImage: AssetImage(
                'assets/images/3.jpg'), // Remplacez par le chemin de votre image de logo
          ),
          SizedBox(height: 30.0), // Espace vertical
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                prefixIcon: Icon(Icons.person), // Ajoute une icône de personne
                border: OutlineInputBorder(
                  // Style de bordure
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0), // Espace vertical
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              obscureText:
                  true, // Masque le texte pour le champ de mot de passe
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock), // Ajoute une icône de cadenas
                border: OutlineInputBorder(
                  // Style de bordure
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0), // Espace vertical
          ElevatedButton(
            onPressed: () {
              // Action à effectuer lors de la soumission du formulaire
            },
            child: Text('Se connecter'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Couleur du texte
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ), // Espacement interne
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Bord arrondi
              ),
              elevation: 3, // Ombre
            ),
          ),
          SizedBox(height: 10.0), // Espace vertical
          TextButton(
            onPressed: () {
              // Action à effectuer lors de l'appui sur le bouton d'inscription
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              'Pas encore inscrit ? S\'inscrire ici',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold, // Gras
              ),
            ),
          ),
        ],
      ),
    );
  }
}
