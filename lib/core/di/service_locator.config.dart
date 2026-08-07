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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.factory<_i361.Dio>(() => injectableModule.dio);
    gh.factory<_i59.FirebaseAuth>(() => injectableModule.firebaseAuth);
    gh.factory<_i974.FirebaseFirestore>(() => injectableModule.firestore);
    gh.factory<_i14.AccountCubit>(
      () => _i14.AccountCubit(gh<_i738.AccountRepositoryInterface>()),
    );
    gh.factory<_i483.AccountDataSourceInterface>(
      () => _i304.AccountRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i801.InjectableModule {}
