import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/routes.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  await setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TestBloc(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<AddOrderBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ListOrderBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<DeleteOrderBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<UpdateOrderBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<UpdateStepBloc>(),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
    );
  }
}
