import 'package:dio/dio.dart';

import '../../../repository/pointer/updatePointer/update_pointer_repository.dart';


class UpdatePointerUseCase{
  final UpdatePointerRepository updatePointerRepository;
  UpdatePointerUseCase(this.updatePointerRepository);

  Future<Response> execute(int id,String title)async{

    return await updatePointerRepository.updatePointer(id,title);
  }
}