import 'package:contact_bloc_pattern/data/entity/contacts.dart';
import 'package:contact_bloc_pattern/sqlite/database_helper.dart';

class BPD9ContactsDaoRepo {
  Future<void> save(String contactName, String contactNumber) async {
    var db = await DatabaseHelper.databaseConnection();

    var newContact = Map<String, dynamic>();
    newContact['contact_name'] = contactName;
    newContact['contact_no'] = contactNumber;
    await db.insert('contacts', newContact);

    print('Registration Contact: $contactName - $contactNumber');
  }

  Future<void> update(
      int contactId, String contactName, String contactNumber) async {
    var db = await DatabaseHelper.databaseConnection();

    var updatedContact = Map<String, dynamic>();
    updatedContact['contact_name'] = contactName;
    updatedContact['contact_no'] = contactNumber;
    // Güncelleme yaparken id ye göre yapacağımız için db.update kullanıp where ve whereArgs paramterelerinide yolluyoruz
    // whereArgs güncellenecek kişinin id sini alıp where içine yerleştiriyor ve database e gönderiyor
    await db.update('contacts', updatedContact,
        where: 'contact_id = ?', whereArgs: [contactId]);

    print('Update Contact: $contactId $contactName - $contactNumber');
  }

  Future<List<BPD9Contacts>> getContacts() async {
    // Veritabanına bağlanmak için.
    var db = await DatabaseHelper.databaseConnection();

    // Veritabanında contacts tablosundaki sütunları map olarak çekmek için.
    List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM contacts');

    // Gelen mapleri listeye çevirip ekrana haber vermek için.
    // Neden listeye çeviriyoruz çünkü ekranda böyle görüntülüyoruz. Listeden okuma yapıyoruz.
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return BPD9Contacts(
          contactId: row['contact_id'],
          contactName: row['contact_name'],
          contactNumber: row['contact_no']);
    });
  }

  Future<List<BPD9Contacts>> search(String value) async {
    // Veritabanına bağlanmak için.
    var db = await DatabaseHelper.databaseConnection();

    // Veritabanında contacts tablosundaki sütunları map olarak çekmek için.
    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM contacts WHERE contact_name LIKE '%$value%'");

    // Gelen mapleri listeye çevirip ekrana haber vermek için.
    // Neden listeye çeviriyoruz çünkü ekranda böyle görüntülüyoruz. Listeden okuma yapıyoruz.
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return BPD9Contacts(
          contactId: row['contact_id'],
          contactName: row['contact_name'],
          contactNumber: row['contact_no']);
    });
  }

  Future<void> delete(int contactId) async {
    var db = await DatabaseHelper.databaseConnection();
    await db
        .delete('contacts', where: 'contact_id = ?', whereArgs: [contactId]);

    print('Deleted Contact Id :$contactId');
  }
}
