import 'package:experts_app/domain/entities/side_bar_model.dart';
import 'package:experts_app/features/homeAdmin/Advices/page/All%20Advices/page/advice_view.dart';
import 'package:experts_app/features/homeAdmin/Advices/page/addAdvice/add_advice.dart';
import 'package:experts_app/features/homeAdmin/Backup_data/page/backup_data_page.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/page/consulting_view.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/Consultation%20Store/page/add_consulting.dart';
import 'package:experts_app/features/homeAdmin/addSession/page/add_session_view.dart';
import 'package:experts_app/features/homeAdmin/add_patient/page/add_patient_view.dart';
import 'package:experts_app/features/homeAdmin/adviceReport/page/advice_report_view.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/page/all_patient_admin_view.dart';
import 'package:experts_app/features/homeAdmin/allQuestionView/page/all_question_view.dart';
import 'package:experts_app/features/homeAdmin/bookingSession/page/booking_session_view.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/page/pointer_report_view.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/addPointer/add_indicator.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/all%20Pointers/page/edit_indicator.dart';
import 'package:experts_app/features/homeAdmin/question/pages/add_question.dart';
import 'package:experts_app/features/homeAdmin/registrationAdvisor/page/register_view.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/page/static_screen.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/page/all_patient_recycle_admin_view.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Constants {
  static var theme = Theme.of(navigatorKey.currentState!.context);
  static var mediaQuery = MediaQuery.of(navigatorKey.currentState!.context).size;
  static var baseUrl = "https://financialclinic.site/financial_clinic_apis/public" ;
  //  static var baseUrl = "http://127.0.0.1:8000";
  static var apiPassword = "FWe4ayY2gaGX8TSM";

  static List<SideBarModel> titles = [
      SideBarModel(title: "الصفحة الرئيسية", icon: const Icon(Icons.home,color: Colors.black87,)),
      SideBarModel(title: "اضافة حالة", icon: const Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "الحالات", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "المحذوفات", icon: const Icon(Icons.delete,color: Colors.black87)),
      SideBarModel(title: "تقارير المؤشرات", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "تقارير التوصيات", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة الأسئلة", icon: const Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "عرض الأسئلة", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة المؤشرات", icon: const Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "المؤشرات", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة التوصيات", icon: const Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: " التوصيات", icon: const Icon(Icons.list,color: Colors.black87)),
      // SideBarModel(title: "اضافة الحالات من مصدر خارجي", icon: const Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "حجز جلسات", icon: const Icon(Icons.border_color_outlined,color: Colors.black87)),
      SideBarModel(title: "الجلسات المحجوزة", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة خدمة استشارية", icon: const Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "الخدمات الاستشارية", icon: const Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة استشاري", icon: const Icon(Icons.add,color: Colors.black87)),
      // SideBarModel(title: "النسخ الأحتياطي للبيانات", icon: const Icon(Icons.save_alt_outlined,color: Colors.black87)),
    ];

  static  List<Widget> bodies = [
      const StaticScreen(),
      const AddPatientView(),
      const AllPatientAdminView(),
      const AllPatientRecycleAdminView(),
      const PointerReportView(),
      const AdviceReportView(),
      const AddQuestion(),
      AllQuestionView(),
      const AddIndicator(),
      const EditIndicator(),
      const AddRecommend(),
      const EditAdviceView(),
      // const // Center(child: Text("اضافة الحالات من مصدر خارجي",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      AddSessionView(),
      const BookingSessionView(),
      const AddConsulting(),
      const ConsultingView(),
      const RegisterView(),
      // const BackupDataPage(),
    ];
   static int page = 1;
   static int totalPages = 20;
}