import 'package:flutter/material.dart';

import '../manager/cubit.dart';

class BackupDataPage extends StatefulWidget {
  const BackupDataPage({super.key});

  @override
  State<BackupDataPage> createState() => _BackupDataPageState();
}

class _BackupDataPageState extends State<BackupDataPage> {
  late BackupCubit cubitBackup;
  @override
  void initState() {
    super.initState();
    cubitBackup = BackupCubit();
    // cubitBackup.getBackupData();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/back.jpg"),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            cubitBackup.getBackupData();
          },
              child:
            const Text('Backup Data')
          )
        ],
      ),
    );
  }
}
