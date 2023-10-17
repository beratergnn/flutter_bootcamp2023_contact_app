import 'package:contact_bloc_pattern/ui/cubit/registration_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BPD9ContactsRegistrationPage extends StatefulWidget {
  const BPD9ContactsRegistrationPage({super.key});

  @override
  State<BPD9ContactsRegistrationPage> createState() =>
      _BPD9ContactsRegistrationPageState();
}

class _BPD9ContactsRegistrationPageState
    extends State<BPD9ContactsRegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Contact Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                hintText: 'Contact Number',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .read<RegistrationPageCubit>()
                    .save(nameController.text, numberController.text);
              },
              icon: Icon(Icons.save),
              label: Text('Save'),
            )
          ],
        )),
      ),
    );
  }
}
