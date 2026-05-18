import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/universidad_service.dart';
import '../themes/app_theme.dart';
import '../widgets/universidad_card.dart';

class UniversidadListView extends StatelessWidget {
  const UniversidadListView({super.key});

  @override
  Widget build(BuildContext context) {
    final service = UniversidadService();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Universidades'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/nueva'),
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: AppTheme.scaffoldGradient,
        child: SafeArea(
          child: StreamBuilder(
            stream: service.streamUniversidades(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF22D3EE),
                  ),
                );
              }

              final universidades = snapshot.data ?? [];

              if (universidades.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay universidades registradas',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: universidades.length,
                itemBuilder: (context, index) {
                  final u = universidades[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: UniversidadCard(
                      universidad: u,
                      onEdit: () {
                        context.push('/editar/${u.id}');
                      },
                      onDelete: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: const Color(0xFF1E293B),
                            title: const Text(
                              'Eliminar',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              '¿Eliminar "${u.nombre}"?',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(color: Color(0xFFF87171)),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true && u.id != null) {
                          await service.deleteUniversidad(u.id!);
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
