import 'package:f_gps_tracker/ui/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'pages/permission/permission_page.dart';

class GpsApp extends StatelessWidget {
  const GpsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPS Tracker',
      theme: MyTheme.theme,
      home: const PermissionPage(),
    );
  }
}
