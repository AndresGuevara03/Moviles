# Repositorio Talleres

**Estudiante:** Andres David Guevara Martinez  
**Código:** 230231022   
**Asignatura:** ELECTIVA PROFESIONAL I  

---

## Descripción general

Este repositorio contiene el código fuente de los talleres prácticos desarrollados para la asignatura, utilizando **Flutter** como framework de desarrollo de aplicaciones móviles.  

---

## Requisitos previos

- Flutter SDK instalado (versión estable recomendada: 3.x)
- Editor de código (VS Code, Android Studio, etc.)
- Emulador o dispositivo físico para pruebas

---

## 🎮 Taller 1: Resident Evil - Top 5 Juegos

### Descripción

Una aplicación Flutter que implementa un listado de los **Top 5 juegos de la saga Resident Evil** con una estética inspirada en el género horror. El proyecto demuestra conceptos fundamentales de Flutter como `setState()` para manejo de estado, creación de widgets personalizados, layouts complejos con `Stack`, aplicación de efectos visuales (`BackdropFilter`, gradientes), y carga de imágenes con manejo de errores. 

La interfaz utiliza un esquema de colores oscuro (#8B0000 - rojo sangre, #1a1a1a - negro profundo) para capturar la atmósfera aterradora de la franquicia, con cards temáticos que incluyen gradientes horizontales, efectos blur, e iconos de clasificación para las posiciones #1, #2 y #3.

### Características principales

- **AppBar interactivo**: Título que alterna entre "Hola, Flutter" y "¡Título cambiado!" con `setState()`
- **Cards temáticos**: Diseño personalizado con `Stack`, `ClipRRect`, `BackdropFilter` y gradientes lineales
- **Top 5 juegos**: Lista de 5 títulos de Resident Evil con año de lanzamiento e imágenes
- **Iconos de ranking**: Badges especiales para posiciones #1, #2 y #3
- **SnackBar mejorado**: Notificaciones flotantes, redondeadas y con alto contraste
- **Estética Resident Evil**: Colores oscuros, fuentes de alto contraste, gradientes transparentes
- **Carga flexible de imágenes**: Soporte para imágenes locales y de red con error builders

### Requisitos específicos

- Flutter 3.11.3+
- Dart 3.x
- Android SDK (para emulador/dispositivo Android) O Xcode (para iOS)
- Material Design 3 habilitado

### Descargar el proyecto

```bash
git clone https://github.com/AndresGuevara03/Moviles.git
cd Moviles/taller_1
```

### Iniciar la aplicación

**En emulador/dispositivo Android:**
```bash
flutter run
```

**En dispositivo iOS:**
```bash
flutter run -d iPhone
```

**En navegador web (experimental):**
```bash
flutter run -d web
```

**Limpiar y ejecutar desde cero:**
```bash
flutter clean
flutter pub get
flutter run
```

### Estructura del proyecto

```
taller_1/
├── lib/
│   └── main.dart                    # Archivo principal con toda la lógica
├── assets/
│   └── images/                      # Imágenes de juegos y ranking
├── pubspec.yaml                     # Configuración del proyecto
├── README.md                        # Documentación detallada
├── android/                         # Configuración Android
├── ios/                             # Configuración iOS
├── web/                             # Configuración Web
├── macos/                           # Configuración macOS
├── linux/                           # Configuración Linux
└── windows/                         # Configuración Windows
```

Consulta la documentación detallada en [README.md](taller_1/README.md) para ver capturas de pantalla de la aplicación en funcionamiento.
