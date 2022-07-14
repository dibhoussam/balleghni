import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:webviewx/webviewx.dart';

import 'package:admin/models/Authorities.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/models/Reports.dart';
import 'package:admin/repo/repository.dart';

import '../../../constants.dart';

class StatScreen extends StatefulWidget {
  Authorities rep;
  StatScreen({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  late WebViewXController webviewController;
  final box = GetStorage();
  late String page;

  @override
  void initState() {
    String authoritie = box.read("authoritie");
    page = widget.rep.data
            .firstWhere((element) => element.id == int.parse(authoritie))
            .slug ??
        "";
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Statistique ",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: WebViewX(
                initialSourceType: SourceType.url,
                initialContent:
                    "http://41.111.148.170:9085/superset/dashboard/$page/",
                width: 1500,
                height: 1500,
                key: const ValueKey('webviewx'),
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                onPageStarted: (src) =>
                    debugPrint('A new page has started loading: $src\n'),
                onPageFinished: (src) =>
                    debugPrint('The page has finished loading: $src\n'),
                webSpecificParams: const WebSpecificParams(
                  printDebugInfo: true,
                ),
                mobileSpecificParams: const MobileSpecificParams(
                  androidEnableHybridComposition: true,
                ),
                navigationDelegate: (navigation) {
                  debugPrint(navigation.content.sourceType.toString());
                  return NavigationDecision.navigate;
                },
              ))
          /*WebViewX(
            initialSourceType: SourceType.url,
            initialContent:
                "http://41.111.148.170:9085/superset/dashboard/alger/",
            width: 1000,
            height: 1000,
            key: const ValueKey('webviewx'),
            onWebViewCreated: (controller) => webviewController = controller,
            onPageStarted: (src) =>
                debugPrint('A new page has started loading: $src\n'),
            onPageFinished: (src) =>
                debugPrint('The page has finished loading: $src\n'),
            webSpecificParams: const WebSpecificParams(
              printDebugInfo: true,
            ),
            mobileSpecificParams: const MobileSpecificParams(
              androidEnableHybridComposition: true,
            ),
            navigationDelegate: (navigation) {
              debugPrint(navigation.content.sourceType.toString());
              return NavigationDecision.navigate;
            },
          ),*/
        ],
      ),
    );
  }
}

DataRow ReportDataRow(Report fileInfo) {
  return DataRow(
    cells: [
      /*DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),*/
      DataCell(Text(fileInfo.id.toString())),
      DataCell(Text(fileInfo.createdAt.toIso8601String().split("T").first)),
      DataCell(Text(fileInfo.description)),
      DataCell(Text(fileInfo.location!.commune!.name)),
      DataCell(Text(fileInfo.location!.daira!.name!)),
      DataCell(Text(fileInfo.location!.wilaya!.name!)),
      DataCell(Text(fileInfo.incidentTypes.first.title)),
      DataCell(Text("nothing")),
    ],
  );
}
