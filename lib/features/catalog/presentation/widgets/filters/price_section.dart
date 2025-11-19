import 'package:catalog/core/shared/widgets/custom_text_field.dart';
import 'package:catalog/core/shared/widgets/section_title.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({
    super.key,
    required this.minPriceController,
    required this.maxPriceController,
  });

  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Цена'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: minPriceController,
                labelText: 'От',
                hintText: '0',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  context.read<FiltersBloc>().add(
                        FiltersMinPriceChanged(value),
                      );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: maxPriceController,
                labelText: 'До',
                hintText: '1000',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  context.read<FiltersBloc>().add(
                        FiltersMaxPriceChanged(value),
                      );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

