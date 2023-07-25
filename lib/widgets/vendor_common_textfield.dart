import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_colour.dart';

class VendorCommonTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? obSecure;
  final bool? readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final int? maxLength;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;

  const VendorCommonTextfield({super.key,
    this.controller,
    this.validator,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    this.hintText,
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
    return TextFormField(
        style: const TextStyle(),
        autofocus: false,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingCompleted,
        obscureText: widget.obSecure ?? false,
        maxLength: widget.maxLength,
        minLines: (widget.isMulti ?? false) ? 3 : 1,
        maxLines: (widget.isMulti ?? false) ? 12 : 1,
        onTap: widget.onTap,
        enabled: widget.enabled,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffE2E2E2).withOpacity(.35),
          // counterStyle: const TextStyle(
          //   color: Color(0xff463B57),
          //   fontSize: 25,
          // ),
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
          // counter: const Offstage(),

          errorMaxLines: 2,
          enabled: widget.enabled ?? true,
          hintText: widget.hintText,
          errorText: widget.errorText,
          labelText: widget.hintText,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffixIcon,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xff463B57),
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
        validator: widget.validator);
  }
}
