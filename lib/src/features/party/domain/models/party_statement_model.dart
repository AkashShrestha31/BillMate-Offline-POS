class PartyStatementModel {
  const PartyStatementModel({
    required this.party,
    required this.partyInfo,
    required this.role,
    required this.period,
    required this.dateFrom,
    required this.dateTo,
    required this.summary,
    this.openingEntry,
    required this.transactions,
  });

  final String party;
  final PartyStatementPartyInfo partyInfo;
  final String role;
  final String period;
  final String dateFrom;
  final String dateTo;
  final PartyStatementSummary summary;
  final PartyStatementOpeningEntry? openingEntry;
  final List<PartyStatementTransaction> transactions;
}

class PartyStatementPartyInfo {
  const PartyStatementPartyInfo({
    required this.name,
    required this.role,
    this.email,
    this.phone,
    this.address,
    required this.outstandingAmount,
  });

  final String name;
  final String role;
  final String? email;
  final String? phone;
  final String? address;
  final double outstandingAmount;
}

class PartyStatementSummary {
  const PartyStatementSummary({
    required this.openingBalance,
    required this.totalPurchases,
    required this.moneyOut,
    required this.closingBalance,
    required this.totalTransactions,
  });

  final double openingBalance;
  final double totalPurchases;
  final double moneyOut;
  final double closingBalance;
  final int totalTransactions;
}

class PartyStatementOpeningEntry {
  const PartyStatementOpeningEntry({
    required this.date,
    required this.particulars,
    required this.total,
    this.recPaidAmt,
    required this.due,
    required this.runningBalance,
  });

  final String date;
  final String particulars;
  final double total;
  final double? recPaidAmt;
  final double due;
  final double runningBalance;
}

class PartyStatementTransaction {
  const PartyStatementTransaction({
    required this.type,
    required this.date,
    required this.particulars,
    this.reference,
    required this.total,
    required this.recPaidAmt,
    this.due,
    this.items,
    required this.runningBalance,
    this.paymentType,
    this.paymentMethod,
    this.remarks,
    this.references,
  });

  final String type;
  final String date;
  final String particulars;
  final String? reference;
  final double total;
  final double recPaidAmt;
  final double? due;
  final List<PartyStatementItem>? items;
  final double runningBalance;
  final String? paymentType;
  final String? paymentMethod;
  final String? remarks;
  final List<String>? references;
}

class PartyStatementItem {
  const PartyStatementItem({
    required this.item,
    required this.quantity,
    required this.unit,
    required this.rate,
    required this.total,
  });

  final String item;
  final double quantity;
  final String unit;
  final double rate;
  final double total;
}
