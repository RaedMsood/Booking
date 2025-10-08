
class PaySpec {
  final String instruction;
  final String codeLabel;
  final String codeHint;
  final String codeEmptyError;
  final bool requiresAmount;
  const PaySpec({
    required this.instruction,
    required this.codeLabel,
    required this.codeHint,
    required this.codeEmptyError,
    required this.requiresAmount,
  });
}


const Map<String, PaySpec> paySpecs = {
  'kuraimi': PaySpec(
    instruction: 'رقم التعريف يُولَّد من إعدادات تطبيق الكريمي لأول مرة',
    codeLabel: 'رمز التعريف',
    codeHint: 'رمز التعريف',
    codeEmptyError: 'يرجى إدخال رمز التعريف',
    requiresAmount: true,
  ),
  'jawali': PaySpec(
    instruction: 'أدخل كود الشراء المنشأ في تطبيق جوالي',
    codeLabel: 'كود الشراء',
    codeHint: 'كود الشراء',
    codeEmptyError: 'يرجى إدخال كود الشراء',
    requiresAmount: false,
  ),
};


