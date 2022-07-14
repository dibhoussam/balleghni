import 'package:advanced_datatable/advanced_datatable.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:admin/models/Reports.dart';
import 'package:admin/repo/repository.dart';

import '../../../constants.dart';

class ReportsScreen extends StatefulWidget {
  Reports rep;
  //void Function(dynamic) change;
  ReportsScreen({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
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
                "Rapports",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              IconButton(
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  Repository r = Repository();
                  r.fetchReports(context);
                },
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  cardColor: secondaryColor, dividerColor: Colors.transparent),
              child: PaginatedDataTable(
                  showCheckboxColumn: false,
                  onPageChanged: (value) async {},
                  showFirstLastButtons: true,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("ID"),
                    ),
                    DataColumn(
                      label: Text("Date de creation"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Commune"),
                    ),
                    DataColumn(
                      label: Text("Daira"),
                    ),
                    DataColumn(
                      label: Text("Wilaya"),
                    ),
                    DataColumn(
                      label: Text("Type de problemes "),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                  ],
                  source: widget.rep
                  /*List.generate(
                  rep.data.reports.length,
                  (index) => ReportDataRow(rep.data.reports[index]),
                ),*/
                  ),
            ),
          ),
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
      DataCell(Text(fileInfo.id!.toString())),
      DataCell(Text(fileInfo.createdAt.toIso8601String().split("T").first!)),
      DataCell(Text(fileInfo.description!)),
      DataCell(Text(fileInfo.location!.commune!.name!)),
      DataCell(Text(fileInfo.location!.daira!.name!)),
      DataCell(Text(fileInfo.location!.wilaya!.name!)),
      DataCell(Text(fileInfo.incidentTypes.first.title)),
      DataCell(Text("nothing")),
    ],
  );
}
