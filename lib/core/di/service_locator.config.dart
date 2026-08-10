// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_gift_finder/core/di/injectable_module.dart' as _i801;
import 'package:smart_gift_finder/feature/account/data/datasource/account_data_source_imp.dart'
    as _i304;
import 'package:smart_gift_finder/feature/account/data/datasource/account_data_source_interface.dart'
    as _i483;
import 'package:smart_gift_finder/feature/account/domain/repository/account_repository_interface.dart'
    as _i738;
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart'
    as _i14;
import 'package:smart_gift_finder/feature/ai_finder/data/datasources/ai_gift_data_source.dart'
    as _i226;
import 'package:smart_gift_finder/feature/ai_finder/data/repositories/ai_gift_repository_impl.dart'
    as _i680;
import 'package:smart_gift_finder/feature/ai_finder/domain/repositories/ai_gift_repository.dart'
    as _i545;
import 'package:smart_gift_finder/feature/ai_finder/domain/usecases/get_ai_gift_recommendations_usecase.dart'
    as _i499;
import 'package:smart_gift_finder/feature/cart/data/datasource/cart_remote_datasource.dart'
    as _i758;
import 'package:smart_gift_finder/feature/cart/data/repository/cart_repository_impl.dart'
    as _i657;
import 'package:smart_gift_finder/feature/cart/domain/repository/cart_repository.dart'
    as _i746;
import 'package:smart_gift_finder/feature/cart/domain/usecases/add_to_cart.dart'
    as _i110;
import 'package:smart_gift_finder/feature/cart/domain/usecases/get_cart.dart'
    as _i559;
import 'package:smart_gift_finder/feature/cart/domain/usecases/remove_from_cart.dart'
    as _i403;
import 'package:smart_gift_finder/feature/cart/domain/usecases/update_cart_quantity.dart'
    as _i816;
import 'package:smart_gift_finder/feature/cart/presentation/cubit/cart_cubit.dart'
    as _i977;
import 'package:smart_gift_finder/feature/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i1053;
import 'package:smart_gift_finder/feature/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i386;
import 'package:smart_gift_finder/feature/onboarding/domain/repositories/onboarding_repository.dart'
    as _i999;
import 'package:smart_gift_finder/feature/reset_password/data/repo/reset_data_source_imp.dart'
    as _i956;
import 'package:smart_gift_finder/feature/reset_password/data/repo/reset_repo_imp.dart'
    as _i1022;
import 'package:smart_gift_finder/feature/reset_password/domain/repo/reset_data_source_interface.dart'
    as _i301;
import 'package:smart_gift_finder/feature/reset_password/domain/repo/reset_repo_interface.dart'
    as _i408;
import 'package:smart_gift_finder/feature/reset_password/domain/usecase/reset_password_use_case.dart'
    as _i439;
import 'package:smart_gift_finder/feature/reset_password/peresentation/view_model/reset_cubit.dart'
    as _i879;
import 'package:smart_gift_finder/feature/wishlist/data/datasources/wishlist_remote_data_source.dart'
    as _i635;
import 'package:smart_gift_finder/feature/wishlist/data/repositories/wishlist_repository_impl.dart'
    as _i896;
import 'package:smart_gift_finder/feature/wishlist/domain/repositories/wishlist_repository.dart'
    as _i193;
import 'package:smart_gift_finder/feature/wishlist/presentation/cubit/wishlist_cubit.dart'
    as _i1024;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i1053.OnboardingLocalDataSource>(
        () => _i1053.OnboardingLocalDataSource());
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dio);
    gh.lazySingleton<_i59.FirebaseAuth>(() => injectableModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => injectableModule.firestore);
    gh.factory<_i14.AccountCubit>(
        () => _i14.AccountCubit(gh<_i738.AccountRepositoryInterface>()));
    gh.factory<_i999.OnboardingRepository>(() =>
        _i386.OnboardingRepositoryImpl(gh<_i1053.OnboardingLocalDataSource>()));
    gh.factory<_i758.CartRemoteDataSource>(() => _i758.CartRemoteDataSource(
          firestore: gh<_i974.FirebaseFirestore>(),
          auth: gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i545.AIGiftRepository>(() =>
        _i680.AIGiftRepositoryImpl(dataSource: gh<_i226.AIGiftDataSource>()));
    gh.factory<_i499.GetAIGiftRecommendationsUseCase>(() =>
        _i499.GetAIGiftRecommendationsUseCase(
            repository: gh<_i545.AIGiftRepository>()));
    gh.factory<_i746.CartRepository>(
        () => _i657.CartRepositoryImpl(gh<_i758.CartRemoteDataSource>()));
    gh.factory<_i110.AddToCart>(
        () => _i110.AddToCart(gh<_i746.CartRepository>()));
    gh.factory<_i559.GetCart>(() => _i559.GetCart(gh<_i746.CartRepository>()));
    gh.factory<_i403.RemoveFromCart>(
        () => _i403.RemoveFromCart(gh<_i746.CartRepository>()));
    gh.factory<_i816.UpdateCartQuantity>(
        () => _i816.UpdateCartQuantity(gh<_i746.CartRepository>()));
    gh.lazySingleton<_i635.WishlistRemoteDataSource>(() =>
        _i635.WishlistRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i483.AccountDataSourceInterface>(
        () => _i304.AccountRemoteDataSourceImpl(
              gh<_i974.FirebaseFirestore>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.factory<_i301.ResetDataSourceInterface>(
        () => _i956.ResetDataSourceImp(gh<_i59.FirebaseAuth>()));
    gh.factory<_i408.ResetRepoInterface>(
        () => _i1022.ResetRepoImp(gh<_i301.ResetDataSourceInterface>()));
    gh.factory<_i439.ResetPasswordUseCase>(
        () => _i439.ResetPasswordUseCase(gh<_i408.ResetRepoInterface>()));
    gh.factory<_i879.ResetCubit>(
        () => _i879.ResetCubit(gh<_i439.ResetPasswordUseCase>()));
    gh.factory<_i977.CartCubit>(() => _i977.CartCubit(
          getCart: gh<_i559.GetCart>(),
          addToCart: gh<_i110.AddToCart>(),
          updateCartQuantity: gh<_i816.UpdateCartQuantity>(),
          removeFromCart: gh<_i403.RemoveFromCart>(),
        ));
    gh.lazySingleton<_i193.WishlistRepository>(() =>
        _i896.WishlistRepositoryImpl(gh<_i635.WishlistRemoteDataSource>()));
    gh.factory<_i1024.WishlistCubit>(
        () => _i1024.WishlistCubit(gh<_i193.WishlistRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i801.InjectableModule {}
