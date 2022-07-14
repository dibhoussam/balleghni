import 'package:balighni/provider/incidents_provider.dart';
import 'package:balighni/screens/reporting_screen/widgets/textField.dart';
import 'package:balighni/widgets/multiSelect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class Page1 extends StatelessWidget {
  final Function(dynamic) callbackIncTypes;
  final Function(dynamic) callbackDescription;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(0, 0),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Consumer<IncidentsProvider>(
            builder: (_, IncidentsProvider incidentsprovider, __) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(0, 0),
                      blurRadius: 3,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: SelectFormField(
                  dialogCancelBtn: "رجوع",
                  dialogTitle: "   لائحة المشاكل ",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  type: SelectFormFieldType.dialog,
                  labelText: 'اختر ',
                  onChanged: callbackIncTypes,
                  onSaved: callbackIncTypes,
                  items: incidentsprovider.incidents.incident
                      .map((e) => e.toJson())
                      .toList(),
                ), /* MultiSelectWidget(
                  incidents: incidentsprovider.incidents,
                  inc: callbackIncTypes,
                ),*/
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                ),
              ],
            ),
            padding: EdgeInsets.all(15),
            child: TProgress(
              hintText: "وصف الإشكالية",
              prefix: Icon(Icons.person),
              callback: callbackDescription,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Page1(this.callbackIncTypes, this.callbackDescription);
}
