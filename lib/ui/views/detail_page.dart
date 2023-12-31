import 'package:contact_bloc_pattern/data/entity/contacts.dart';
import 'package:contact_bloc_pattern/ui/cubit/detail_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final ContactsModel contact;

  const DetailPage({super.key, required this.contact});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchContact();
  }

  void fetchContact() {
    var v_contact = widget.contact;
    nameController.text = v_contact.contactName;
    numberController.text = v_contact.contactNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                context.read<DetailPageCubit>().update(widget.contact.contactId,
                    nameController.text, numberController.text);
              },
              icon: Icon(Icons.update),
              label: Text('Update'),
            )
          ],
        ),
      )),
    );
  }
}
