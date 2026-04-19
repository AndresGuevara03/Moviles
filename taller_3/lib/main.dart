import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

void main() {
  runApp(const TallerSegundoPlanoApp());
}


class TallerSegundoPlanoApp extends StatelessWidget {
  const TallerSegundoPlanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller Segundo Plano',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    FutureDemoScreen(),
    TimerDemoScreen(),
    IsolateDemoScreen(),
  ];

  final List<String> _titles = const [
    'Future, async/await',
    'Cronómetro (Timer)',
    'Isolate (Tarea Pesada)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download),
            label: 'Future',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.memory),
            label: 'Isolate',
          ),
        ],
      ),
    );
  }
}

// HomeScreen eliminado, navegación ahora es por BottomNavigationBar

class _HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue, size: 36),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
          onTap: onTap,
        ),
      ),
    );
  }
}

// 1. Future, async/await Demo
class FutureDemoScreen extends StatefulWidget {
  const FutureDemoScreen({super.key});

  @override
  State<FutureDemoScreen> createState() => _FutureDemoScreenState();
}

class _FutureDemoScreenState extends State<FutureDemoScreen> {
  String _state = 'idle'; // idle, loading, success, error
  String? _data;
  String? _error;

  Future<String> _fakeFetch() async {
    debugPrint('Antes de la consulta (Future)');
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Durante la consulta (Future)');
    // Simular éxito o error
    if (DateTime.now().second % 2 == 0) {
      return '¡Datos cargados correctamente desde el servidor de ejemplo!';
    } else {
      throw Exception('Error al cargar los datos desde el servidor de ejemplo');
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _state = 'loading';
      _data = null;
      _error = null;
    });
    try {
      final result = await _fakeFetch();
      setState(() {
        _state = 'success';
        _data = result;
      });
      debugPrint('Después de la consulta (Future)');
    } catch (e) {
      setState(() {
        _state = 'error';
        _error = e.toString();
      });
      debugPrint('Después de la consulta (Future) con error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future, async/await')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth < 500 ? constraints.maxWidth : 400;
          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_download, color: Colors.blue, size: 60),
                  const SizedBox(height: 24),
                  if (_state == 'idle') ...[
                    const Text('Presiona el botón para cargar datos desde el servidor de ejemplo.', textAlign: TextAlign.center),
                  ] else if (_state == 'loading') ...[
                    const CircularProgressIndicator(color: Colors.blue),
                    const SizedBox(height: 16),
                    const Text('Cargando datos desde el servidor de ejemplo...', textAlign: TextAlign.center),
                  ] else if (_state == 'success') ...[
                    Icon(Icons.check_circle, color: Colors.blue.shade700, size: 40),
                    const SizedBox(height: 12),
                    Text(_data ?? '', style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ] else if (_state == 'error') ...[
                    Icon(Icons.error, color: Colors.red.shade400, size: 40),
                    const SizedBox(height: 12),
                    Text(_error ?? '', style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                  ],
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _state == 'loading' ? null : _loadData,
                    child: const Text('Cargar datos'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 2. Timer Demo (Cronómetro)
class TimerDemoScreen extends StatefulWidget {
  const TimerDemoScreen({super.key});

  @override
  State<TimerDemoScreen> createState() => _TimerDemoScreenState();
}

class _TimerDemoScreenState extends State<TimerDemoScreen> {
  Timer? _timer;
  int _elapsedMs = 0;
  bool _isRunning = false;

  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _elapsedMs += 100;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resume() {
    if (_isRunning) return;
    _start();
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _elapsedMs = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int ms) {
    final seconds = (ms ~/ 1000) % 60;
    final minutes = (ms ~/ 60000) % 60;
    final centiseconds = (ms ~/ 100) % 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centiseconds}';
  }

  @override
  Widget build(BuildContext context) {
    final bool canResume = !_isRunning && _elapsedMs > 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Cronómetro (Timer)')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth < 500 ? constraints.maxWidth : 400;
          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, color: Colors.blue, size: 60),
                  const SizedBox(height: 24),
                  Text(
                    _formatTime(_elapsedMs),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: (_isRunning || canResume) ? null : _start,
                        child: const Text('Iniciar'),
                      ),
                      ElevatedButton(
                        onPressed: _isRunning ? _pause : null,
                        child: const Text('Pausar'),
                      ),
                      ElevatedButton(
                        onPressed: canResume ? _resume : null,
                        child: const Text('Reanudar'),
                      ),
                      ElevatedButton(
                        onPressed: _elapsedMs > 0 ? _reset : null,
                        child: const Text('Reiniciar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. Isolate Demo
class IsolateDemoScreen extends StatefulWidget {
  const IsolateDemoScreen({super.key});

  @override
  State<IsolateDemoScreen> createState() => _IsolateDemoScreenState();
}

class _IsolateDemoScreenState extends State<IsolateDemoScreen> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;
  bool _isLoading = false;
  int? _result;
  int _n = 100000000;
  String? _error;

  double _progress = 0.0;
  Future<void> _runHeavySum() async {
    setState(() {
      _isLoading = true;
      _result = null;
      _error = null;
      _progress = 0.0;
    });
    final stopwatch = Stopwatch()..start();
    try {
      debugPrint('Lanzando Isolate para suma pesada...');
      final result = await computeHeavySumWithProgress(_n, (progress) {
        if (mounted) {
          setState(() {
            _progress = progress;
          });
        }
      });
      debugPrint('Resultado recibido del Isolate.');
      if (mounted) {
        setState(() {
          _result = result;
          _isLoading = false;
          _progress = 1.0;
        });
      }
      debugPrint('Tiempo total: \u001b[34m${stopwatch.elapsedMilliseconds} ms\u001b[0m');
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate (Tarea Pesada)')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth < 500 ? constraints.maxWidth : 400;
          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.memory, color: Colors.blue, size: 60),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Sumar hasta N',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final val = int.tryParse(v);
                      if (val != null && val > 0) {
                        _n = val;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _runHeavySum,
                    child: const Text('Ejecutar suma pesada'),
                  ),
                  const SizedBox(height: 24),
                  if (_isLoading) ...[
                    LinearProgressIndicator(
                      value: _progress,
                      minHeight: 8,
                      backgroundColor: Colors.blue.shade100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    Text('Progreso: ${(_progress * 100).toStringAsFixed(1)}%', style: const TextStyle(color: Colors.blue)),
                    const SizedBox(height: 12),
                    const Text('Calculando en Isolate...'),
                  ] else if (_result != null) ...[
                    Text('Resultado: $_result', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ] else if (_error != null) ...[
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Función pesada para Isolate con barra de progreso
Future<int> computeHeavySumWithProgress(int n, void Function(double) onProgress) async {
  final p = ReceivePort();
  await Isolate.spawn(_heavySumEntryWithProgress, [p.sendPort, n, 100000]);
  int sum = 0;
  await for (final msg in p) {
    if (msg is int) {
      sum = msg;
      break;
    } else if (msg is double) {
      onProgress(msg);
    }
  }
  return sum;
}

void _heavySumEntryWithProgress(List<dynamic> args) {
  final SendPort sendPort = args[0];
  final int n = args[1];
  final int chunk = args.length > 2 ? args[2] : 100000;
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
    if (i % chunk == 0 || i == n) {
      sendPort.send(i / n);
    }
  }
  sendPort.send(sum);
}