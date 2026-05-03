import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resident Evil - Top 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF8B0000),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFF1a1a1a),
      ),
      home: const MyHomePage(),
    );
  }
}

/// Modelo de datos para un juego de Resident Evil
class ResidentEvilGame {
  final String titulo;
  final String nombreComercial;
  final int anioLanzamiento;
  final String rutaImagen;
  final String? iconPath;

  ResidentEvilGame({
    required this.titulo,
    required this.nombreComercial,
    required this.anioLanzamiento,
    required this.rutaImagen,
    this.iconPath,
  });
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _appBarTitle = "Hola, Flutter 1.0.1";

  List<ResidentEvilGame> get _residentEvilGames => [
    ResidentEvilGame(
      titulo: "RE2",
      nombreComercial: "Resident Evil 2 Remake",
      anioLanzamiento: 2019,
      rutaImagen: "assets/images/resident-evil-2-review_eyg9.jpg",
      iconPath: "assets/images/first-rank.png",
    ),
    ResidentEvilGame(
      titulo: "RE1",
      nombreComercial: "Resident Evil 1 Remake",
      anioLanzamiento: 2002,
      rutaImagen: "assets/images/do-you-think-re-1-will-ever-get-a-full-remake-in-the-future-v0-4wshwiat357f1.jpg",
      iconPath: "assets/images/second-rank.png",
    ),
    ResidentEvilGame(
      titulo: "RE4",
      nombreComercial: "Resident Evil 4 Remake",
      anioLanzamiento: 2023,
      rutaImagen: "assets/images/capsule_616x353.jpg",
      iconPath: "assets/images/third-rank.png",
    ),
    ResidentEvilGame(
      titulo: "RE9",
      nombreComercial: "Resident Evil Requiem",
      anioLanzamiento: 2026,
      rutaImagen: "assets/images/69ae25ca5cb1b.png",
    ),
    ResidentEvilGame(
      titulo: "RE8",
      nombreComercial: "Resident Evil Village",
      anioLanzamiento: 2021,
      rutaImagen: "assets/images/16x9_ResidentEvilVillageGoldEdition_image1600w.jpg",
    ),
  ];

  void _toggleTitle() {
    setState(() {
      _appBarTitle = _appBarTitle == "Hola, Flutter 1.0.1"
          ? "¡Título cambiado!"
          : "Hola, Flutter 1.0.1";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Título: $_appBarTitle',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Color(0xFF8B0000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B0000),
        title: Text(
          _appBarTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Andres David Guevara Martinez',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B6B),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF8B0000), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      'https://game.capcom.com/residentevil/pc/img/anniversary-30th/img_main.jpg',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color(0xFF333333),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.broken_image, color: Color(0xFF8B0000)),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF8B0000), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/images/shadowy-dystopia-resident-evil-umbrella-corporation-xgvtapnnttode2sz.jpg',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color(0xFF333333),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image_not_supported, color: Color(0xFF8B0000)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _toggleTitle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B0000),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    child: const Text(
                      'Cambiar Título',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top 5 Juegos de Resident Evil',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Color(0xFFFF6B6B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _residentEvilGames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ResidentEvilGameCard(
                          game: _residentEvilGames[index],
                          position: index + 1,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ResidentEvilGameCard extends StatelessWidget {
  final ResidentEvilGame game;
  final int position;

  const ResidentEvilGameCard({
    required this.game,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF8B0000), width: 2),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              game.rutaImagen,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Color(0xFF333333),
                  child: const Icon(Icons.image, color: Color(0xFF8B0000)),
                );
              },
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
                stops: const [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),

          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (game.iconPath != null)
                  Image.asset(
                    game.iconPath!,
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        '#$position',
                        style: const TextStyle(
                          color: Color(0xFFFF6B6B),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      );
                    },
                  )
                else
                  Text(
                    '#$position',
                    style: const TextStyle(
                      color: Color(0xFFFF6B6B),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text(
                    game.nombreComercial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lanzamiento: ${game.anioLanzamiento}',
                  style: const TextStyle(
                    color: Color(0xFFBBBBBB),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}