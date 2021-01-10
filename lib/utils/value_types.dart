abstract class IValueType {
  convertValue(String value);
}

abstract class ValueTypeFactory implements IValueType {

  static final Map<String, IValueType> _cacheForFactory = <String, IValueType>{
    IntType.nameType: IntType(),
    StringType.nameType: StringType(),
    BooleanType.nameType: BooleanType(),
    DoubleType.nameType: DoubleType(),
  };

  factory ValueTypeFactory(String nameType) {
    return _cacheForFactory[nameType];
  }
}

class IntType extends IValueType {
  static String nameType = 'int';

  @override
  int convertValue(String value) {
    return int.parse(value, radix: 10, onError: (e) => null);
  }
}

class StringType extends IValueType {
  static String nameType = 'string';

  @override
  String convertValue(String value) {
    return value;
  }
}

class BooleanType extends IValueType {
  static String nameType = 'bool';

  @override
  bool convertValue(String value) {
    bool result = false;
    if (value != null)
      result = value.length > 0 ? true : false;
    return result;
  }
}

class DoubleType extends IValueType {
  static String nameType = 'double';

  @override
  double convertValue(String value) {
    return double.parse(value, (e) => null);
  }
}
