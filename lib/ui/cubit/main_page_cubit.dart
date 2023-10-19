// Ana sayfa arayüze veri bekleyen bir sayfa
// silme arama ve listeleme hepsinde arayüzde bir kişier listesi arayüzde beklenicek
import 'package:contact_bloc_pattern/data/entity/contacts.dart';
import 'package:contact_bloc_pattern/data/repo/contacts_dao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageCubit extends Cubit<List<BPD9Contacts>> {
  MainPageCubit() : super(<BPD9Contacts>[]);

  var kRepo = BPD9ContactsDaoRepo();
  Future<void> getContacts() async {
    var list = await kRepo.getContacts();
    emit(list);
  }

  Future<void> search(String value) async {
    var list = await kRepo.search(value);
    emit(list);
  }

  Future<void> delete(int contactId) async {
    await kRepo.delete(contactId);
    // sildikten sonra tekrar arayüzü güncellemek için
    // yazmak isek ileride veritabanına bağlayınca
    // silme işlemini yapar ama ekranda anlık göremeyiz
    await getContacts();
  }
}
