class CustomValidator {
 static String? productNameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Product name cannot be empty';
    }
    return null;
  }
}
