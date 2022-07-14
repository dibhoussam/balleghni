import 'package:balighni/models/Incidents.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectWidget extends StatefulWidget {
  final Incidents incidents;
  final Function(List<int>) inc;

  const MultiSelectWidget(
      {Key? key, required this.incidents, required this.inc})
      : super(key: key);
  State createState() => _MultiSelectWidget();
}

class _MultiSelectWidget extends State<MultiSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Colors.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(15)),
      child: MultiSelectDialogField(
        unselectedColor: Color(0x88ecf1f2),
        backgroundColor: Colors.white,
        searchable: true,
        initialValue: [],
        title: const Text(
          "نوع المشكل",
        ),
        //  buttonText: Text("نوع المشكل"),
        items: widget.incidents.incident
            .map((e) => MultiSelectItem(e.id, e.title))
            .toList(),
        listType: MultiSelectListType.CHIP,
        onConfirm: (values) {
          widget.inc(values.cast<int>());
        },
      ),

      /* MultiSelect(
            titleTextColor: Colors.green,
            selectedOptionsBoxColor: Colors.green,
            titleText: "نوع المشكل",
            validator: (value) {
              if (value == null) {
                return 'الرجاء تحديد خيار (خيارات) واحد أو أكثر';
              }
            },
            errorText: 'الرجاء تحديد خيار (خيارات) واحد أو أكثر',
            dataSource: widget.incidents.toJson()["incident"],
            autovalidateMode: AutovalidateMode.always,
            maxLength: 3,
            textField: 'title',
            valueField: 'id',
            filterable: false,
            required: true,
            value: null,
            cancelButtonColor: Colors.red,
            saveButtonColor: Colors.green,
            onSaved: (value) {
              widget.inc(value.cast<int>());
            })*/
    );
  }
}
