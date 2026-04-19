import '../../../../generated/l10n.dart';

class PaySpec {
  final String instruction;
  final String codeLabel;
  final String codeHint;
  final String codeEmptyError;
  final bool requiresAmount;
  final bool requiresPhoneNumber;
  final bool requiresCodeField;

  const PaySpec({
    required this.instruction,
    required this.codeLabel,
    required this.codeHint,
    required this.codeEmptyError,
    required this.requiresAmount,
    required this.requiresPhoneNumber,
    this.requiresCodeField = true,
  });
}

Map<String, PaySpec> paySpecs = {
  'kuraimi': PaySpec(
    instruction: S.current.payKuraimiInstruction,
    codeLabel: S.current.payKuraimiCodeLabel,
    codeHint: S.current.payKuraimiCodeHint,
    codeEmptyError: S.current.payKuraimiCodeEmptyError,
    requiresAmount: true,
    requiresPhoneNumber: false,
    requiresCodeField: true,
  ),
  'jawali': PaySpec(
    instruction: S.current.payJawaliInstruction,
    codeLabel: S.current.payJawaliCodeLabel,
    codeHint: S.current.payJawaliCodeHint,
    codeEmptyError: S.current.payJawaliCodeEmptyError,
    requiresAmount: false,
    requiresPhoneNumber: true,
    requiresCodeField: true,
  ),
  'flousk': const PaySpec(
    instruction:
        'أدخل رقم الهاتف ومبلغ العربون أو أكثر، وبعد نجاح العملية سيتم طلب كود التحقق لإتمام الدفع.',
    codeLabel: '',
    codeHint: '',
    codeEmptyError: '',
    requiresAmount: true,
    requiresPhoneNumber: true,
    requiresCodeField: false,
  ),
};

String normalizePayMethodName(String? value) {
  final normalized = (value ?? '').trim().toLowerCase();
  if (normalized == 'jawali') return 'jawali';
  if (normalized == 'kuraimi') return 'kuraimi';
  if ({'flousk', 'fulosak', 'flosak', 'flousak', 'فلوسك'}
      .contains(normalized)) {
    return 'flousk';
  }
  return normalized;
}

PaySpec? paySpecForMethod(String? value) {
  return paySpecs[normalizePayMethodName(value)];
}

bool isFloosakPayMethod(String? value) {
  return normalizePayMethodName(value) == 'flousk';
}

