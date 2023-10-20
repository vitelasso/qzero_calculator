import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MacroCreationPage extends StatefulWidget {
  const MacroCreationPage({super.key});

  @override
  State<MacroCreationPage> createState() => _MacroCreationPageState();
}

class _MacroCreationPageState extends State<MacroCreationPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'Single Film Width',
            decoration: const InputDecoration(labelText: 'Email'),
            initialValue: '25',
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'Single Film Height',
            decoration: const InputDecoration(labelText: 'Email'),
            initialValue: '50',
          ),
          FormBuilderTextField(
            name: 'Single Film W/m',
            decoration: const InputDecoration(labelText: 'Email'),
            initialValue: '40',
          ),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              // Validate and save the form values
              _formKey.currentState?.saveAndValidate();
              debugPrint(_formKey.currentState?.value.toString());

              // On another side, can access all field values without saving form with instantValues
              _formKey.currentState?.validate();
              debugPrint(_formKey.currentState?.instantValue.toString());
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
