import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySlider extends StatefulWidget {
  double sliderValue;
  MySlider({super.key, required this.sliderValue});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
            trackHeight: 33,
            trackShape: RectangularSliderTrackShape(),
            thumbShape: SliderComponentShape.noOverlay,
            overlayShape: SliderComponentShape.noOverlay,
            activeTrackColor: ColorsAsset.green,
            inactiveTrackColor: ColorsAsset.littleGrey,
            valueIndicatorShape: SliderComponentShape.noOverlay,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent),
        child: SizedBox(
          width: 91,
          child: Stack(alignment: Alignment.center, children: [
            Slider(
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
