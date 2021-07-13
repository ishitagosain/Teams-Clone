import 'package:flutter_test/flutter_test.dart';
import 'package:twoconnect/authentication/validator.dart';

void main() {
  test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Enter Password');
  });

  test('Invalid Password Test', () {
    var result = FieldValidator.validatePassword('123');
    expect(result, 'Password must be more than 6 characters');
  });

  test('Valid Password Test', () {
    var result = FieldValidator.validatePassword('ishita12345');
    expect(result, null);
  });
}