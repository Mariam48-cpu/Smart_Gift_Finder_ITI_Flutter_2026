import 'package:smart_gift_finder/feature/account/data/datasource/account_data_source_interface.dart';
import 'package:smart_gift_finder/feature/account/data/models/account_dto.dart';
import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';
import 'package:smart_gift_finder/feature/account/domain/repository/account_repository_interface.dart';



class AccountRepositoryImpl 
implements AccountRepositoryInterface {


final AccountDataSourceInterface remoteDataSource;


AccountRepositoryImpl(
  this.remoteDataSource,
);



@override
Future<AccountEntity> getUserData(
 String uid,
) async {


final user = await remoteDataSource.getUserData(uid);


return user;

}




@override
Future<void> updateUserData(AccountEntity user) async {
  final model = AccountDto(
    uid: user.uid,
    name: user.name,
    email: user.email,
    phone: user.phone,
    birthday: user.birthday,
    imageUrl: user.imageUrl,
    address: user.address, 
  );

  await remoteDataSource.updateProfile(model);
}

}