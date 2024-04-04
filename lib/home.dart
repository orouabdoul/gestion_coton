import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';

class HomePageContent extends StatelessWidget {
  final List<Map<String, dynamic>> sections = [
    {
      'title': 'Semences de coton',
      'description': 'Description pour Semences de coton',
      'images': [
        'assets/images/semense1.jpg',
        'assets/images/semense2.jpg',
        'assets/images/semense3.jpg',
        'assets/images/semense4.jpg',
        'assets/images/semense5.png',
      ],
    },
    {
      'title': 'Sacrage',
      'description': 'Description pour Sacrage',
      'images': [
        'assets/images/sacrage1.jpg',
        'assets/images/sacrage4.jpeg',
        'assets/images/sacrage5.jpeg',
        'assets/images/sacrage6.png',
        'assets/images/sacrage7.jpeg',
        
      ],
    },
    {
      'title': 'Traitement des insecticides',
      'description': 'Description pour Traitement des insecticides',
      'images': [
        'assets/images/traitement.jpeg',
        'assets/images/traitement1.jpg',
        'assets/images/traitement1.png',
        'assets/images/traitement2.jpeg',
        'assets/images/traitement3.jpg',
      ],
    },
    {
      'title': 'Les récoltes',
      'description': 'Description pour Les récoltes',
      'images': [
        'assets/images/recolte1.jpeg',
        'assets/images/recolte1.jpg',
        'assets/images/recolte2.jpg',
        'assets/images/recolte4.jpeg',
        'assets/images/recolte5.jpeg',
      ],
    },
    {
      'title': 'Pesage des cotons',
      'description': 'Description pour Pesage des cotons',
      'images': [
        'assets/images/pesage.jpeg',
        'assets/images/pesage1.jpg',
        'assets/images/pesage2.jpg',
        'assets/images/pesage4.jpg',
        'assets/images/pesage5.jpeg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return SectionWidget(
            title: section['title'],
            description: section['description'],
            images: section['images'],
          );
        },
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<String> images;

  SectionWidget({
    required this.title,
    required this.description,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
              height:
                  10), // Ajout d'un espacement entre le titre et le CarouselSlider
          images.isNotEmpty
              ? Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: images.length,
                        options: CarouselOptions(
                          height: 300,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final image = images[index];
                          return _buildImage(image);
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 141, 135, 135)
                                  .withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
          SizedBox(
              height:
                  10), // Ajout d'un espacement supplémentaire entre le texte de description et le bas du conteneur
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: PhotoView(
            imageProvider: AssetImage(image),
            minScale: PhotoViewComputedScale.contained * 0.9,
            enableRotation: true, // Activer la rotation de l'image
            heroAttributes: PhotoViewHeroAttributes(
                tag:
                    image), // Ajouter un attribut héroïque pour l'effet de transition
            loadingBuilder: (context, event) => Center(
              child:
                  CircularProgressIndicator(), // Afficher un indicateur de chargement
            ),
            customSize:
                Size(double.infinity, 300), // Ajuster la taille de l'image
          ),
        ),
      ),
    );
  }
}
