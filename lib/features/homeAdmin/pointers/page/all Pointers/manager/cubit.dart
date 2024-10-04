import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/pointerModel.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/all%20Pointers/manager/states.dart';

import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';

class AllPointersCubit extends Cubit<AllPointersStates> {
  AllPointersCubit() : super(LoadingAllPointers());

  Future<void> getAllPointers() async {
    final dio = Dio();
    emit(LoadingAllPointers());
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/pointer',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["pointers"];
        List<Pointers> pointers = data.map((json) => Pointers.fromJson(json)).toList();

        List<Pointers> pointers1Temp = [];
        List<Pointers> pointers2Temp = [];
        List<Pointers> pointers3Temp = [];

        for (var pointer in pointers) {
          if (pointer.senarioId == 1) {
            pointers1Temp.add(pointer);
          } else if (pointer.senarioId == 2) {
            pointers2Temp.add(pointer);
          } else if (pointer.senarioId == 3) {
            pointers3Temp.add(pointer);
          }
        }

        emit(SuccessAllPointers(pointers1Temp, pointers2Temp, pointers3Temp));
      } else {
        emit(ErrorAllPointers('Failed to load pointers. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ErrorAllPointers('Error occurred: $e'));
    }
  }
}
