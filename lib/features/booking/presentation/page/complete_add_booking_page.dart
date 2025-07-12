import 'package:flutter/material.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/hotel_summary_card_widget.dart';

class CompleteAddBookingPage extends StatelessWidget {
  const CompleteAddBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'حجز الفندق',
        ),
      ),
      body: Column(
        children: [
           HotelSummaryCard(
            name: "فندق ام القرى السياحي",
            location: "هبرة , سعوان",
            imageUrl: '',
          ),
        ],
      ),
    );
  }
}
