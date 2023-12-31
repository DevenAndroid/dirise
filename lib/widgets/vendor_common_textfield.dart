import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_colour.dart';

class VendorCommonTextfield extends StatefulWidget {
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

  List<TextInputFormatter>? inputFormatters = [];

  VendorCommonTextfield({
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
  State<VendorCommonTextfield> createState() => _VendorCommonTextfieldState();
}

class _VendorCommonTextfieldState extends State<VendorCommonTextfield> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 63,
      child: TextFormField(
          style: const TextStyle(),
          autofocus: false,
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
            filled: true,
            fillColor: Color(0xffE2E2E2).withOpacity(.4),
            counterStyle: const TextStyle(
              color: Color(0xff463B57),
              fontSize: 25,
            ),
            counter: const Offstage(),
            errorMaxLines: 2,
            enabled: widget.enabled,
            //   fillColor: Colors.transparent,
            hintText: widget.hintText,
            errorText: widget.errorText,
            labelText: widget.labelText,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            hintStyle: GoogleFonts.poppins(
              color: Color(0xff463B57),
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
                borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Color(0xffE2E2E2))),
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
          validator: widget.validator),
    );
  }
}
