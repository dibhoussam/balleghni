import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/provider/UsersProvider.dart';
import 'package:admin/provider/incidents_provider.dart';
import 'package:admin/screens/dashboard/components/announces_list.dart';
import 'package:admin/screens/dashboard/components/authoritie_details.dart';
import 'package:admin/screens/dashboard/components/authoritie_list.dart';
import 'package:admin/screens/dashboard/components/incident_list.dart';
import 'package:admin/screens/dashboard/components/reports_list.dart';
import 'package:admin/screens/dashboard/components/stats.dart';
import 'package:admin/screens/dashboard/components/users_list.dart';
import 'package:admin/screens/dashboard/dashboard_Incident_screen.dart';
import 'package:admin/screens/dashboard/dashboard_annonces_screen.dart';
import 'package:admin/screens/dashboard/dashboard_autortie_screen.dart';
import 'package:admin/screens/dashboard/dashboard_reports_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/dashboard_stats_screen.dart';
import 'package:admin/screens/dashboard/dashboard_users_screen.dart';
import 'package:admin/screens/dashboard/details_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  Function(Widget) change;
  SideMenu({
    Key? key,
    required this.change,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget Rep_Dash = Consumer<ReportsProvider>(
      builder: (_, ReportsProvider reportsprovider, __) {
    return ReportsScreen(rep: reportsprovider.reports);
  });

  Widget Autor_Dash = Consumer<AuthoritiesProvider>(
      builder: (_, AuthoritiesProvider provider, __) {
    return AuthoritiesScreen(rep: provider.authorities);
  });

  Widget Incident_Dash =
      Consumer<IncidentsProvider>(builder: (_, IncidentsProvider provider, __) {
    return IncidentsScreen(rep: provider.incidents);
  });

  Widget Announces_Dash =
      Consumer<AnnouncesProvider>(builder: (_, AnnouncesProvider provider, __) {
    return AnnouncesScreen(rep: provider.announces);
  });

  Widget Users_Dash =
      Consumer<UsersProvider>(builder: (_, UsersProvider provider, __) {
    return UsersScreen(rep: provider.users);
  });

  Widget main_Dash = Consumer<AuthoritiesProvider>(
      builder: (_, AuthoritiesProvider reportsprovider, __) {
    final box = GetStorage();
    String authoritie = box.read("authoritie");
    return AuthoritieDetails(
        rep: reportsprovider.authorities.data
            .firstWhere((element) => element.id == int.parse(authoritie)));
  });

  Widget stat_Dash = Consumer<AuthoritiesProvider>(
      builder: (_, AuthoritiesProvider provider, __) {
    return StatScreen(rep: provider.authorities);
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  width: 97,
                  height: 97,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Ballighni",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              widget.change(main_Dash);
            },
          ),
          DrawerListTile(
            title: "Statistique",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              widget.change(stat_Dash);
            },
          ),
          DrawerListTile(
            title: "Rapports",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              widget.change(Rep_Dash);
            },
          ),
          DrawerListTile(
            title: "Authorities",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              widget.change(Autor_Dash);
            },
          ),
          DrawerListTile(
            title: "Communiqués",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              widget.change(Announces_Dash);
            },
          ),
          DrawerListTile(
            title: "Incident et problemes",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              widget.change(Incident_Dash);
            },
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              widget.change(Users_Dash);
            },
          ),

          /*
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),*/
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
