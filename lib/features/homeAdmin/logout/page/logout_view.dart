import 'package:experts_app/core/config/page_route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../login/page/log_view.dart';
import '../manager/cubit.dart';

class LogoutView extends StatefulWidget {
  const LogoutView({super.key});

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  var logoutCubit = LogoutCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: logoutCubit,
      builder: (context, state) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                logoutCubit.logout().then((value) {
                  if (value) {
                    print("Logout successful: $value");
                    CacheHelper.clearAllData();
                    Navigator.pushNamedAndRemoveUntil(context, PageRouteName.login,(route) => false,);
                  } else {
                    print("Logout failed: $value");
                  }
                });
              } ,
              child: Text(
                "الخروج",
                style: Constants.theme.textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(50),
                color: Color.fromRGBO(234, 235, 239, 1)
              ),
              child: Icon(
                Icons.person ,
                color: Color.fromRGBO(50, 73, 113, 1),
                size: 35,
              )
            ),
          ],
        );
      }
    );
  }
}

