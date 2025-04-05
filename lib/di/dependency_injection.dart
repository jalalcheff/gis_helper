
import 'package:get_it/get_it.dart';
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/repository/feeders_repository_imp.dart';
import 'package:gis_helper/data/service/api_service_imp.dart';
import 'package:gis_helper/domain/add_transformer_usecase.dart';
import 'package:gis_helper/domain/get_all_feeders_usecase.dart';
import 'package:gis_helper/domain/get_all_transformers_locally.dart';
import 'package:gis_helper/domain/get_all_transformers_number_usecase.dart';
import 'package:gis_helper/domain/get_latest_changes_usecase.dart';
import 'package:gis_helper/presentation/cubit/add_transformer_cubit/add_transformer_cubit.dart';
import 'package:gis_helper/presentation/cubit/all_transfomers_cubit/all_transformers_cubit.dart';
import 'package:gis_helper/presentation/cubit/latest_changes_cubit/latest_changes_cubit.dart';

import '../data/database_service/database_service_imp.dart';
import '../data/repository/api_srevice.dart';
import '../data/repository/transformer_repository_imp.dart';
import '../domain/feeders_repository.dart';
import '../domain/get_feeders_number_usecase.dart';
import '../domain/transformer_repository.dart';

final GetIt locator = GetIt.instance;
Future<void> setUpLocator() async{
  locator.registerSingleton<DatabaseServiceImp>(DatabaseServiceImp());
  locator.registerSingleton<ApiServiceImp>(ApiServiceImp());
  locator.registerSingleton<TransformerRepositoryImp>(TransformerRepositoryImp(apiService: locator<ApiServiceImp>(), databaseService: locator<DatabaseServiceImp>()));
  locator.registerSingleton(FeedersRepositoryImp(localDatabaseTransformers: locator<DatabaseServiceImp>()));
  locator.registerSingleton<AddTransformerUsecase>(AddTransformerUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(GetAllFeedersUsecase(feedersRepository: locator<FeedersRepositoryImp>()));
  locator.registerSingleton(GetAllTransformersLocallyUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(GetAllTransformersNumberUsecase(databaseService: locator<DatabaseServiceImp>()));
  locator.registerSingleton(GetFeedersNumberUsecase(feedersRepository: locator<FeedersRepositoryImp>()));
  locator.registerSingleton(GetLatestChangesUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(AllTransformersCubit(locator<GetAllTransformersLocallyUsecase>()));
  locator.registerSingleton<AddTransformerCubit>(AddTransformerCubit(locator<AddTransformerUsecase>()));
  locator.registerSingleton(LatestChangesCubit(locator<GetLatestChangesUsecase>()));
/*  locator.registerFactory(() => SearchForMealByIdRepository(foodApiService: locator<FoodApiService>()));
  locator.registerFactory(() => SearchMealByIdCubit(locator<SearchForMealByIdRepository>()));*/
}