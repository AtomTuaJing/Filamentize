import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySlider extends StatefulWidget {
  double sliderValue;
  final isRotate;
  final double? trackHeight;
  final double? sizedBoxWidth;
  MySlider(
      {super.key,
      required this.sliderValue,
      required this.isRotate,
      this.trackHeight,
      this.sizedBoxWidth});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
            trackHeight: widget.trackHeight != null
                ? widget.trackHeight
                : widget.isRotate
                    ? 50
                    : 33,
            trackShape: RectangularSliderTrackShape(),
            thumbShape: SliderComponentShape.noOverlay,
            overlayShape: SliderComponentShape.noOverlay,
            activeTrackColor: ColorsAsset.green,
            inactiveTrackColor: ColorsAsset.littleGrey,
            valueIndicatorShape: SliderComponentShape.noOverlay,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent),
        child: SizedBox(
          width: widget.sizedBoxWidth != null
              ? widget.sizedBoxWidth
              : widget.isRotate
                  ? 60
                  : 91,
          child: Stack(alignment: Alignment.center, children: [
            widget.isRotate
                ? RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: widget.sliderValue,
                      divisions: 10,
                      min: 0,
                      max: 100,
                      onChanged: (double newValue) {
                        setState(() {
                          widget.sliderValue = newValue;
                        });
                      },
                    ),
                  )
                : Slider(
                    value: widget.sliderValue,
                    divisions: 10,
                    min: 0,
                    max: 100,
                    onChanged: (double newValue) {
                      setState(() {
                        widget.sliderValue = newValue;
                      });
                    },
                  ),
            Text("${widget.sliderValue.round().toString()}%",
                style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ColorsAsset.white))
          ]),
        ));
  }
}
