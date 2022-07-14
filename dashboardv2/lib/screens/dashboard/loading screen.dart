import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/announces_list.dart';
import 'package:admin/screens/dashboard/components/authoritie_list.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/reports_list.dart';
import 'components/storage_details.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget present =
      Consumer<AnnouncesProvider>(builder: (_, AnnouncesProvider provider, __) {
    return AnnouncesScreen(rep: provider.announces);
  });

  @override
  void initState() {
    // TODO: implement initState
    Repository r = Repository();
    r.fetchAnnounces(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Center(child: SpinKitSpinningLines(color: Colors.white))
        ],
      ),
    );
  }
}
