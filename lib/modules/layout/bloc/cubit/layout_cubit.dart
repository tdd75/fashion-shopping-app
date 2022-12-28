import 'package:fashion_shopping_app/modules/layout/bloc/state/layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState());

  void updateState({
    int? tabIndex,
    bool? isHide,
  }) {
    emit(state.copyWith(
      tabIndex: tabIndex,
      isHide: isHide,
    ));
  }
}
