import '../../domain/entities/PointerTypeEntities.dart';

class PointerTypeModel extends PointerTypeEntities{

  PointerTypeModel({required int id, required String name, required String desc})
      : super(id: id, name: name, desc: desc);

  PointerTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
}