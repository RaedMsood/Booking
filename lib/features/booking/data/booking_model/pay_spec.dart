import '../../../../generated/l10n.dart';

class PaySpec {
  final String instruction;
  final String codeLabel;
  final String codeHint;
  final String codeEmptyError;
  final bool requiresAmount;
  final bool requiresPhoneNumber;

  const PaySpec({
    required this.instruction,
    required this.codeLabel,
    required this.codeHint,
    required this.codeEmptyError,
    required this.requiresAmount,
    required this.requiresPhoneNumber,
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
  ),
  'jawali': PaySpec(
    instruction: S.current.payJawaliInstruction,
    codeLabel: S.current.payJawaliCodeLabel,
    codeHint: S.current.payJawaliCodeHint,
    codeEmptyError: S.current.payJawaliCodeEmptyError,
    requiresAmount: false,
    requiresPhoneNumber: true,
  ),
};
