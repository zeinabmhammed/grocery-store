import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:greengrocer/features/main_layout/home/data/datasources/home_remote_datasource.dart';
import 'package:greengrocer/features/main_layout/home/data/datasources/products_remote_datasource.dart';
import 'package:greengrocer/features/main_layout/home/data/datasources/vendors_remote_datasource.dart';
import 'package:greengrocer/features/main_layout/home/data/repositories/home_repository_impl.dart';
import 'package:greengrocer/features/main_layout/home/data/repositories/products_repository_impl.dart';
import 'package:greengrocer/features/main_layout/home/data/repositories/vendors_repository_impl.dart';
import 'package:greengrocer/features/main_layout/home/domain/repositories/home_repository.dart';
import 'package:greengrocer/features/main_layout/home/domain/repositories/products_repository.dart';
import 'package:greengrocer/features/main_layout/home/domain/repositories/vendors_repository.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_categories_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_category_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_sliders_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_vendor_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_vendors_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/search_products_usecase.dart';
import 'package:greengrocer/features/main_layout/orders/data/datasources/orders_remote_datasource.dart';
import 'package:greengrocer/features/main_layout/orders/data/repositories/orders_repository_impl.dart';
import 'package:greengrocer/features/main_layout/orders/domain/repositories/orders_repository.dart';
import 'package:greengrocer/features/main_layout/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:greengrocer/features/main_layout/orders/domain/usecases/get_orders_usecase.dart';
import '../network/dio_client.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ===== Core =====
  final dioClient = DioClient();
  dioClient.init();
  sl.registerLazySingleton<Dio>(() => dioClient.dio);
  sl.registerLazySingleton<DioClient>(() => dioClient);

  // ===== Auth =====
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => AddToFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => ContactUsUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoryProductsUseCase(sl()));


  // ===== Home =====
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetSlidersUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));

  // ===== Vendors =====
  sl.registerLazySingleton<VendorsRemoteDataSource>(
    () => VendorsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<VendorsRepository>(
    () => VendorsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetVendorsUseCase(sl()));

  // ===== Products =====
  sl.registerLazySingleton<ProductsRemoteDataSource>(
        () => ProductsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetVendorProductsUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));

 // ===== Orders =====
  sl.registerLazySingleton<OrdersRemoteDataSource>(
  () => OrdersRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(
  () => OrdersRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton(() => CancelOrderUseCase(sl()));
}
