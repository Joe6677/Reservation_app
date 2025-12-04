import 'package:flutter/material.dart';

class ClassSlotDropdown extends StatefulWidget {
  const ClassSlotDropdown({super.key});

  @override
  State<ClassSlotDropdown> createState() => ClassSlotDropdownState();
}

class ClassSlotDropdownState extends State<ClassSlotDropdown> {
  String? selected;
  List<String> classes = [
    '1A',
    '1B',
    '2A',
    '2B',
    '3A',
    '3B',
    '4A',
    '4B',
    '5A',
    '5B',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selected,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xfff3f4f6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      items: classes.map((slot) {
        return DropdownMenuItem<String>(
          value: slot,
          child: Expanded(
            child: Text(slot, style: TextStyle(color: Colors.black)),
          ),
        );
      }).toList(),
      onChanged: (slot) {
        if (slot == null) return;
        setState(() => selected = slot);
      },
    );
  }
}
