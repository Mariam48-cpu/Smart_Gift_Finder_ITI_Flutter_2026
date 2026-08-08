// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_gift_finder/core/di/injectable_module.dart' as _i801;
import 'package:smart_gift_finder/feature/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i1053;
import 'package:smart_gift_finder/feature/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i386;
import 'package:smart_gift_finder/feature/onboarding/domain/repositories/onboarding_repository.dart'
    as _i999;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.factory<_i361.Dio>(() => injectableModule.dio);
    gh.factory<_i1053.OnboardingLocalDataSource>(
      () => _i1053.OnboardingLocalDataSource(),
    );
    gh.factory<_i999.OnboardingRepository>(
      () => _i386.OnboardingRepositoryImpl(
        gh<_i1053.OnboardingLocalDataSource>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i801.InjectableModule {}
