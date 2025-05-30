
import 'package:get_it/get_it.dart';
import 'package:gis_helper/data/repository/account_repository_imp.dart';
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/repository/feeders_repository_imp.dart';
import 'package:gis_helper/data/service/api_service_imp.dart';
import 'package:gis_helper/domain/account_repository.dart';
import 'package:gis_helper/domain/add_transformer_usecase.dart';
import 'package:gis_helper/domain/get_all_feeders_usecase.dart';
import 'package:gis_helper/domain/get_all_transformers_locally.dart';
import 'package:gis_helper/domain/get_all_transformers_number_usecase.dart';
import 'package:gis_helper/domain/get_latest_changes_usecase.dart';
import 'package:gis_helper/domain/get_transformer_details_usecase.dart';
import 'package:gis_helper/presentation/cubit/add_transformer_cubit/add_transformer_cubit.dart';
import 'package:gis_helper/presentation/cubit/all_transfomers_cubit/all_transformers_cubit.dart';
import 'package:gis_helper/presentation/cubit/latest_changes_cubit/latest_changes_cubit.dart';

import '../data/database_service/database_service_imp.dart';
import '../data/repository/api_srevice.dart';
import '../data/repository/transformer_repository_imp.dart';
import '../domain/feeders_repository.dart';
import '../domain/get_Number_of_transformers_of_each_sector.dart';
import '../domain/get_feeders_number_usecase.dart';
import '../domain/get_logindata_usecase.dart';
import '../domain/search_for_transformers.dart';
import '../domain/sign_in_usecase.dart';
import '../domain/signout_usecase.dart';
import '../domain/transformer_repository.dart';
import '../presentation/cubit/feeders_number_cubit/feeders_number_cubit.dart';
import '../presentation/cubit/search_for_transformer_cubit/search_for_transformer_cubit.dart';
import '../presentation/cubit/sign_in_cubit/sign_in_cubit.dart';
import '../presentation/cubit/signout_cubit/signout_cubit.dart';
import '../presentation/cubit/transformer_details_cubit/transformer_details_cubit.dart';
import '../presentation/cubit/transformer_number_cubit/transformer_number_cubit.dart';
import '../presentation/cubit/transformer_number_of_each_sector_cubit/transformer_number_of_each_sector_cubit.dart';
import '../presentation/cubit/user_accountdata_cubit/user_accountdata_cubit.dart';

final GetIt locator = GetIt.instance;
Future<void> setUpLocator() async{
  locator.registerSingleton<DatabaseServiceImp>(DatabaseServiceImp());
  locator.registerSingleton<ApiServiceImp>(ApiServiceImp());
  locator.registerSingleton<TransformerRepositoryImp>(TransformerRepositoryImp(apiService: locator<ApiServiceImp>(), databaseService: locator<DatabaseServiceImp>()));
  locator.registerSingleton(FeedersRepositoryImp(localDatabaseTransformers: locator<DatabaseServiceImp>(), apiService: locator<ApiServiceImp>()));
  locator.registerSingleton<AddTransformerUsecase>(AddTransformerUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(GetAllFeedersUsecase(feedersRepository: locator<FeedersRepositoryImp>()));
  locator.registerSingleton(GetAllTransformersLocallyUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(GetAllTransformersNumberUsecase(databaseService: locator<DatabaseServiceImp>(), transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(GetFeedersNumberUsecase(feedersRepository: locator<FeedersRepositoryImp>()));
  locator.registerSingleton(GetLatestChangesUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerFactory(() => SearchForTransformersUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(AllTransformersCubit(locator<GetAllTransformersLocallyUsecase>()));
  locator.registerSingleton<AddTransformerCubit>(AddTransformerCubit(locator<AddTransformerUsecase>()));
  locator.registerSingleton(LatestChangesCubit(locator<GetLatestChangesUsecase>()));
  locator.registerSingleton(FeedersNumberCubit(locator<GetFeedersNumberUsecase>()));
  locator.registerSingleton(TransformerNumberCubit(locator<GetAllTransformersNumberUsecase>()));
  locator.registerSingleton(GetNumberOfTransformersOfEachSector(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(TransformerNumberOfEachSectorCubit(locator<GetNumberOfTransformersOfEachSector>()));
  locator.registerFactory(() => SearchForTransformerCubit(locator<SearchForTransformersUsecase>()));
  locator.registerFactory(() => GetTransformerDetailsUsecase(transformerRepository: locator<TransformerRepositoryImp>()));
  locator.registerSingleton(TransformerDetailsCubit(locator<GetTransformerDetailsUsecase>()));
  locator.registerSingleton(AccountRepositoryImp(apiService: locator<ApiServiceImp>()));
  locator.registerSingleton(SignInUsecase(accountRepository: locator<AccountRepositoryImp>()));
  locator.registerFactory(() => SignInCubit(locator<SignInUsecase>()));
  locator.registerSingleton(GetLogindataUsecase(accountRepository: locator<AccountRepositoryImp>()));
  locator.registerFactory(() => UserAccountdataCubit(locator<GetLogindataUsecase>()));
  locator.registerSingleton(SignoutUsecase(accountRepository: locator<AccountRepositoryImp>()));
  locator.registerSingleton(SignoutCubit(locator<SignoutUsecase>()));

/*  locator.registerFactory(() => SearchForMealByIdRepository(foodApiService: locator<FoodApiService>()));
  locator.registerFactory(() => SearchMealByIdCubit(locator<SearchForMealByIdRepository>()));*/
}