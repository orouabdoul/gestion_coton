import 'package:flutter/material.dart';
import 'home.dart';
import 'enregistrements.dart';
import 'listes.dart';
import 'bilan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon application',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePageContent(),
    EnregistrementPage(),
    ListesPage(),
    BalancePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GEST_COTON'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Insérer la logique de déconnexion ici
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Enregistrements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Bilan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.4, // Ajustez la largeur du Drawer selon vos besoins
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Nom de l\'utilisateur', // Remplacez par le nom de l'utilisateur actuel
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  'Email de l\'utilisateur', // Remplacez par l'email de l'utilisateur actuel
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/coton.jpg'), // Image de profil
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Accueil',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onItemTapped(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_shopping_cart, color: Colors.white),
                title: Text(
                  'Enregistrements',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onItemTapped(1);
                },
              ),
              ListTile(
                leading: Icon(Icons.list, color: Colors.white),
                title: Text(
                  'Listes',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onItemTapped(2);
                },
              ),
              ListTile(
                leading: Icon(Icons.bar_chart, color: Colors.white),
                title: Text(
                  'Bilan',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onItemTapped(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
