// ignore_for_file: prefer_const_constructors

import 'package:flutter_mvvm_boilerplate/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('email', () {
      test('returns error when email is null', () {
        expect(Validators.email(null), 'Email is required');
      });

      test('returns error when email is empty', () {
        expect(Validators.email(''), 'Email is required');
      });

      test('returns error for invalid email format', () {
        expect(Validators.email('invalid'), 'Invalid email format');
        expect(Validators.email('invalid@'), 'Invalid email format');
        expect(Validators.email('@domain.com'), 'Invalid email format');
        expect(
          Validators.email('no spaces@domain.com'),
          'Invalid email format',
        );
      });

      test('returns null for valid email', () {
        expect(Validators.email('test@example.com'), isNull);
        expect(Validators.email('user.name@domain.co.id'), isNull);
        expect(Validators.email('user-name@gmail.com'), isNull);
      });
    });

    group('password', () {
      test('returns error when password is null', () {
        expect(Validators.password(null), 'Password is required');
      });

      test('returns error when password is empty', () {
        expect(Validators.password(''), 'Password is required');
      });

      test('returns error when password is too short', () {
        expect(
          Validators.password('abc123'),
          'Password must be at least 8 characters',
        );
        expect(
          Validators.password('1234567'),
          'Password must be at least 8 characters',
        );
      });

      test('returns error when password has no numbers', () {
        expect(
          Validators.password('abcdefghij'),
          'Password must contain letters and numbers',
        );
      });

      test('returns null for valid password', () {
        expect(Validators.password('password123'), isNull);
        expect(Validators.password('MyP@ssw0rd'), isNull);
        expect(Validators.password('12345678a'), isNull);
      });
    });

    group('required', () {
      test('returns error when value is null', () {
        expect(Validators.required(null), 'Field is required');
        expect(Validators.required(null, 'Username'), 'Username is required');
      });

      test('returns error when value is empty', () {
        expect(Validators.required(''), 'Field is required');
        expect(Validators.required('   '), 'Field is required');
      });

      test('returns null when value is present', () {
        expect(Validators.required('hello'), isNull);
        expect(Validators.required('  hello  '), isNull);
      });
    });

    group('minLength', () {
      test('returns error when value is too short', () {
        expect(
          Validators.minLength('ab', 3),
          'Field must be at least 3 characters',
        );
        expect(
          Validators.minLength('ab', 3, 'Username'),
          'Username must be at least 3 characters',
        );
      });

      test('returns null when value meets minimum length', () {
        expect(Validators.minLength('abc', 3), isNull);
        expect(Validators.minLength('abcd', 3), isNull);
      });
    });

    group('maxLength', () {
      test('returns error when value is too long', () {
        expect(
          Validators.maxLength('abcdefghijk', 10),
          'Field must be at most 10 characters',
        );
        expect(
          Validators.maxLength('abcdefghijk', 10, 'Bio'),
          'Bio must be at most 10 characters',
        );
      });

      test('returns null when value is within limit', () {
        expect(Validators.maxLength('abcde', 10), isNull);
        expect(Validators.maxLength('abcdefghij', 10), isNull);
        expect(Validators.maxLength(null, 10), isNull);
      });
    });

    group('confirmPassword', () {
      test('returns error when confirmation is empty', () {
        expect(
          Validators.confirmPassword(null, 'password123'),
          'Confirm password is required',
        );
        expect(
          Validators.confirmPassword('', 'password123'),
          'Confirm password is required',
        );
      });

      test('returns error when passwords do not match', () {
        expect(
          Validators.confirmPassword('password456', 'password123'),
          'Passwords do not match',
        );
      });

      test('returns null when passwords match', () {
        expect(
          Validators.confirmPassword('password123', 'password123'),
          isNull,
        );
      });
    });
  });
}
