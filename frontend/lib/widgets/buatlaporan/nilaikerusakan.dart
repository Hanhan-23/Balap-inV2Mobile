import 'package:flutter/material.dart';

class NilaiKerusakan extends StatefulWidget {
  const NilaiKerusakan({super.key});

  @override
  State<NilaiKerusakan> createState() => _NilaiKerusakanState();
}
  
class _NilaiKerusakanState extends State<NilaiKerusakan> {
  double _currentSliderValue = 0.0;
  
  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nilai Kerusakan',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instrument-Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14
          ),
        ),
        
        SizedBox(
          width: double.infinity,
          height: 24,
          child: Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('0%',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Instrument-Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                ),
              ),

              Expanded(
                child:  SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackShape: CustomTrackShape(),
                  valueIndicatorTextStyle: TextStyle(
                    fontFamily: 'Instrument-Sans',
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  valueIndicatorColor: Color.fromRGBO(17, 84, 237, 1),
                  trackHeight: 24,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10), 
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
                  activeTrackColor: Color.fromRGBO(17, 84, 237, 1), 
                  inactiveTrackColor: Colors.grey[200],
                  thumbColor: Colors.white, 
                  overlayColor: Color.fromRGBO(17, 84, 237, 1), 
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3.5),
                  activeTickMarkColor: Color.fromRGBO(17, 84, 237, 1),
                  inactiveTickMarkColor: Color.fromRGBO(102, 112, 133, 1),
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0.0,
                  max: 1.0,
                  divisions: 5,
                  label: "${(_currentSliderValue * 100).toInt()}%", 
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              ),

              const Text('100%',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Instrument-Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackLeft = offset.dx + 10;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 20; 
    
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final radius = Radius.circular(trackRect.height / 2);

    final inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, radius),
      inactivePaint,
    );

    final activePaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;
    
    double activeTrackRight = thumbCenter.dx + 12;
    
    activeTrackRight = activeTrackRight.clamp(trackRect.left, trackRect.right);
    
    final activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      activeTrackRight,
      trackRect.bottom,
    );
    
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, radius),
      activePaint,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 128)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round; 
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        trackRect.inflate(-0.5),
        radius,
      ),
      borderPaint,
    );
  }
}