import 'package:bloc/bloc.dart';
import 'package:chat_bot_project/features/screens/personal_reception/logic/data/repositories/personal_reception_repository.dart';
import 'package:dio/dio.dart';

part 'list_recept_event.dart';
part 'list_recept_state.dart';

class ListReceptBloc extends Bloc<ListReceptEvent, ListReceptState> {
  final PersonalReceptionRepository personalReceptionRepository;
  ListReceptBloc(this.personalReceptionRepository)
      : super(ListReceptInitial()) {
    on<ListReceptGetData>(
      (event, emit) async {
        emit(ListReceptLoading());
        try {
          final Response response =
              await personalReceptionRepository.personalReceptGetData();

          emit(ListReceptSuccess(response));
        } on DioError catch (e) {
          emit(ListReceptFailure(e.message ?? ""));
        }
      },
    );
  }
}
