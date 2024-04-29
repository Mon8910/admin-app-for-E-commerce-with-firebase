class MyValidators {
  static String? uploadProdTexts({required String? value,required String? toBeReturnedString}) {
    if (value!.isEmpty) {
      return toBeReturnedString;
    }
    return null;
  }
}
