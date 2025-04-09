import 'package:flutter/material.dart';

class KTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? prefixText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool isSubmitted;
  final bool? isEnabled;
  final bool upperCase;
  final Function(String)? onChange;
  final TextStyle? labelStyle;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final bool? isDense;
  final bool? autofocus;
  final bool? obscureText;

  const KTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.validator,
    this.isEnabled,
    required this.isSubmitted,
    this.upperCase = false,
    this.onChange,
    this.labelStyle,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.isDense,
    this.autofocus,
    this.obscureText,
  });

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool active = false;

  @override
  void initState() {
    active = widget.controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      obscureText: widget.obscureText ?? false,
      autofocus: widget.autofocus ?? false,
      autovalidateMode: widget.isSubmitted
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      textCapitalization: widget.textCapitalization,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      enabled: widget.isEnabled,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.prefixIcon != null
          ? (val) {
              if (widget.onChange != null) {
                widget.onChange!(val);
              }
              if (active && widget.controller.text.isEmpty) {
                setState(() {
                  active = false;
                });
              } else if (!active && widget.controller.text.isNotEmpty) {
                setState(() {
                  active = true;
                });
              }
            }
          : widget.onChange,
      validator: widget.validator ??
          (value) {
            if (value != null && value.isNotEmpty) {
              return null;
            }
            return 'required'; //AppLocalizations.of(context)!.requiredToFill;
          },
      decoration: InputDecoration(
        isDense: widget.isDense,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: active
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).cardColor,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Container(
                margin: const EdgeInsets.only(right: 13.0),
                height: 24, // Desired height
                width: 24, // Desired width
                child: widget.suffixIcon,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24, // Control height
          maxWidth: 44, // Control width
        ),
        prefixText: widget.prefixText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          // fontFamily: TextFonts.sfPro,
        ),
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        alignLabelWithHint: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        filled: true,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: Theme.of(context).primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorMaxLines: 2,
        prefixStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          //fontFamily: TextFonts.sfPro,
          // height: 1.0,
        ),
      ),
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium!.color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        // fontFamily: TextFonts.sfPro,
      ),
    );
  }
}
