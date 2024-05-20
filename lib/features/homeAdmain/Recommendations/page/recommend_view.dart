
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/add_feature.dart';
import '../../../../core/widget/custom_text_field.dart';

class AddRecommend extends StatefulWidget {
  const AddRecommend({super.key});

  @override
  State<AddRecommend> createState() => _AddRecommendState();
}

class _AddRecommendState extends State<AddRecommend> {

  @override
  Widget build(BuildContext context) {
    return  AddFeature(title: "اضافة توصية", hintText: "ادخل عنوان التوصية", textValidate: "من فضلك أدخل التوصية", alertText: "تم اضافة التوصية");
  }
}
