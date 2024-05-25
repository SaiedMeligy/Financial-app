import 'package:dio/dio.dart';

import '../../../repository/pointer/deletePointer/delete_pointer_repository.dart';


class DeletePointerUseCase{
  final DeletePointerRepository deletePointerRepository;
  DeletePointerUseCase(this.deletePointerRepository);

  Future<Response> execute(int id)async{

    return await deletePointerRepository.deletePointer(id);
  }
}