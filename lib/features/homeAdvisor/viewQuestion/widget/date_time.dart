import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/constants.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class DateTimeView extends StatefulWidget {
  final ValueChanged<DateTime> onChange;

  DateTimeView({super.key, required this.onChange});

  @override
  State<DateTimeView> createState() => _DateTimeViewState();
}

class _DateTimeViewState extends State<DateTimeView> {
  late QuestionViewCubit questionViewCubit;

  @override
  void initState() {
    super.initState();
    questionViewCubit = QuestionViewCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionViewCubit, QuestionViewStates>(
      bloc: questionViewCubit,
      builder: (context, state) {
        DateTime displayDate = questionViewCubit.selectedDate;
        if (state is QuestionViewDateSelected) {
          displayDate = state.selectedDate;
        }
        return Column(
          children: [
            Text("تاريخ الجلسة", style: Constants.theme.textTheme.bodyMedium),
            GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await questionViewCubit.selectTaskDate(context);
                if (selectedDate != null) {
                  widget.onChange(selectedDate); // Call the callback with the selected date
                }
              },
              child: Text(
                DateFormat.yMMMMd().format(displayDate),
                style: Constants.theme.textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
