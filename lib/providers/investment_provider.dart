import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/investment_input.dart';

final investmentInputProvider = StateProvider<InvestmentInput?>((ref) => null);

final allocationResultProvider = Provider<AllocationResult?>((ref) {
  final input = ref.watch(investmentInputProvider);
  if (input == null) return null;

  double stockPct = input.investorType == 'Active' ? 0.6 : 0.3;
  double bondPct = input.investorType == 'Active' ? 0.3 : 0.5;
  double cashPct = 1 - (stockPct + bondPct);

  double stockAmt = input.capital * stockPct;
  double bondAmt = input.capital * bondPct;
  double cashAmt = input.capital * cashPct;

  double stockRet = stockAmt * 0.2;
  double bondRet = bondAmt * 0.1;
  double cashRet = cashAmt * 0.07;

  double totalRet = stockRet + bondRet + cashRet;
  double goalAmt = double.tryParse(input.goal) ?? 0;

  return AllocationResult(
    stockAmount: stockAmt,
    bondAmount: bondAmt,
    cashAmount: cashAmt,
    stockReturn: stockRet,
    bondReturn: bondRet,
    cashReturn: cashRet,
    totalReturn: totalRet,
    goalMet: totalRet + input.capital >= goalAmt,
  );
});
