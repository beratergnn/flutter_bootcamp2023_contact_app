// Kişi kayıtı alıcak veritabanına bir kayıt yapıcak ama arayüze bir veri getirmicek
// yani emit yok dinleme yok
import 'package:contact_bloc_pattern/data/repo/contacts_dao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPageCubit extends Cubit<void> {
  RegistrationPageCubit() : super(0);

  var kRepo = BPD9ContactsDaoRepo();

  Future<void> save(String contactName, String contactNumber) async {
    await kRepo.save(contactName, contactNumber);
  }
}
