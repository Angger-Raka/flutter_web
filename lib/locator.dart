import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/data/blocs/list_client/list_client_bloc.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/data/datasources/client_datasources.dart';
import 'package:flutter_web/app/data/datasources/datasources.dart';
import 'package:flutter_web/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'app/data/blocs/bloc/get_process_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<Dio>(
    DioClient(
      dio: Dio(),
      baseUrl: baseUrl,
    ).client,
  );
  // getIt.registerSingleton<SubjectBloc>(SubjectBloc());

  getIt.registerSingleton(OrderDatasources(dio: getIt<Dio>()));
  getIt.registerSingleton(ProcessDatasources(dio: getIt<Dio>()));
  getIt.registerSingleton(StepDatasources(dio: getIt<Dio>()));
  getIt.registerSingleton(ClientDatasources(dio: getIt<Dio>()));
  getIt.registerSingleton(PrinterDatasources(dio: getIt<Dio>()));

  getIt.registerFactory(
    () => OrderBloc(
      orderDatasources: getIt<OrderDatasources>(),
      processDatasources: getIt<ProcessDatasources>(),
      stepDatasources: getIt<StepDatasources>(),
      clientDatasources: getIt<ClientDatasources>(),
    ),
  );
  getIt.registerFactory(
    () => StepBloc(
      datasources: getIt<StepDatasources>(),
    ),
  );
  getIt.registerFactory(
    () => ClientBloc(
      getIt<ClientDatasources>(),
    ),
  );

  //! Line 1

  getIt.registerFactory(
    () => ListOrderBloc(
      getIt<OrderDatasources>(),
    ),
  );

  getIt.registerFactory(
    () => ListClientBloc(
      getIt<ClientDatasources>(),
    ),
  );

  getIt.registerFactory(
    () => GetClientBloc(
      getIt<ClientDatasources>(),
    ),
  );

  getIt.registerFactory(
    () => ListPrinterBloc(
      getIt<PrinterDatasources>(),
    ),
  );

  getIt.registerFactory(
    () => PrinterBloc(
      getIt<PrinterDatasources>(),
    ),
  );

  getIt.registerFactory(
    () => GetProcessBloc(
      getIt<ProcessDatasources>(),
    ),
  );
}
