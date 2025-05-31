class ExpenseValidator {

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Enter a valid amount greater than zero';
    }
    return null;
  }
}
