import 'package:firebasematerial/controller/contact_controller.dart';
import 'package:firebasematerial/model/contact_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late ContactController contactController;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    contactController = ContactController(fakeFirestore.collection('contacts'));
  });

  group('ContactController Tests', () {
    test('Add Contact Test', () async {
      final contactModel = ContactModel(
        id: '123',
        name: 'John Doe',
        phone: '1234567890',
        email: 'john@example.com',
        address: '123 Main St',
      );

      await contactController.addContact(contactModel);

      final addedContact = fakeFirestore.collection('contacts').doc('123');
      expect(await addedContact.get(), isNotNull);
    });

    test('Delete Contact Test', () async {
      final contactId = '123';
      await fakeFirestore.collection('contacts').doc(contactId).set({
        'name': 'Test Contact',
        'phone': '0987654321',
        'email': 'test@example.com',
        'address': '456 Elm St',
      });

      await contactController.deleteContact(contactId);

      final deletedContact =
          fakeFirestore.collection('contacts').doc(contactId);
      final snapshot = await deletedContact.get();
      expect(snapshot.exists, false);
    });

    test('Update Contact Test', () async {
      final contactId = '123';
      final initialContact = ContactModel(
        id: contactId,
        name: 'Initial Name',
        phone: '1234567890',
        email: 'initial@example.com',
        address: '789 Elm St',
      );

      await fakeFirestore
          .collection('contacts')
          .doc(contactId)
          .set(initialContact.toMap());

      final updatedContact = ContactModel(
        id: contactId,
        name: 'Updated Name',
        phone: '9876543210',
        email: 'updated@example.com',
        address: '456 Main St',
      );

      await contactController.updateContact(updatedContact);

      final snapshot =
          await fakeFirestore.collection('contacts').doc(contactId).get();
      final updatedData = snapshot.data() as Map<String, dynamic>;

      expect(updatedData['name'], 'Updated Name');
      expect(updatedData['phone'], '9876543210');
      expect(updatedData['email'], 'updated@example.com');
      expect(updatedData['address'], '456 Main St');
    });
  });
}
