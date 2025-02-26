import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/data/blocs/bloc/get_process_bloc.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/routes.dart';
import 'package:get_it/get_it.dart';

import 'app/data/blocs/list_client/list_client_bloc.dart';

Future<void> main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<OrderBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ListOrderBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<StepBloc>(),
        ),
        BlocProvider(
          create: (context) => SelectionBloc(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ListClientBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ClientBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<GetClientBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ListPrinterBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<PrinterBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<GetProcessBloc>(),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
    );
  }
}
