import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputLatLng {
  final double lat;
  final double lng;

  InputLatLng(this.lat, this.lng);
}

class InputLatlngWidget extends StatefulWidget {
  const InputLatlngWidget({super.key, required this.vnLatLng});

  final ValueNotifier<InputLatLng> vnLatLng;

  @override
  State<InputLatlngWidget> createState() => _InputLatlngWidgetState();
}

class _InputLatlngWidgetState extends State<InputLatlngWidget> {
  final latEditCtrl = TextEditingController();
  final lngEditCtrl = TextEditingController();

  @override
  void initState() {
    latEditCtrl.text = widget.vnLatLng.value.lat.toString();
    lngEditCtrl.text = widget.vnLatLng.value.lng.toString();
    print('_DemoState: init state finish');

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
            final lat = double.parse(latEditCtrl.text);
            final lng = double.parse(lngEditCtrl.text);
            widget.vnLatLng.value = InputLatLng(lat, lng);
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

  Widget _numInputField(TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9\+-\.]+$')),
      ],
    );
  }
}
