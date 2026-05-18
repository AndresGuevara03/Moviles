import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/universidad.dart';
import '../services/universidad_service.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_text_field.dart';

class UniversidadFormView extends StatefulWidget {
  final String? universidadId;

  const UniversidadFormView({super.key, this.universidadId});

  @override
  State<UniversidadFormView> createState() => _UniversidadFormViewState();
}

class _UniversidadFormViewState extends State<UniversidadFormView> {
  final _formKey = GlobalKey<FormState>();
  final _service = UniversidadService();

  final _nitController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _paginaWebController = TextEditingController();

  bool _isLoading = false;
  bool get _isEditing => widget.universidadId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final universidad = await _service.getUniversidadById(widget.universidadId!);
      if (universidad != null && mounted) {
        setState(() {
          _nitController.text = universidad.nit;
          _nombreController.text = universidad.nombre;
          _direccionController.text = universidad.direccion;
          _telefonoController.text = universidad.telefono;
          _paginaWebController.text = universidad.paginaWeb;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error cargando datos: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo requerido';
    }
    return null;
  }

  String? _validateUrl(String? value) {
    final base = _validateRequired(value);
    if (base != null) return base;

    final uri = Uri.tryParse(value!.trim());
    if (uri == null || uri.host.isEmpty || (uri.scheme != 'http' && uri.scheme != 'https')) {
      return 'URL no válida (ej: https://ejemplo.com)';
    }
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final universidad = Universidad(
        nit: _nitController.text.trim(),
        nombre: _nombreController.text.trim(),
        direccion: _direccionController.text.trim(),
        telefono: _telefonoController.text.trim(),
        paginaWeb: _paginaWebController.text.trim(),
      );

      if (_isEditing && widget.universidadId != null) {
        await _service.updateUniversidad(widget.universidadId!, universidad);
      } else {
        await _service.addUniversidad(universidad);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? 'Universidad actualizada correctamente'
                  : 'Universidad creada correctamente',
            ),
            backgroundColor: const Color(0xFF22D3EE),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Universidad' : 'Nueva Universidad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: AppTheme.scaffoldGradient,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _nitController,
                            label: 'NIT',
                            hint: 'Ej: 890.123.456-7',
                            validator: _validateRequired,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _nombreController,
                            label: 'Nombre',
                            hint: 'Ej: UCEVA',
                            validator: _validateRequired,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _direccionController,
                            label: 'Dirección',
                            hint: 'Ej: Cra 27A #48-144, Tuluá - Valle',
                            validator: _validateRequired,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _telefonoController,
                            label: 'Teléfono',
                            hint: 'Ej: +57 602 2242202',
                            validator: _validateRequired,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _paginaWebController,
                            label: 'Página Web',
                            hint: 'Ej: https://www.uceva.edu.co',
                            keyboardType: TextInputType.url,
                            validator: _validateUrl,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _save,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF0F172A),
                                    ),
                                  )
                                : Text(_isEditing ? 'Actualizar' : 'Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
