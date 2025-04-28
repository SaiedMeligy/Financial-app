import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/domain/entities/AdvisorProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/config/page_route_name.dart';
import '../../../homeAdmin/logout/manager/cubit.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class ProfileAdvisorScreen extends StatefulWidget {
  const ProfileAdvisorScreen({super.key});

  @override
  State<ProfileAdvisorScreen> createState() => _ProfileAdvisorScreenState();
}

class _ProfileAdvisorScreenState extends State<ProfileAdvisorScreen> {
  late ProfileAdvisorCubit _profileCubit;
  int id = CacheHelper.getData(key: 'id');
  bool _isEditing = false;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  var logoutCubit = LogoutCubit();


  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileAdvisorCubit();
    _profileCubit.getProfileAdvisor(id);
    nameController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();

  }
  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: BlocBuilder<ProfileAdvisorCubit,ProfileAdvisorStates>(
          buildWhen: (previous, current) => current is SuccessProfileAdvisorState || current is SuccessUpdateProfileState,
          bloc: _profileCubit,
          builder: (context, state) {
            if (state is LoadingProfileAdvisorState) {
              return Center(child: CircularProgressIndicator());
            }

            else if (state is ErrorProfileAdvisorState) {
              return const Center(child: Text('Error loading profile'));
            }
            else if (state is SuccessProfileAdvisorState) {
              final userData = state.response.data['user'] ?? {};

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Constants.theme.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                           SizedBox(height: 20.h),
                          Text(
                            userData['name'] ?? '',
                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black
                            ),
                          ),
                           SizedBox(height: 5.h),
                           Text(
                            'استشاري',
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black87,
                            )
                          ),
                           SizedBox(height: 20.h),
                           const Divider(),
                           SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.verified,
                                color: userData['email_verified_at'] != null
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                userData['email_verified_at'] != null
                                    ? 'Verified Advisor'
                                    : 'Not Verified',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: userData['email_verified_at'] != null
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                     SizedBox(height: 30.h),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Constants.theme.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'المعلومات الشخصية',
                            style: Constants.theme.textTheme.titleLarge?.copyWith(
                              color: Colors.black
                            )
                          ),
                           SizedBox(height: 15.h),
                          _buildInfoRow(Icons.email, userData['email'] ?? ''),
                          const Divider(),
                          _buildInfoRow(Icons.phone, userData['phone_number'] ?? ''),
                          const Divider(),
                          _buildInfoRow(Icons.calendar_today,
                              userData['created_at'] != null
                                  ? _formatDate(userData['created_at'])
                                  : ''),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Constants.theme.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildActionButton(
                            icon: Icons.edit,
                            text: 'تعديل المعلومات الشخصية',
                            onTap: () {
                              _isEditing = ! _isEditing;
                              setState(() {

                              });

                            },
                          ),
                           SizedBox(height: 10.h,),
                          _isEditing?Column(
                            children: [
                              CustomTextField(
                                controller: nameController..text = userData['name'] ?? '',
                                hint: 'اسم الأستشاري',
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                controller: phoneController..text = userData['phone_number'] ?? '',
                                hint: 'رقم الهاتف',
                              ),
                              SizedBox(height: 10.h),

                              CustomTextField(
                                controller: passwordController..text = userData['password'] ?? '',
                                isPassword: true,
                                maxLines: 1,
                                hint: 'كلمة السر',
                                hintColor: Colors.black,

                              ),
                              SizedBox(height: 5.w,),
                              BlocBuilder<ProfileAdvisorCubit,ProfileAdvisorStates>(
                                bloc: _profileCubit,
                                  builder: (context, state) {
                                      return BorderRoundedButton(
                                        onPressed: () {
                                          final profile = AdvisorModel(
                                            id: id,
                                            name: nameController.text,
                                            phoneNumber: phoneController.text,
                                            password: passwordController.text

                                          );
                                          _profileCubit.updateProfile(advisor: profile).then((_) {

                                          _profileCubit.getProfileAdvisor(id);
                                          setState(() {
                                            _isEditing = !_isEditing;
                                          });
                                          } );

                                        },
                                        title: "تعديل", color: Colors.red,);

                                  }
                              ),

                              SizedBox(height: 20.h,),

                            ],
                          ):const SizedBox(),
                          const Divider(),
                          _buildActionButton(
                            icon: Icons.logout,
                            text: 'تسجيل الخروج',
                            onTap: () {
                              logoutCubit.logout().then((value) {
                                if (value) {
                                  CacheHelper.clearAllData();
                                  Navigator.pushNamedAndRemoveUntil(context, PageRouteName.login,(route) => false,);

                                } else {
                                  print("Logout failed: $value");
                                }
                              });
                            },
                            isLogout: true,
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 30.h),
                  ],
                ),
              );
            }
            else{
              return const Text('Some thing went wrong',);
            }
          }

        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon,  String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : Colors.blue,
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: Constants.theme.textTheme.titleLarge?.copyWith(
                color: Colors.black
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}