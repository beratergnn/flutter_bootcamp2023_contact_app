import 'package:contact_bloc_pattern/data/repo/contacts_dao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageCubit extends Cubit<void> {
  DetailPageCubit() : super(0);

  var kRapo = BPD9ContactsDaoRepo();
  Future<void> update(
      int contactId, String contactName, String contactNumber) async {
    await kRapo.update(contactId, contactName, contactNumber);
  }
}
