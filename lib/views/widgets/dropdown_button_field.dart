import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/complaint_provider.dart';

class DropdownButtonField extends StatelessWidget {
  const DropdownButtonField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComplaintProvider>(
      builder: (context, value, child) {
        return DropdownButtonFormField<String>(
          value: value.selectedWaste,

          hint: Text(
            'Select waste type',
            style: TextStyle(
              fontSize: context.width * 0.041,
              color: const Color(0xFFB0B3BA),
            ),
          ),

          icon: Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF1F2937),
            size: context.width * 0.065,
          ),

          isExpanded: true,

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            contentPadding: EdgeInsets.symmetric(
              horizontal: context.width * 0.050,
              vertical: context.height * 0.025,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width * 0.040),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width * 0.040),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width * 0.040),
              borderSide: const BorderSide(
                color: Color(0xFF28BF5E),
                width: 1.5,
              ),
            ),
          ),

          dropdownColor: Colors.white,

          items: [
            DropdownMenuItem<String>(
              value: 'Household Waste',
              child: Text('Household Waste'),
            ),
            DropdownMenuItem<String>(
              value: 'Plastic Waste',
              child: Text('Plastic Waste'),
            ),
            DropdownMenuItem<String>(
              value: 'Construction Debris',
              child: Text('Construction Debris'),
            ),
            DropdownMenuItem<String>(
              value: 'Garden Waste',
              child: Text('Garden Waste'),
            ),
            DropdownMenuItem<String>(value: 'E-Waste', child: Text('E-Waste')),
            DropdownMenuItem<String>(value: 'Other', child: Text('Other')),
          ],

          onChanged: (val) {
            value.selectedWaste = val;
          },
        );
      },
    );
  }
}
