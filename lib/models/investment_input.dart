class InvestmentInput {
  final double capital;
  final String goal;
  final String investorType;

  InvestmentInput({
    required this.capital,
    required this.goal,
    required this.investorType,
  });
}

class AllocationResult {
  final double stockAmount;
  final double bondAmount;
  final double cashAmount;

  final double stockReturn;
  final double bondReturn;
  final double cashReturn;

  final double totalReturn;
  final bool goalMet;

  AllocationResult({
    required this.stockAmount,
    required this.bondAmount,
    required this.cashAmount,
    required this.stockReturn,
    required this.bondReturn,
    required this.cashReturn,
    required this.totalReturn,
    required this.goalMet,
  });
}
