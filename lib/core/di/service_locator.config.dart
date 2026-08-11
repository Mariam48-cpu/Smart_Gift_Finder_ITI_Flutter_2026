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
import 'package:smart_gift_finder/feature/search/data/repo/search_datasource_imp.dart'
    as _i683;
import 'package:smart_gift_finder/feature/search/data/repo/search_repo_imp.dart'
    as _i916;
import 'package:smart_gift_finder/feature/search/domain/repo/search_data_source_interface.dart'
    as _i22;
import 'package:smart_gift_finder/feature/search/domain/repo/search_repo_interface.dart'
    as _i563;
import 'package:smart_gift_finder/feature/search/domain/use_case/search_use_case.dart'
    as _i825;
import 'package:smart_gift_finder/feature/search/peresentation/view_model/search_cubit.dart'
    as _i912;