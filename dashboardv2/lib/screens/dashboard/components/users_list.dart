import 'package:admin/models/Announces.dart';
import 'package:admin/models/User.dart';
import 'package:admin/repo/repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:admin/models/Reports.dart';

import '../../../constants.dart';

class UsersScreen extends StatefulWidget {
  Users rep;

  UsersScreen({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
                "Utlisateur",
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
                  r.fetchUsers(context);
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
                  onPageChanged: (value) async {},
                  rowsPerPage: _rowsPerPage,
                  arrowHeadColor: Colors.white,
                  showFirstLastButtons: true,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Nom"),
                    ),
                    DataColumn(
                      label: Text("Prenom "),
                    ),
                    DataColumn(
                      label: Text("autorité"),
                    ),
                    DataColumn(
                      label: Text("Email"),
                    ),
                    DataColumn(
                      label: Text("Nom d'utlisateur"),
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
