abstract class IValueType {
  convertValue(String value);
}

abstract class BaseValueType implements IValueType {
  String nameType;
}

class IntType extends BaseValueType {
  String nameType = 'int';

  @override
  int convertValue(String value) {
    return int.parse(value, radix: 10, onError: (e) => null);
  }
}

class StringType extends BaseValueType {
  String nameType = 'string';

  @override
  String convertValue(String value) {
    return value;
  }
}

class BooleanType extends BaseValueType {
  String nameType = 'bool';

  @override
  bool convertValue(String value) {
    bool result = false;
    if (value != null)
      result = value.length > 0 ? true : false;
    return result;
  }
}

class DoubleType extends BaseValueType {
  String nameType = 'double';

  @override
  double convertValue(String value) {
    return double.parse(value, (e) => null);
  }
}
