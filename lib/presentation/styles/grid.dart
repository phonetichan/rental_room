import 'spacing.dart';

abstract class AppGridSystem {
  static const mobile = DesignGridSystem(
    columns: 4,
    columnsGutter: AppSpacing.spacing100,
    columnsMargin: AppSpacing.spacing200,
    rowPx: AppSpacing.spacing50,
    rowsGutter: AppSpacing.spacing50,
  );

  static const tablet = DesignGridSystem(
    columns: 8,
    columnsGutter: AppSpacing.spacing200,
    columnsMargin: AppSpacing.spacing200,
    rowPx: AppSpacing.spacing100,
    rowsGutter: AppSpacing.spacing100,
  );

  static const desktop = DesignGridSystem(
    columns: 12,
    columnsGutter: AppSpacing.spacing400,
    columnsMargin: AppSpacing.spacing200,
    rowPx: AppSpacing.spacing100,
    rowsGutter: AppSpacing.spacing100,
  );
}

class DesignGridSystem {
  final int columns;
  final double columnsGutter;
  final double columnsMargin;
  final double rowPx;
  final double rowsGutter;
  final double maxWidth;

  const DesignGridSystem({
    required this.columns,
    required this.columnsGutter,
    required this.columnsMargin,
    required this.rowPx,
    required this.rowsGutter,
    this.maxWidth = 1120,
  });
}
