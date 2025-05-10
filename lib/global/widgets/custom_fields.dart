import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/// A custom text field widget that handles validation and error messages internally.
///
/// This widget supports showing a custom error message if the field is required
/// and left empty, and it can display a provided error message if specified.
///
/// It also includes features like max length enforcement, numeric input support,
/// and real-time validation feedback.

class CustomTextField extends StatefulWidget {
  /// The label text to display above the text field.
  final String labelText;

  /// Label style for the text field.
  final TextStyle? labelStyle;

  /// An optional information message to show when the information icon is tapped .
  final String? infoMessage;

  /// Whether the field is required or not. If `true`, an error will be shown
  /// if the field is left empty when validated.
  final bool isRequired;

  /// A controller for controlling the text being edited.
  final TextEditingController controller;

  /// A callback function that is called when the text in the field changes in real time.
  final Function(String)? onChanged;

  /// An optional error message to display when validation fails.
  /// If not provided, a default message will be used for required fields.
  final String? errorText;

  /// Callback function that is called when the error state changes.
  final Function(bool hasError)? onErrorChanged;

  /// The maximum number of characters allowed in the text field.
  final int? maxLength;

  /// The maximum number of lines allowed in the text field.
  final int? maxLines;

  /// Allow newline in the text field. It's like a skip line.
  final bool allowNewLine;

  /// Whether the field should only accept numeric input. If `true`,
  /// the keyboard will be set to number mode and only digits will be allowed.
  final bool isNumeric;

  /// Whether the field should validate the input as an email address.
  final bool isEmail;

  /// The hint text to display when the field is empty.
  final String hintText;
  final Icon? hintIcon;

  /// Whether the field is a dropdown field or not.
  final bool isDropDown;

  /// The initial value for the dropdown field. If not provided, the first option will be selected.
  /// Be sure to provide a value that is present in the `dropDownOptions` list.
  final String? initialDropDownValue;

  /// The list of options to display in the dropdown field.
  final List<String>? dropDownOptions;

  /// Whether the field is enabled or not. If `false`, the field will be disabled.
  final bool isEnabled;

  /// Text capitalization for the text field.
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.labelStyle,
    this.infoMessage,
    this.isRequired = false,
    required this.controller,
    this.onChanged,
    this.errorText,
    this.onErrorChanged,
    this.maxLength,
    this.maxLines,
    this.allowNewLine = false,
    this.isNumeric = false,
    this.isEmail = false,
    this.hintText = '',
    this.isEnabled = true,
    this.hintIcon,
    this.isDropDown = false,
    this.initialDropDownValue,
    this.dropDownOptions,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateInput);
    if (widget.isDropDown &&
        widget.dropDownOptions != null &&
        widget.dropDownOptions!.isNotEmpty) {
      _selectedItem = widget.dropDownOptions!.first;
    }
    _selectedItem = widget.initialDropDownValue ??
        (widget.isDropDown &&
                widget.dropDownOptions != null &&
                widget.dropDownOptions!.isNotEmpty
            ? widget.dropDownOptions!.first
            : null);
  }

  /// Validates the input based on whether the field is required and email validation if applicable.
  void _validateInput() {
    final trimmedText = widget.controller.text.trim();

    if (widget.isRequired && trimmedText.isEmpty) {
      setState(() {
        _errorText = widget.errorText ?? 'Este campo es obligatorio';
      });
    } else if (widget.isEmail && !_isValidEmail(trimmedText)) {
      setState(() {
        _errorText = 'Ingresa un email válido';
      });
    } else {
      setState(() {
        _errorText = widget.errorText;
      });
    }
    if (widget.onErrorChanged != null) {
      widget.onErrorChanged!(_errorText != null);
    }
  }

  /// Helper method to validate email using a regular expression.
  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateInput);
    super.dispose();
  }

  void _showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // This function gets the keyboard type according the CustomTextField params, add here whenever you implement a new keyboard type.
  TextInputType _getInputType() {
    TextInputType inputType;
    if (widget.isEmail) {
      inputType = TextInputType.emailAddress;
    } else if (widget.allowNewLine) {
      inputType = TextInputType.multiline;
    } else if (widget.isNumeric) {
      inputType = TextInputType.number;
    } else {
      inputType = TextInputType.text;
    }

    return inputType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  if (widget.isRequired)
                    const TextSpan(
                      text: '* ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.redAccent,
                      ),
                    ),
                  TextSpan(
                    text: widget.labelText,
                    style: widget.labelStyle ??
                        const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
            if (widget.infoMessage != null)
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => _showInfoDialog(context, widget.infoMessage!),
              ),
          ],
        ),
        const SizedBox(height: 2),
        if (!widget.isDropDown)
          TextField(
            enabled: widget.isEnabled,
            maxLength: widget.maxLength,
            maxLines: widget.isEmail ? 1 : widget.maxLines,
            autocorrect: true,
            inputFormatters: [
              if (widget.isEmail)
                FilteringTextInputFormatter.deny(RegExp(r"\s"))
            ],
            textInputAction: widget.allowNewLine
                ? TextInputAction.newline
                : TextInputAction.done,
            keyboardType: _getInputType(),
            textCapitalization: widget.isEmail
                ? TextCapitalization.none
                : widget.textCapitalization,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              prefixIcon: widget.hintIcon,
              errorText: _errorText ??
                  widget.errorText, // Combine internal and external validation
              counterText: widget.maxLength != null
                  ? '${widget.controller.text.trim().length} / ${widget.maxLength}'
                  : null,
              counterStyle: const TextStyle(fontSize: 8),
            ),
            controller: widget.controller,
            onChanged: (value) {
              widget.onChanged?.call(value.trim());
              _validateInput(); // Real-time validation
            },
          ),
        if (widget.isDropDown)
          DropdownButtonFormField<String>(
            value: _selectedItem,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              errorText: _errorText ??
                  widget.errorText, // Combine internal and external validation
              prefixIcon: widget.hintIcon,
            ),
            items: widget.dropDownOptions
                ?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
                widget.controller.text = value?.trim() ?? '';
                widget.onChanged?.call(value?.trim() ?? '');
                _validateInput(); // Dropdown validation
              });
            },
          )
      ],
    );
  }
}
