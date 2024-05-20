import 'failure.dart';

class ServerFailure extends Failure{
  String? message;
  ServerFailure({required super.statusCode, this.message});
  factory ServerFailure.fromJson(Map<String, dynamic> json){
    return ServerFailure(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}

