import 'package:flutter/material.dart';
import 'package:hw1mobile/screens/colors.dart';
//الاسم:رامي شيخ
class TextForm extends StatelessWidget {
  const TextForm({
    super.key,
    required this.plceHolder,
    this.isPassword = false,
    this.icon,
    this.validator,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  final String plceHolder;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final TextInputType keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: plceHolder,
          prefixIcon: icon != null
              ? Icon(icon, color: AppColors.greyDark)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

class DropdownForm extends StatefulWidget {
  const DropdownForm({
    super.key,
    required this.plceHolder,
    required this.options,
    this.icon,
    this.onSaved,
    this.validator,
  });

  final String plceHolder;
  final List<String> options;
  final IconData? icon;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  State<DropdownForm> createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: widget.plceHolder,
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(widget.icon, color: AppColors.greyDark),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        value: selectedValue,
        isExpanded: true,
        items: widget.options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        validator: widget.validator,
        onSaved: (value) {
           if (value != null) {
              widget.onSaved?.call(value);
           }
        },
      ),
    );
  }
}