import 'package:admin/models/Announces.dart';
import 'package:admin/repo/repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:admin/models/Reports.dart';

import '../../../constants.dart';

class AnnouncesScreen extends StatefulWidget {
  Announces rep;

  AnnouncesScreen({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<AnnouncesScreen> createState() => _AnnouncesScreenState();
}

class _AnnouncesScreenState extends State<AnnouncesScreen> {
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
                "Communiquées ",
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
                  r.fetchAnnounces(context);
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
                      label: Text("Titre"),
                    ),
                    DataColumn(
                      label: Text("Autorité "),
                    ),
                    DataColumn(
                      label: Text("Date de creation"),
                    ),
                    DataColumn(
                      label: Text("Actions"),
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
