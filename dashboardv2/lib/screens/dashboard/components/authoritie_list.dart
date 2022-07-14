import 'package:admin/models/Authorities.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:admin/models/Reports.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants.dart';

class AuthoritiesScreen extends StatefulWidget {
  Authorities rep;

  AuthoritiesScreen({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<AuthoritiesScreen> createState() => _AuthoritiesScreenState();
}

class _AuthoritiesScreenState extends State<AuthoritiesScreen> {
  late int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  late bool add_authorization;
  @override
  void initState() {
    // TODO: implement initState
    final box = GetStorage();

    String authoritie = box.read("authoritie");
    add_authorization = (int.parse(authoritie) < 100);
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
            children: [],
          ),
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  cardColor: secondaryColor, dividerColor: Colors.transparent),
              child: PaginatedDataTable(
                  header: Row(children: [
                    Text(
                      "Autorités",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ]),
                  actions: [
                    if (add_authorization)
                      TextButton(
                        child: const Icon(
                          // Icons.create,
                          Icons.add_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Repository r = Repository();
                          r.fetchAuthorities(context);
                        },
                      ),
                    IconButton(
                      splashColor: Colors.transparent,
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Repository r = Repository();
                        r.fetchAuthorities(context);
                      },
                    ),
                  ],
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
                      label: Text("Titre "),
                    ),
                    DataColumn(
                      label: Text("Nombre d'Agence "),
                    ),
                    DataColumn(
                      label: Text("Nombre d'annonces "),
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
