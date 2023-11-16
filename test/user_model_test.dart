import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasematerial/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements User {}

void main() {
  group('UserModel', () {
    test('should create a valid instance from a map', () {
      // arrange
      final map = {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'Uid': '123456789',
      };
      // act
      final result = UserModel.fromMap(map);
      // assert
      expect(result, isA<UserModel>());
      expect(result.name, map['name']);
      expect(result.email, map['email']);
      expect(result.Uid, map['Uid']);
    });

    test('should return a map containing the proper data', () {
      // arrange
      final user = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      // act
      final result = user.toMap();
      // assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], user.name);
      expect(result['email'], user.email);
      expect(result['Uid'], user.Uid);
    });

    test('should create a valid instance from a json string', () {
      // arrange
      final json =
          '{"name":"John Doe","email":"john.doe@example.com","Uid":"123456789"}';
      // act
      final result = UserModel.fromJson(json);
      // assert
      expect(result, isA<UserModel>());
      expect(result.name, 'John Doe');
      expect(result.email, 'john.doe@example.com');
      expect(result.Uid, '123456789');
    });

    test('should return a json string containing the proper data', () {
      // arrange
      final user = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      // act
      final result = user.toJson();
      // assert
      expect(result, isA<String>());
      expect(result, json.encode(user.toMap()));
    });

    test('should return a copy of the instance with the given values', () {
      // arrange
      final user = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      // act
      final result = user.copyWith(
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        Uid: '987654321',
      );
      // assert
      expect(result, isA<UserModel>());
      expect(result.name, 'Jane Doe');
      expect(result.email, 'jane.doe@example.com');
      expect(result.Uid, '987654321');
    });

    test('should return a string representation of the instance', () {
      // arrange
      final user = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      // act
      final result = user.toString();
      // assert
      expect(result, isA<String>());
      expect(result,
          'UserModel(name: John Doe, email: john.doe@example.com, Uid: 123456789)');
    });

    test('should return true when comparing two equal instances', () {
      // arrange
      final user1 = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      final user2 = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      // act
      final result = user1 == user2;
      // assert
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return false when comparing two different instances', () {
      // arrange
      final user1 = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      final user2 = UserModel(
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        Uid: '987654321',
      );
      // act
      final result = user1 != user2;
      // assert
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return a valid hash code for the instance', () {
      // arrange
      final user = UserModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        Uid: '123456789',
      );
      // act
      final result = user.hashCode;
      // assert
      expect(result, isA<int>());
      expect(
          result, user.name.hashCode ^ user.email.hashCode ^ user.Uid.hashCode);
    });
  });
}
