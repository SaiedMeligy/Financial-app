import 'package:dio/dio.dart';
import '../../../entities/pointerModel.dart';
import '../../../repository/pointer/AllPointers/all_pointers_repository.dart';

class AllPointersUseCase{

  final AllPointersRepository allPointersRepository;

  AllPointersUseCase( this.allPointersRepository);

  Future<Response> execute(PointerModel pointerModel){
    return allPointersRepository.getAllPointers(pointerModel);
  }
}