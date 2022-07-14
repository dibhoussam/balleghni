import 'package:admin/provider/UsersProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/screens/dashboard/components/users_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/header.dart';

class UsersDashboardScreen extends StatefulWidget {
  @override
  State<UsersDashboardScreen> createState() => _UsersDashboardScreenState();
}

class _UsersDashboardScreenState extends State<UsersDashboardScreen> {
  Widget present =
      Consumer<UsersProvider>(builder: (_, UsersProvider provider, __) {
    return UsersScreen(rep: provider.users);
  });

  @override
  void initState() {
    // TODO: implement initState
    Repository r = Repository();
    r.fetchUsers(context);
    super.initState();
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
