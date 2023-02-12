import 'package:easy_debounce/easy_debounce.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseRangeSlider extends StatefulWidget {
  final List<double> initRange;
  final double min;
  final double max;
  final Function(double start, double end) onChanged;

  const BaseRangeSlider({
    super.key,
    required this.initRange,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  State<BaseRangeSlider> createState() => _BaseRangeSliderState();
}

class _BaseRangeSliderState extends State<BaseRangeSlider> {
  RangeValues? _currentRangeValues;

  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.initRange[0], widget.initRange[1]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          min: widget.min,
          max: widget.max,
          values: _currentRangeValues!,
          labels: RangeLabels(
            _currentRangeValues!.start.toStringAsFixed(2),
            _currentRangeValues!.end.toStringAsFixed(2),
          ),
          onChanged: (rangeValue) {
            setState(() {
              _currentRangeValues = rangeValue;
            });
            EasyDebounce.debounce(
              'debounce',
              const Duration(milliseconds: 50),
              () => widget.onChanged(rangeValue.start, rangeValue.end),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                widget.min.toStringAsFixed(2),
                fontSize: 16,
                color: ColorConstants.primary,
                fontWeight: FontWeight.w500,
              ),
              Wrap(
                children: [
                  BaseText(
                    '[${_currentRangeValues!.start.toStringAsFixed(2)} -',
                    fontSize: 16,
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  BaseText(
                    ' ${_currentRangeValues!.end.toStringAsFixed(2)}]',
                    fontSize: 16,
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              BaseText(
                widget.max.toStringAsFixed(2),
                fontSize: 16,
                color: ColorConstants.primary,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        )
      ],
    );
  }
}
