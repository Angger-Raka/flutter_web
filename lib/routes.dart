import 'package:flutter_web/app/core/constants/named_routes.dart';
import 'package:flutter_web/app/presentation/pages/client_action_page.dart';
import 'package:flutter_web/app/presentation/pages/order_action_page.dart';
import 'package:flutter_web/app/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';

import 'app/data/models/models.dart';

class AppRoutes {
  const AppRoutes._();

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: NamedRoutes.initial,
        builder: (context, state) => const SelectionPage(),
      ),
      GoRoute(
        path: NamedRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: NamedRoutes.clientAdd,
        builder: (context, state) => const ClientActionPage(),
      ),
      GoRoute(
        path: NamedRoutes.clientEdit,
        builder: (context, state) {
          if (state.extra != null) {
            final client = state.extra as Client;
            return ClientActionPage(client: client);
          }
          return const ClientActionPage();
        },
      ),
      GoRoute(
        path: NamedRoutes.orderAdd,
        builder: (context, state) => const OrderActionPage(),
      ),
      GoRoute(
        path: NamedRoutes.orderEdit,
        builder: (context, state) {
          if (state.extra != null) {
            final order = state.extra as Order;
            return OrderActionPage(order: order);
          }
          return const OrderActionPage();
        },
      ),
      GoRoute(
        path: NamedRoutes.printerAdd,
        builder: (context, state) => const PrintActionScreen(),
      ),
      GoRoute(
        path: NamedRoutes.printerAdd,
        builder: (context, state) {
          if (state.extra != null) {
            final printer = state.extra as Printer;
            return PrintActionScreen(printer: printer);
          }
          return const PrintActionScreen();
        },
      ),
    ],
  );
}
