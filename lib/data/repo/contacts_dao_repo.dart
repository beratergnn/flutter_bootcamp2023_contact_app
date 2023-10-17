import 'package:contact_bloc_pattern/data/entity/contacts.dart';

class BPD9ContactsDaoRepo {
  Future<void> save(String contactName, String contactNumber) async {
    print('Registration Contact: $contactName - $contactNumber');
  }

  Future<void> update(
      int contactId, String contactName, String contactNumber) async {
    print('Update Contact: $contactId $contactName - $contactNumber');
  }

  Future<List<BPD9Contacts>> listContacts() async {
    List<BPD9Contacts> contactList = [];
    BPD9Contacts c1 = BPD9Contacts(
        contactId: 1, contactName: 'Berhat', contactNumber: '05553331188');
    BPD9Contacts c2 = BPD9Contacts(
        contactId: 2, contactName: 'Ahmet', contactNumber: '05553336688');
    BPD9Contacts c3 = BPD9Contacts(
        contactId: 3, contactName: 'Sude', contactNumber: '05551114477');
    BPD9Contacts c4 = BPD9Contacts(
        contactId: 4, contactName: 'Mehmet', contactNumber: '05556662255');
    contactList.add(c1);
    contactList.add(c2);
    contactList.add(c3);
    contactList.add(c4);
    return contactList;
  }

  Future<List<BPD9Contacts>> search(String value) async {
    List<BPD9Contacts> contactList = [];
    BPD9Contacts c1 = BPD9Contacts(
        contactId: 1, contactName: 'Berhat', contactNumber: '05553331188');
    BPD9Contacts c2 = BPD9Contacts(
        contactId: 2, contactName: 'Ahmet', contactNumber: '05553336688');
    contactList.add(c1);
    contactList.add(c2);

    return contactList;
  }

  Future<void> delete(int contactId) async {
    print('Deleted Contact Id :$contactId');
  }
}
