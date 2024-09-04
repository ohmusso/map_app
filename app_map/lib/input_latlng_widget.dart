import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlng/latlng.dart';
import 'controller.dart';

class InputLatlngWidget extends StatefulWidget {
  const InputLatlngWidget(
      {super.key, required this.vnLatLng, required this.vecmapController});

  final ValueNotifier<LatLng> vnLatLng;
  final VecmapController vecmapController;

  @override
  State<InputLatlngWidget> createState() => _InputLatlngWidgetState();
}

class _InputLatlngWidgetState extends State<InputLatlngWidget> {
  final latEditCtrl = TextEditingController();
  final lngEditCtrl = TextEditingController();

  @override
  void initState() {
    latEditCtrl.text = widget.vnLatLng.value.latitude.degrees.toString();
    lngEditCtrl.text = widget.vnLatLng.value.longitude.degrees.toString();

    widget.vnLatLng.addListener(() {
      _updateInpudLatLngField();
      // setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _numInputField(latEditCtrl),
        _numInputField(lngEditCtrl),
        ElevatedButton(
          onPressed: () {
            final lat = double.tryParse(latEditCtrl.text);
            final lng = double.tryParse(lngEditCtrl.text);
            if ((lat != null) && (lng != null)) {
              widget.vnLatLng.value = LatLng.degree(lat, lng);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('invalid input'),
              ));
            }
          },
          child: Text('update'),
        )
      ],
    );
  }

  @override
  void dispose() {
    latEditCtrl.dispose();
    lngEditCtrl.dispose();
    super.dispose();
  }

  void _updateInpudLatLngField() {
    latEditCtrl.text = widget.vnLatLng.value.latitude.degrees.toString();
    lngEditCtrl.text = widget.vnLatLng.value.longitude.degrees.toString();
  }

  Widget _numInputField(TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9\+-\.]+$')),
      ],
    );
  }
}
