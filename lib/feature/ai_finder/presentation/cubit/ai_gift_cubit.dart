import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/feature/ai_finder/presentation/cubit/ai_gift_state.dart';
import '../../domain/entities/ai_gift_request_entity.dart';
import '../../domain/usecases/get_ai_gift_recommendations_usecase.dart';



@injectable
class AIGiftCubit extends Cubit<AIGiftState> {
  final GetAIGiftRecommendationsUseCase getAIGiftRecommendationsUseCase;

  AIGiftCubit(this.getAIGiftRecommendationsUseCase) : super(AIGiftInitial());

  Future<void> getRecommendations(AIGiftRequestEntity request) async {
    emit(AIGiftLoading());
    try {
      final gifts = await getAIGiftRecommendationsUseCase(request);
      emit(AIGiftSuccess(gifts));
    } catch (e) {
      emit(AIGiftError(e.toString()));
    }
  }
}