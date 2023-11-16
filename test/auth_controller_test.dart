import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebasematerial/controller/auth_controller.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late AuthController authController;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth();
    authController = AuthController(auth, fakeFirestore.collection('users'));
  });

  group('AuthController Tests', () {
    test('Daftar dengan Email dan Tes Kata Sandi', () async {
      final user = await authController.registerWithEmailAndPassword(
        'test@example.com',
        'password',
        'Test User',
      );

      expect(user, isNotNull);
      expect(user!.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.Uid.isNotEmpty, true);

      final savedUserSnapshot =
          await fakeFirestore.collection('users').doc(user.Uid).get();
      expect(savedUserSnapshot.exists, true);
    });

    test('Masuk dengan Tes Kredensial yang Salah', () async {
      final wrongCredentials = await authController.signInWithEmailAndPassword(
        'nonexistent@example.com', // Non-existent user
        'wrongpassword',
      );

      expect(wrongCredentials, isNull);
    });

    test('Tes Keluar', () async {
      await authController.signOut();
      final currentUser = authController.getCurrentUser();

      expect(currentUser, isNull);
    });

    test('Masuk dengan Tes Email dan Kata Sandi', () async {
      // Tambahkan pengguna baru untuk pengujian login
      await authController.registerWithEmailAndPassword(
        'test_login@example.com',
        'password',
        'Login User',
      );

      final loggedInUser = await authController.signInWithEmailAndPassword(
        'test_login@example.com',
        'password',
      );

      expect(loggedInUser, isNotNull);
      expect(loggedInUser!.email, 'test_login@example.com');
      expect(loggedInUser.name, 'Login User');
      expect(loggedInUser.Uid.isNotEmpty, true);
    });

    test('Dapatkan Tes Pengguna Saat Ini', () {
      final currentUser = authController.getCurrentUser();

      // Pastikan pengguna saat ini tidak ada karena belum ada yang masuk
      expect(currentUser, isNull);
    });
  });
}
