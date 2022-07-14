import 'package:admin/models/Authorities.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/authoritie_list.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/authoritie_details.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/reports_list.dart';
import 'components/storage_details.dart';

class DashboardAuthoritiesScreen extends StatefulWidget {
  @override
  State<DashboardAuthoritiesScreen> createState() =>
      _DashboardAuthoritiesScreenState();
  late Function(Authoritie r) change;
}

class _DashboardAuthoritiesScreenState
    extends State<DashboardAuthoritiesScreen> {
  Widget present = Consumer<AuthoritiesProvider>(
      builder: (_, AuthoritiesProvider provider, __) {
    return AuthoritiesScreen(rep: provider.authorities);
  });
  void update(Authoritie r) {
    return setState(() {
      present = AuthoritieDetails(rep: r);
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    widget.change = update;
  }

  @override
  Widget build(BuildContext context) {
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
