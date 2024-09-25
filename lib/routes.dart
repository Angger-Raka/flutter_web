import 'package:flutter_web/app/core/constants/named_routes.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  const AppRoutes._();

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: NamedRoutes.initial,
        builder: (context, state) => const WrapperScreen(),
      ),
      GoRoute(
        path: NamedRoutes.maintenance,
        builder: (context, state) => const MaintenenceScreen(),
      ),
      GoRoute(
        path: NamedRoutes.order,
        builder: (context, state) => const OrderListScreen(),
      ),
      GoRoute(
        path: NamedRoutes.orderDetail,
        builder: (context, state) => OrderProgresDetail(),
      ),
      GoRoute(
        path: NamedRoutes.orderCreate,
        builder: (context, state) => const OrderAddScreen(),
      ),
      GoRoute(
        path: NamedRoutes.orderEdit,
        builder: (context, state) {
          final order = state.extra as Order;
          return OrderEditScreen(
            order: order,
          );
        },
      ),
    ],
  );
}
