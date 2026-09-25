// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/utilities_meters_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../widget/detail_row.dart';

class UtilitiesMetersScreen extends StatefulWidget {
  const UtilitiesMetersScreen({super.key});

  @override
  State<UtilitiesMetersScreen> createState() => _UtilitiesMetersScreenState();
}

class _UtilitiesMetersScreenState extends State<UtilitiesMetersScreen> {
  String selectedFlat = 'Flat 1';
  final flats = const ['Flat 1', 'Flat 2A', 'Flat 2B', 'Flat 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: 'Utilities & Meters'),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          CustomDropdownField<String>(
            value: selectedFlat,
            items: flats.map((f) => DropdownMenuItem(value: f, child: CustomText(title: f, textSize: 14.sp))).toList(),
            onChanged: (v) => setState(() => selectedFlat = v ?? selectedFlat),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              children: [
                DetailRow(icon: Icons.local_fire_department_outlined, label: 'Gas Meter', value: 'GM-$selectedFlat-001'),
                DetailRow(icon: Icons.bolt_outlined, label: 'Electric Meter', value: 'EM-$selectedFlat-001'),
                DetailRow(icon: Icons.water_drop_outlined, label: 'Water Stopcock', value: 'Under kitchen sink'),
                DetailRow(icon: Icons.speed_outlined, label: 'Last Reading Date', value: '15 Aug 2026', isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}