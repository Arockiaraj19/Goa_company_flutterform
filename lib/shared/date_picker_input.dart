import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DatePickerInput extends StatefulWidget {
  DatePickerInput(
      {Key key,
      this.controller,
      this.hintText,
      this.validators,
      this.onSelect,
      this.lastDate})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final Function(String) validators;
  final DateTime lastDate;
  final Function(DateTime) onSelect;

  @override
  _DatePickerInputState createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {
  DateTime selectedDate;
  TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(alignment: Alignment.topRight, children: [
        InputField(
          onTap: showCalendarPicker,
          validators: widget.validators,
          controller: _controller,
          readOnly: true,
          hintText: widget.hintText,
          padding: EdgeInsets.zero,
        ),
      ]),
    );
  }

  Future<void> showCalendarPicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2200),
      builder: (context, child) {
        return Theme(
          data: ThemeData.from(
              colorScheme: ColorScheme.light(
                  primary: MainTheme
                      .primaryColor)), // This will change to light theme.
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    _controller.value =
        TextEditingValue(text: DateFormat.yMMMd().format(selectedDate));
    widget.onSelect(selectedDate);
  }
}
