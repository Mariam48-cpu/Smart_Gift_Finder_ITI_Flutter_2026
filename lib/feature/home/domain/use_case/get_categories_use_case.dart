import 'package:smart_gift_finder/feature/home/domain/repo/home_repo_interface.dart';

class GetCategoriesUseCase {
  final HomeRepoInterface repository;

  GetCategoriesUseCase(this.repository);

  Future<List<String>> call() async {
    return await repository.getCategories();
  }
}