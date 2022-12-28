class LayoutState {
  final int tabIndex;
  final bool isHide;
  final String? title;

  LayoutState({
    this.tabIndex = 0,
    this.isHide = false,
    this.title,
  });

  LayoutState copyWith({
    int? tabIndex,
    bool? isHide,
    String? title,
  }) {
    return LayoutState(
      tabIndex: tabIndex ?? this.tabIndex,
      isHide: isHide ?? this.isHide,
      title: title ?? this.title,
    );
  }
}
