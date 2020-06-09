import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:numbertrivia/core/network/network_info.dart';
import 'package:numbertrivia/core/util/convert_utils.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:numbertrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/presentation/provider/trivia_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> initializeDependencyInjection() async {
  // Provider
  getIt.registerLazySingleton(() => TriviaProvider(
      getNumberTrivia: getIt(),
      getRandomNumberTrivia: getIt(),
      converterUtils: getIt()));

  //Use cases
  getIt.registerLazySingleton(() => GetNumberTrivia(getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTrivia(getIt()));

  // Repository
  getIt.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
      remoteDataSource: getIt(), localDataSource: getIt(), networkInfo: getIt()));

  // Data sources
  getIt.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: getIt()));
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(client: getIt()));

  // Core
  getIt.registerLazySingleton(() => ConverterUtils());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: getIt()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => DataConnectionChecker());
}
