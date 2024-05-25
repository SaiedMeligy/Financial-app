import 'package:dio/dio.dart';

import '../../../repository/advices/addAdvice/add_advice_repository.dart';
import '../../../repository/pointer/addPointer/add_pointer_repository.dart';


class AddPointerUseCase{
  final AddPointerRepository pointerRepository;
  AddPointerUseCase(this.pointerRepository);
  Future<Response> execute(int senarioId,String title)async{
    return await pointerRepository.addPointer(senarioId,title);
  }
}