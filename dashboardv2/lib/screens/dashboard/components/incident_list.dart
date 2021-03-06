import 'package:admin/models/Incidents.dart';
import 'package:admin/repo/repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:admin/models/Reports.dart';

import '../../../constants.dart';

class IncidentsScreen extends StatefulWidget {
  Incidents rep;

  IncidentsScreen({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<IncidentsScreen> createState() => _IncidentsScreenState();
}

class _IncidentsScreenState extends State<IncidentsScreen> {
  late int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

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
                "Type d'Incidents ",
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
                  r.fetchIncidents(context);
                },
              ),
            ],
          ),
          /*SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("ID"),
                ),
                DataColumn(
                  label: Text("Date de creation"),
                ),
                DataColumn(
                  label: Text("Description"),
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
              rows: List.generate(
                rep.data.reports.length,
                (index) => ReportDataRow(rep.data.reports[index]),
              ),
            ),
          ),*/
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  cardColor: secondaryColor, dividerColor: Colors.transparent),
              child: PaginatedDataTable(
                  showCheckboxColumn: false,
                  onPageChanged: (value) async {
                    setState(() {
                      if (value != null) {
                        /// Update rowsPerPage if the remaining count is less than the default rowsPerPage
                        if (widget.rep.rowCount - value < _rowsPerPage)
                          _rowsPerPage = widget.rep.rowCount - value;

                        /// else, restore default rowsPerPage value
                        else
                          _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
                      } else
                        _rowsPerPage = 0;
                    });
                  },
                  rowsPerPage: _rowsPerPage,
                  arrowHeadColor: Colors.white,
                  showFirstLastButtons: true,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Icon "),
                    ),
                    DataColumn(
                      label: Text("Titre "),
                    ),
                    DataColumn(
                      label: Text("Autorit??"),
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
      DataCell(Text(fileInfo.id.toString())),
      DataCell(Text(fileInfo.createdAt.toIso8601String().split("T").first!)),
      DataCell(Text(fileInfo.description)),
      DataCell(Text(fileInfo.location!.commune!.name)),
      DataCell(Text(fileInfo.location!.daira!.name!)),
      DataCell(Text(fileInfo.location!.wilaya!.name!)),
      DataCell(Text(fileInfo.incidentTypes.first.title)),
      DataCell(Text("nothing")),
    ],
  );
}
