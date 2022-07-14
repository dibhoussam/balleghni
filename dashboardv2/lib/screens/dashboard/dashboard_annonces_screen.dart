import 'package:admin/models/Announces.dart';
import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/announces_list.dart';
import 'package:admin/screens/dashboard/components/authoritie_list.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/reports_list.dart';
import 'components/storage_details.dart';

class AnnoncesDashboardScreen extends StatefulWidget {
  @override
  State<AnnoncesDashboardScreen> createState() =>
      _AnnoncesDashboardScreenState();

  late Function(Announce r) show;
}

class _AnnoncesDashboardScreenState extends State<AnnoncesDashboardScreen> {
  Widget present =
      Consumer<AnnouncesProvider>(builder: (_, AnnouncesProvider provider, __) {
    return AnnouncesScreen(rep: provider.announces);
  });
  showAlert(
    Announce r,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Detail du communiquée "),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(r.createdAt.toIso8601String().split("T").first),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      //ImageIcon(NetworkImage(data.authoritie[index].logo)),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                          r.authoritie!.logo,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(r.authoritie!.name),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(r.title),
                  SizedBox(height: 10),
                  Text(r.description),
                ],
              ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    Repository r = Repository();
    r.fetchAnnounces(context);
    super.initState();
    widget.show = showAlert;
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
