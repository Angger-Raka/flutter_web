import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/data/blocs/add_order/add_order_bloc_bloc.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/data/datasources/datasources.dart';
import 'package:flutter_web/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

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

  getIt.registerFactory(
    () => AddOrderBloc(
      getIt<OrderDatasources>(),
    ),
  );
  getIt.registerFactory(
    () => ListOrderBloc(
      getIt<OrderDatasources>(),
    ),
  );
  getIt.registerFactory(
    () => DeleteOrderBloc(
      getIt<OrderDatasources>(),
      getIt<ProcessDatasources>(),
      getIt<StepDatasources>(),
    ),
  );
  getIt.registerFactory(
    () => UpdateOrderBloc(
      getIt<OrderDatasources>(),
    ),
  );
  getIt.registerFactory(
    () => UpdateStepBloc(
      getIt<StepDatasources>(),
    ),
  );
}
