class ValidationField<T> {
  final String fieldName;
  T? originValue;
  T? value;
  List<bool Function(T)>? validate;

  ValidationField(
    this.fieldName, {
    this.originValue,
    T? value,
    this.validate,
  }) : value = value ?? originValue;

  bool isDirty() {
    return originValue != value;
  }

  bool isValid() {
    if (validate == null) return true;
    return validate!.every((validateFn) => validateFn(this.value as T));
  }
}
