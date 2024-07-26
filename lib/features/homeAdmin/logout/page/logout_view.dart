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
          return GestureDetector(
            onTap: () {
              logoutCubit.logout().then((value) {
                if (value) {
                  print("Logout successful: $value");
                  CacheHelper.clearAllData();
                  Navigator.pushNamedAndRemoveUntil(context, PageRouteName.login,(route) => false,);
                  // Navigator.pushAndRemoveUntil(
                  //     context, MaterialPageRoute(builder: (context) => LogView()),
                  //     (route) => false,
                  // );
                } else {
                  print("Logout failed: $value");
                }
              });
            },
            child: Row(
              children: [
                Text(
                  "الخروج",
                  style: Constants.theme.textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () {
                    logoutCubit.logout().then((value) {
                      if (value) {
                        print("Logout successful: $value");
                        CacheHelper.clearAllData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LogView())
                        );
                      } else {
                        print("Logout failed: $value");
                      }
                    });
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}

