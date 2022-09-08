import 'package:fitness_app/model.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Display extends StatefulWidget {
  Display({Key? key, this.modelData}) : super(key: key);
  ModelData? modelData;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Display> {
  double val = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          title: Text(
            "Exercise",
            style: TextStyle(color: Colors.white),
          )),
      body: Stack(
        children: [
          Image.network(
            "${widget.modelData!.thumbnail}",
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  innerWidget: (value) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${second.toStringAsFixed(0)} S",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    );
                  },
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10)),
                  min: 3,
                  max: 28,
                  initialValue: second,
                  onChange: (value) {
                    setState(() {
                      second = value;
                    });
                  },
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  double second = 3;
}
