// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_gift_finder/core/di/injectable_module.dart' as _i801;
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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.factory<_i361.Dio>(() => injectableModule.dio);
    gh.lazySingleton<_i59.FirebaseAuth>(() => injectableModule.firebaseAuth);
    gh.factory<_i301.ResetDataSourceInterface>(
      () => _i956.ResetDataSourceImp(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i408.ResetRepoInterface>(
      () => _i1022.ResetRepoImp(gh<_i301.ResetDataSourceInterface>()),
    );
    gh.factory<_i439.ResetPasswordUseCase>(
      () => _i439.ResetPasswordUseCase(gh<_i408.ResetRepoInterface>()),
    );
    gh.factory<_i879.ResetCubit>(
      () => _i879.ResetCubit(gh<_i439.ResetPasswordUseCase>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i801.InjectableModule {}
