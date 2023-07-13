import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_colour.dart';

class CommonTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  final List<TextInputFormatter>? inputFormatters;

  const CommonTextfield({super.key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(),
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingCompleted,
        obscureText: widget.obSecure,
        minLines: widget.isMulti ? 4 : 1,
        maxLines: widget.isMulti ? null : 1,
        onTap: widget.onTap,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          counterStyle: const TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 25,
          ),
          counter: const Offstage(),
          contentPadding: const EdgeInsets.all(14),
          errorMaxLines: 2,
          enabled: widget.enabled,
          //   fillColor: Colors.transparent,
          hintText: widget.hintText,
          errorText: widget.errorText,
          labelText: widget.labelText,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffixIcon,
          hintStyle: GoogleFonts.poppins(
            color: AppTheme.primaryColor,
            fontSize: 15,
          ),
          /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            // ),*/

          border: InputBorder.none,
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppTheme.secondaryColor)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppTheme.secondaryColor)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppTheme.secondaryColor)),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppTheme.secondaryColor),
          ),

          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppTheme.secondaryColor),
          ),
        ),
        validator: widget.validator);
  }
}
