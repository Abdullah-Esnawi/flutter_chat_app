import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/auth_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class DropdownButtonWidget extends ConsumerStatefulWidget {
  const DropdownButtonWidget({super.key});

  @override
  ConsumerState<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends ConsumerState<DropdownButtonWidget> {
  List<String> items = ['Logout', 'Settings'];
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: null,
      // isExpanded: true,
      icon: Icon(
        Icons.more_vert_rounded,
        color: AppColors.colors.white,
      ),
      elevation: 6,
      alignment: Alignment.center,
      underline: const SizedBox.shrink(),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: () async => await ref.read(authViewmodelProvider).logout(context),
        );
      }).toList(),
    );
  }
}
