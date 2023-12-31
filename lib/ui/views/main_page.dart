import 'package:contact_bloc_pattern/data/entity/contacts.dart';
import 'package:contact_bloc_pattern/ui/cubit/main_page_cubit.dart';
import 'package:contact_bloc_pattern/ui/views/detail_page.dart';
import 'package:contact_bloc_pattern/ui/views/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ara',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (searchingResult) {
                    // arama yapmak için herhangi bir harfe basıldığı anda MainPageCubit içindeki search metodu çalışır.
                    // bu metod da içindeki listeyi doldurmak için repoya çıkar repodan burada bir liste döner ve oda emit ile bunu sayfaya haber verir.
                    // BlocBuilder<MainPageCubit, List<BPD9Contacts>> olan yere bu liste döndürülür ve ekrana basılır.
                    context.read<MainPageCubit>().search(searchingResult);
                  },
                ),
              )
            : Text('Contacts'),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                    // Bunu koymaz isek arama yapıldıktan sonra ki kişiler listelenmeye devam eder
                    // arama işlemi bittikten sonra olan tüm kayıtların gelmesi için tekrar listeleme yapıyoruz.
                    context.read<MainPageCubit>().getContacts();
                  },
                  icon: Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<MainPageCubit, List<ContactsModel>>(
            builder: (context, snapshot) {
          if (snapshot.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.length,
                itemBuilder: ((context, index) {
                  var contact = snapshot[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        contact: contact,
                                      ))).then((value) {
                            print(
                                'You came back to Main Page from Detail Page');
                            context.read<MainPageCubit>().getContacts();
                          });
                        },
                        leading: Text('${contact.contactId}'),
                        title: Text(
                          contact.contactName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(contact.contactNumber),
                        trailing: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Do you want to delete ${contact.contactName}? ',
                                ),
                                action: SnackBarAction(
                                    label: 'Evet',
                                    onPressed: () {
                                      context
                                          .read<MainPageCubit>()
                                          .delete(contact.contactId);
                                    }),
                              ),
                            );
                          },
                          icon: Icon(Icons.clear),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey, width: 2),
                        ),
                        iconColor: Colors.red,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }));
          } else {
            return const Text('Contacts not found');
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()))
              .then((value) {
            context.read<MainPageCubit>().getContacts();
            print('You came back to Main Page from Registration Page');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
