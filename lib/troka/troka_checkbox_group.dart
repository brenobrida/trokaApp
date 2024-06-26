import 'form_field_controller.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class trokaCheckboxGroup extends StatefulWidget {
  const trokaCheckboxGroup({
    Key? key,
    required this.options,
    required this.onChanged,
    required this.controller,
    required this.textStyle,
    this.labelPadding,
    this.itemPadding,
    required this.activeColor,
    required this.checkColor,
    this.checkboxBorderRadius,
    required this.checkboxBorderColor,
    this.initialized = true,
    this.unselectedTextStyle,
  }) : super(key: key);

  final List<String> options;
  final void Function(List<String>)? onChanged;
  final FormFieldController<List<String>> controller;
  final TextStyle textStyle;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? itemPadding;
  final Color activeColor;
  final Color checkColor;
  final BorderRadius? checkboxBorderRadius;
  final Color checkboxBorderColor;
  final bool initialized;
  final TextStyle? unselectedTextStyle;

  @override
  State<trokaCheckboxGroup> createState() => _trokaCheckboxGroupState();
}

class _trokaCheckboxGroupState extends State<trokaCheckboxGroup> {
  late List<String> checkboxValues;
  ValueListenable<List<String>?> get changeSelectedValues => widget.controller;
  List<String> get selectedValues => widget.controller.value ?? [];

  @override
  void initState() {
    super.initState();
    checkboxValues = List.from(widget.controller.initialValue ?? []);
    if (!widget.initialized && checkboxValues.isNotEmpty) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          if (widget.onChanged != null) {
            widget.onChanged!(checkboxValues);
          }
        },
      );
    }
    changeSelectedValues.addListener(() {
      if (!listEquals(checkboxValues, selectedValues)) {
        setState(() => checkboxValues = List.from(selectedValues));
      }
      if (widget.onChanged != null) {
        widget.onChanged!(selectedValues);
      }
    });
  }

  @override
  void dispose() {
    changeSelectedValues.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          final selected = selectedValues.contains(option);
          final unselectedTextStyle =
              widget.unselectedTextStyle ?? widget.textStyle;
          return Theme(
            data: ThemeData(unselectedWidgetColor: widget.checkboxBorderColor),
            child: Padding(
              padding: widget.itemPadding ?? EdgeInsets.zero,
              child: Row(
                children: [
                  Checkbox(
                    value: selected,
                    onChanged: widget.onChanged != null
                        ? (isSelected) {
                            if (isSelected == null) {
                              return;
                            }
                            isSelected
                                ? checkboxValues.add(option)
                                : checkboxValues.remove(option);
                            widget.controller.value = List.from(checkboxValues);
                            setState(() {});
                          }
                        : null,
                    activeColor: widget.activeColor,
                    checkColor: widget.checkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          widget.checkboxBorderRadius ?? BorderRadius.zero,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  Expanded(
                    child: Padding(
                      padding: widget.labelPadding ?? EdgeInsets.zero,
                      child: Text(
                        widget.options[index],
                        style:
                            selected ? widget.textStyle : unselectedTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
