class FilterCategory {
  final String key; // 'condition', 'severity'
  final String title; //   'Condition', 'Severity'
  final List<String> options; //   ['Stable', 'Unstable']
  List<String> selectedOptions; //
  final bool hasSearchBar;

  FilterCategory({
    required this.key,
    required this.title,
    required this.options,
    List<String>? initialSelectedOptions,
    this.hasSearchBar = true,
  }) : selectedOptions = initialSelectedOptions ?? [];
}