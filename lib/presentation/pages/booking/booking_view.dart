import 'package:flutter/material.dart';
import '../../../domain/domain.dart';

class BookingView extends StatelessWidget {
  final UserEntity user;

  const BookingView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Booking History & Requests',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}