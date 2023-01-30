import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool showValidator;
  final bool showCancelIcon;
  final bool showlabeltext;

  final String labeltext;
  final bool obsecure;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.showValidator = false,
    required this.hintText,
    this.maxLines = 1,
    this.obsecure = false,
    this.showlabeltext = false,
    this.labeltext = '',
    this.showCancelIcon = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showobsecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obsecure && showobsecure,
      decoration: InputDecoration(
          hintText: widget.hintText,
          label: widget.showlabeltext
              ? widget.labeltext == ''
                  ? Text(widget.hintText)
                  : Text(widget.labeltext)
              : null,
          suffix: widget.obsecure
              ? showobsecure
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showobsecure = false;
                        });
                      },
                      icon: const Icon(Icons.lock))
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          showobsecure = true;
                        });
                      },
                      icon: const Icon(Icons.lock_open))
              : null,
          suffixIcon: widget.showCancelIcon
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    widget.controller.clear();
                  })
              : null,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: widget.showValidator
          ? (val) {
              if (val == null || val.isEmpty) {
                return 'Enter your ${widget.hintText}';
              }
              return null;
            }
          : (value) => null,
      maxLines: widget.maxLines,
    );
  }
}
