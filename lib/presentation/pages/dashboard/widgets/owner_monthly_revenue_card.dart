import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/di.dart';
import '../../../../domain/domain.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocs/contract_cubit/contract_cubit.dart';
import '../../../extensions/extensions.dart';
import '../../../presentation.dart';

class OwnerMonthlyRevenueCard extends StatelessWidget {
  final UserEntity user;
  const OwnerMonthlyRevenueCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContractCubit>(
      create: (_) => inject<ContractCubit>()..calculateOwnerMonthlyRevenue(user.id),
      child: const _OwnerMonthlyRevenueCardView(),
    );
  }
}

class _OwnerMonthlyRevenueCardView extends StatefulWidget {
  const _OwnerMonthlyRevenueCardView();

  @override
  State<_OwnerMonthlyRevenueCardView> createState() =>
      _OwnerMonthlyRevenueCardViewState();
}

class _OwnerMonthlyRevenueCardViewState
    extends State<_OwnerMonthlyRevenueCardView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF2A2A2A) : AppColors.clrWhite;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : AppColors.clrSoftGrey;
    final textColor = isDark ? Colors.white : AppColors.clrBlack;
    final subtitleColor = isDark ? Colors.white70 : AppColors.clrDarkGrey;

    final septToDecLabels = [
      l10n.monthSep,
      l10n.monthOct,
      l10n.monthNov,
      l10n.monthDec,
    ];

    return BlocBuilder<ContractCubit, ContractState>(
      builder: (context, state) {
        double totalMonthlyRevenue = 0.0;
        int activeContractsCount = 0;

        if (state is ContractRevenueCalculated) {
          totalMonthlyRevenue = state.totalMonthlyRevenue;
          activeContractsCount = state.contracts
              .where((c) =>
          c.status == ContractStatus.active ||
              c.status.value.toLowerCase() == 'active')
              .length;
        } else if (state is ContractSuccess && state.contract != null) {
          totalMonthlyRevenue = state.contract!.monthlyRent;
          activeContractsCount = 1;
        }

        final monthlyAmount =
        totalMonthlyRevenue > 0 ? totalMonthlyRevenue : 0.0;
        final displayValues = [
          monthlyAmount,
          monthlyAmount,
          monthlyAmount,
          monthlyAmount,
        ];
        final isLoading = state is ContractLoading;

        return Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.contractRevenueRange(
                              septToDecLabels.first,
                              septToDecLabels.last,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          isLoading
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            l10n.totalRevenuePerMonth(
                              totalMonthlyRevenue.toKsShortFormat,
                              activeContractsCount,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.clrPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 180,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                    List.generate(displayValues.length, (index) {
                      final value = displayValues[index];
                      final maxVal = displayValues.reduce(
                            (a, b) => a > b ? a : b,
                      );
                      final double heightPercentage =
                      maxVal > 0 ? (value / maxVal) : 0;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            value.toInt().toKsLabelFormat,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: subtitleColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                            height: maxVal > 0
                                ? (120 * heightPercentage)
                                .clamp(10.0, 120.0)
                                : 10.0,
                            width: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.clrPrimary,
                                  AppColors.clrSecondary,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            septToDecLabels[index],
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}