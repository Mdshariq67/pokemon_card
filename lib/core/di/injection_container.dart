import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/cards/data/datasources/card_remote_datasource.dart';
import '../../features/cards/data/repositories/card_repository_impl.dart';
import '../../features/cards/domain/repositories/card_repository.dart';
import '../../features/cards/domain/usecases/get_cards.dart';
import '../../features/cards/domain/usecases/search_cards.dart';
import '../../features/cards/presentation/bloc/card_list/card_list_bloc.dart';
import '../../features/cards/presentation/bloc/card_search/card_search_bloc.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<Dio>(DioClient.createDio);
  sl.registerLazySingleton<CardRemoteDatasource>(() => CardRemoteDatasourceImpl(sl()));
  sl.registerLazySingleton<CardRepository>(() => CardRepositoryImpl(sl()));
  sl.registerFactory<GetCards>(() => GetCards(sl()));
  sl.registerFactory<SearchCards>(() => SearchCards(sl()));
  sl.registerFactory<CardListBloc>(() => CardListBloc(sl()));
  sl.registerFactory<CardSearchBloc>(() => CardSearchBloc(sl()));
}
