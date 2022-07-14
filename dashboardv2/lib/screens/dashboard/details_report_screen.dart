import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/authoritie_details.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/reports_details.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/reports_list.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<DashboardScreen> {
  final box = GetStorage();
  late Widget present;

  @override
  void initState() {
    present = Consumer<AuthoritiesProvider>(
        builder: (_, AuthoritiesProvider reportsprovider, __) {
      String authoritie = box.read("authoritie");
      return AuthoritieDetails(
          rep: reportsprovider.authorities.data
              .firstWhere((element) => element.id == int.parse(authoritie)));
    }); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //test
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // MyFiles(),
                      SizedBox(height: defaultPadding),
                      present

                      //RecentFiles(),
                      /*  if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),*/
                    ],
                  ),
                ),
                /*if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
