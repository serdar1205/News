import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/data/datasources/db/app_database.dart';
import 'package:news_app/features/data/datasources/remote/comments_remote_datasource.dart';
import 'package:news_app/features/data/datasources/remote/news_remote_datasource.dart';
import 'package:news_app/features/domain/reposotories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/api_provider.dart';
import 'core/network/api_provider_impl.dart';
import 'core/network/internet_bloc/internet_bloc.dart';
import 'core/network/network.dart';
import 'core/utils/local/token_store.dart';
import 'core/utils/uuid_provider.dart';
import 'features/data/datasources/local/last_read_time_data.dart';
import 'features/data/datasources/remote/auth_remote_datasource.dart';
import 'features/data/reposotories/auth_repository_impl.dart';
import 'features/data/reposotories/comment_repository_impl.dart';
import 'features/data/reposotories/news_repository_impl.dart';
import 'features/domain/reposotories/comments_repository.dart';
import 'features/domain/reposotories/news_repository.dart';
import 'features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/presentation/blocs/comments_bloc/comments_bloc.dart';
import 'features/presentation/blocs/comments_count_bloc/comments_count_bloc.dart';
import 'features/presentation/blocs/news_bloc/news_bloc.dart';
import 'features/presentation/blocs/read_news_bloc/read_news_bloc.dart';

final locator = GetIt.instance;
String documentsDir = '';

Future<void> initLocator() async {
  final secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  locator.registerLazySingletonAsync<FlutterSecureStorage>(
      () async => secureStorage);

  final database =
      await $FloorAppDataBase.databaseBuilder('app_database.db').build();

  locator.registerSingleton<AppDataBase>(database);

  locator.registerLazySingleton<TokenStore>(
    () => TokenStore(locator()),
  );

  final sharedPrefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  locator.registerLazySingleton<LastReadTimeDataPref>(
    () => LastReadTimeDataPref(locator()),
  );
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(() {
    final instance = FirebaseFirestore.instance;
    instance.settings = const Settings(persistenceEnabled: true);
    return instance;
  });

  locator.registerFactory<ApiProvider>(() => ApiProviderImpl());
  locator.registerSingleton<InternetBloc>(InternetBloc());
  locator.registerLazySingleton<UuidProvider>(() => UuidProvider());

  ///Data source

  locator.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDatasourceImpl(firebaseAuth: locator(), firestore: locator()));

  locator.registerLazySingleton<NewsRemoteDatasource>(
      () => NewsRemoteDatasourceImpl(apiProvider: locator()));

  locator.registerLazySingleton<CommentsRemoteDatasource>(() =>
      CommentsRemoteDataSourceImpl(
          firebaseAuth: locator(), firestore: locator()));

  ///repo
  locator.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: locator(), remoteDataSource: locator()));

  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
        networkInfo: locator(),
        remoteDataSource: locator(),
        localDataSource: locator(),
      ));
  locator
      .registerLazySingleton<CommentsRepository>(() => CommentsRepositoryImpl(
            locator(),
            locator(),
            locator(),
          ));

  ///bloc
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());

  locator.registerLazySingleton<NewsBloc>(() => NewsBloc());
  locator.registerLazySingleton<CommentsBloc>(() => CommentsBloc());
  locator.registerLazySingleton<ReadNewsBloc>(() => ReadNewsBloc());
  locator.registerLazySingleton<CommentsCountBloc>(() => CommentsCountBloc());
}
