import 'package:flutter_gutenberg_app/src/data/adapter/book_detail_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/adapter/book_response_model_adapter.dart';
import '../../data/data_sources/local/book_local_data_source.dart';
import '../../data/data_sources/remote/book_remote_data_source.dart';
import '../../data/models/book/book_response_model.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/entities/book_detail/book_detail.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecase/book/get_book_usecase.dart';
import '../../domain/usecase/book/get_book_detail_usecase.dart';
import '../../presentation/blocs/book/book_bloc.dart';
import '../../presentation/blocs/book_detail/book_detail_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Registering Hive
  await Hive.initFlutter();
  sl.registerSingleton<HiveInterface>(Hive);

  // Register Hive adapters if needed
  Hive.registerAdapter(BookResponseModelAdapter());
  Hive.registerAdapter(BookDetailAdapter());

  // Open Hive boxes
  await Hive.openBox<BookDetail>('cached_book_details');
  await Hive.openBox<BookResponseModel>('cached_books');

  // Registering Blocs
  sl.registerFactory(() => BookBloc(sl()));
  sl.registerFactory(() => BookDetailBloc(sl()));

  // Registering Use Cases
  sl.registerLazySingleton(() => GetBookUseCase(sl()));
  sl.registerLazySingleton(() => GetBookDetailUseCase(sl()));

  // Registering Repositories
  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Registering Data Sources
  sl.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BookLocalDataSource>(
      () => BookLocalDataSourceImpl(hive: sl()));

  // Core - Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External Dependencies
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
