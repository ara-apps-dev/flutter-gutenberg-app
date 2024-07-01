import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/local/book_local_data_source.dart';
import '../../data/data_sources/remote/book_remote_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecase/book/get_book_usecase.dart';
import '../../presentation/blocs/book/book_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Registering Blocs
  sl.registerFactory(() => BookBloc(sl()));

  // Registering Use Cases
  sl.registerLazySingleton(() => GetBookUseCase(sl()));

  // Registering Repositories
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Registering Data Sources
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<BookLocalDataSource>(
    () => BookLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core - Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
