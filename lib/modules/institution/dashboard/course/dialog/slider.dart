import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:universy/widgets/paddings/edge.dart';
import 'package:universy/widgets/slider/slider.dart';

const SLIDER_OFFSET = 1;

class StudentCourseRateSliderWidget extends StatefulWidget {
  final int _sliderValue;
  final String _sliderLabel;
  final Function(int) _onChange;
  final bool _negativeRating;

  const StudentCourseRateSliderWidget({
    Key key,
    @required int sliderValue,
    @required String sliderLabel,
    @required Function(int) onChange,
    bool negativeRating = false,
  })  : this._sliderValue = sliderValue,
        this._sliderLabel = sliderLabel,
        this._onChange = onChange,
        this._negativeRating = negativeRating,
        super(key: key);

  @override
  _StudentCourseRateSliderWidgetState createState() =>
      _StudentCourseRateSliderWidgetState();
}

class _StudentCourseRateSliderWidgetState
    extends State<StudentCourseRateSliderWidget> {
  int _sliderValue;
  String _sliderLabel;
  Function(int) _onChange;
  bool _negativeRating;

  @override
  void initState() {
    this._sliderValue = widget._sliderValue;
    this._sliderLabel = widget._sliderLabel;
    this._onChange = widget._onChange;
    this._negativeRating = widget._negativeRating;
    super.initState();
  }

  @override
  void dispose() {
    this._sliderValue = null;
    this._sliderLabel = null;
    this._onChange = null;
    this._negativeRating = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(child: _buildRateTitle(), flex: 3),
          Expanded(
              child: SymmetricEdgePaddingWidget.horizontal(
                paddingValue: 15,
                child: _buildScoreLabel(),
              ),
              flex: 2),
          Expanded(child: _buildColorfulSlider(25, 125), flex: 5),
        ],
      ),
    );
  }

  Widget _buildColorfulSlider(double height, double width) {
    if (_negativeRating) {
      return ColorfulSlider.red(
        height: height,
        width: width,
        slideValue: _getSliderValueForColorfulSlider(),
        onChange: _changeRate,
      );
    }
    return ColorfulSlider.green(
        height: height,
        width: width,
        slideValue: _getSliderValueForColorfulSlider(),
        onChange: _changeRate);
  }

  void _changeRate(double value) {
    int valueFromSlider = value.toInt() + SLIDER_OFFSET;
    setState(() {
      _sliderValue = valueFromSlider;
    });
    _onChange(valueFromSlider);
  }

  Widget _buildRateTitle() {
    return SizedBox(
      width: 100,
      child: AutoSizeText(
        _sliderLabel,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  Widget _buildScoreLabel() {
    return Center(
      child: Text(
        _getSliderValueText(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  String _getSliderValueText() => _sliderValue.toString();

  double _getSliderValueForColorfulSlider() {
    return _sliderValue.toDouble() - SLIDER_OFFSET;
  }
}
