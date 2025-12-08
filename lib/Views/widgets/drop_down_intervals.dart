import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/bookingModel.dart';
import 'package:smart_school_system/Models/timeSlot.dart';

class TimeSlotDropdown extends StatefulWidget {
  final List<BookingModel> bookings;
  final String day;
  final String placeName;

  final List<TimeIntervals> timeSlots = [
    TimeIntervals(from: "8:00", to: "8:50"),
    TimeIntervals(from: "8:50", to: "9:40"),
    TimeIntervals(from: "9:40", to: "10:30"),
    TimeIntervals(from: "11:00", to: "11:50"),
    TimeIntervals(from: "11:50", to: "12:40"),
    TimeIntervals(from: "12:40", to: "1:30"),
    TimeIntervals(from: "1:50", to: "2:40"),
    TimeIntervals(from: "2:40", to: "3:30"),
  ];

  TimeSlotDropdown({
    super.key,
    required this.bookings,
    required this.day,
    required this.placeName,
  });

  @override
  State<TimeSlotDropdown> createState() => TimeSlotDropdownState();
}

class TimeSlotDropdownState extends State<TimeSlotDropdown> {
  TimeIntervals? selected;

  bool isSlotBusy(TimeIntervals slot) {
    return widget.bookings.any(
      (b) =>
          b.day == widget.day &&
          b.place == widget.placeName &&
          b.from == slot.from &&
          b.to == slot.to,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TimeIntervals>(
      initialValue: selected,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xfff3f4f6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      items: widget.timeSlots.map((slot) {
        final busy = isSlotBusy(slot);

        return DropdownMenuItem<TimeIntervals>(
          value: slot,
          enabled: !busy,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${slot.from} - ${slot.to}",
                  style: TextStyle(color: busy ? Colors.grey : Colors.black),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: busy ? Colors.red.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  busy ? "Occupied" : "Vacant",
                  style: TextStyle(
                    fontSize: 12,
                    color: busy ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
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
