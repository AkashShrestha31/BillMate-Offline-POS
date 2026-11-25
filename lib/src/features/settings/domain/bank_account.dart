class BankAccount {
  const BankAccount({
    required this.name,
    this.accountNumber,
    this.accountHolder,
    this.isDefault = false,
  });

  final String name;
  final String? accountNumber;
  final String? accountHolder;
  final bool isDefault;
}

class BankLedgerLine {
  const BankLedgerLine({
    required this.name,
    required this.date,
    required this.paymentType,
    required this.amount,
    required this.paymentMethod,
    this.party,
    this.referenceId,
  });

  final String name;
  final String date;
  final String paymentType;
  final double amount;
  final String paymentMethod;
  final String? party;
  final String? referenceId;

  bool get isIncoming => paymentType.trim().toLowerCase() == 'receive';
}

class BankReport {
  const BankReport({
    required this.bank,
    required this.incoming,
    required this.outgoing,
    required this.lines,
  });

  final BankAccount bank;
  final double incoming;
  final double outgoing;
  final List<BankLedgerLine> lines;

  double get net => incoming - outgoing;
}
