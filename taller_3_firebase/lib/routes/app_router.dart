import 'package:go_router/go_router.dart';
import '../views/universidad_list_view.dart';
import '../views/universidad_form_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const UniversidadListView(),
    ),
    GoRoute(
      path: '/nueva',
      builder: (context, state) => const UniversidadFormView(),
    ),
    GoRoute(
      path: '/editar/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UniversidadFormView(universidadId: id);
      },
    ),
  ],
);
