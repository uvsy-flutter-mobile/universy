import 'package:flutter/material.dart';

import 'bar.dart';

class DefaultColorSlider extends StatefulWidget {
  final double _width;
  final double _height;
  final double _slideValue;
  final List<Color> _listOfColors;
  final void Function(double) _onChange;

  DefaultColorSlider(
      {Key key,
      @required double width,
      @required double height,
      @required List<Color> listOfColors,
      @required double slideValue,
      void Function(double) onChange})
      : this._width = width,
        this._height = height,
        this._slideValue = slideValue,
        this._onChange = onChange,
        this._listOfColors = listOfColors,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DefaultColorSliderState(
        _width, _height, _slideValue, _onChange, _listOfColors);
  }
}

class _DefaultColorSliderState extends State<DefaultColorSlider> {
  final double _width;
  final double _height;
  final List<Color> _listOfColors;
  double _slideValue;
  final void Function(double) _onChange;

  _DefaultColorSliderState(
    this._width,
    this._height,
    this._slideValue,
    this._onChange,
    this._listOfColors,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double thumbRadius = _height / 2;
    double overlayRadius = thumbRadius + 2;
    return Stack(
      children: <Widget>[
        Bar(_width, _height, _listOfColors),
        SizedBox(
          width: _width,
          height: _height,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              trackHeight: _height,
              trackShape: RectangularSliderTrackShape(),
              thumbColor: Color(0xFF242424),
              thumbShape:
                  RoundSliderThumbShape(enabledThumbRadius: thumbRadius),
              overlayColor: Colors.blue,
              overlayShape:
                  RoundSliderOverlayShape(overlayRadius: overlayRadius),
            ),
            child: Slider(
              value: _slideValue,
              min: 0,
              max: _getMaximumSliderValue(),
              divisions: _listOfColors.length - 1,
              onChanged: (value) {
                _slideValue = value;
                _onChange(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  double _getMaximumSliderValue() => _listOfColors.length.toDouble() - 1;
}

class ColorfulSlider extends DefaultColorSlider {
  ColorfulSlider.green(
      {Key key,
      @required double width,
      @required double height,
      @required double slideValue,
      void Function(double) onChange})
      : super(
            width: width,
            height: height,
            slideValue: slideValue,
            onChange: onChange,
            listOfColors: [
              Color(0xFFFFE8F1),
              Color(0xFFF6FFA7),
              Color(0xFFF0FF6A),
              Color(0xFFACBF00),
              Color(0xFF45B007),
            ],
            key: key);
  ColorfulSlider.red(
      {Key key,
      @required double width,
      @required double height,
      @required double slideValue,
      void Function(double) onChange})
      : super(
            width: width,
            height: height,
            slideValue: slideValue,
            onChange: onChange,
            listOfColors: [
              Color(0xFFFFE8F1),
              Color(0xFFFFD7A1),
              Color(0xFFFFBB00),
              Color(0xFFFF9200),
              Color(0xFFF44336),
            ],
            key: key);
}
