import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_school_system/Models/tab_model.dart';
import 'package:smart_school_system/ViewModel/book_place.dart';

class TimeSlotDropdown extends StatefulWidget {
  const TimeSlotDropdown({super.key});

  @override
  State<TimeSlotDropdown> createState() => TimeSlotDropdownState();
}

class TimeSlotDropdownState extends State<TimeSlotDropdown> {
  TabModel? selected;

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<BookPlace>(context);
    return DropdownButtonFormField<TabModel>(
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
      items: p.filteredSessions.map((slot) {
        final enabled = slot.isAvailable;

        return DropdownMenuItem<TabModel>(
          value: slot,
          enabled: enabled,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${slot.from} - ${slot.to}",
                  style: TextStyle(
                    color: !enabled ? Colors.grey.shade600 : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: !enabled
                      ? const Color(0xffffe1e1)
                      : const Color(0xffe0ffe6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  !enabled ? 'Occupied' : 'Vacant',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: !enabled ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
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
