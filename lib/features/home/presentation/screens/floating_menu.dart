import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/items/presentation/screens/ItemAddDialog.dart';
import 'package:almasah_dates/features/saleOrder/presentation/screens/saleOrderAddDialog.dart';
import 'package:flutter/material.dart';

class DropUpFabMenu extends StatefulWidget {
    final Function(int,[Customer?]) onMenuSelect;
  const DropUpFabMenu({super.key,required this.onMenuSelect});

  @override
  State<DropUpFabMenu> createState() => _DropUpFabMenuState();
}

class _DropUpFabMenuState extends State<DropUpFabMenu> {
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late final TextEditingController itemName;
  late final TextEditingController itemType;
  late final TextEditingController itemSubType;
  late final TextEditingController itemDescr;
  late final TextEditingController salePrice;

  final List<Map<String, dynamic>> options = [
    {'label': 'إضافة صنف', 'icon': Icons.add_box},
    {'label': 'إختيار زبون', 'icon': Icons.person_add},
    {'label': 'تقرير جديد', 'icon': Icons.receipt_long},
  ];

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final fabPosition = renderBox.localToGlobal(Offset.zero);
    final fabSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // tap outside to close
            GestureDetector(
              onTap: _closeMenu,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),

            // right-aligned dropup menu above FAB
            Positioned(
              right:
                  MediaQuery.of(context).size.width -
                  (fabPosition.dx + fabSize.width),
              bottom: MediaQuery.of(context).size.height - fabPosition.dy + 8,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: options.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: Colors.white,
                        elevation: 6,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () {
                            if (item['label'].toString().trim() ==
                                'إضافة صنف') {
                              showDialog(
                                context: context,
                                builder: (_) => ItemAddDialog(),
                              );
                            } else if (item['label'].toString().trim() ==
                                'إختيار زبون') {
                              showDialog(
                                context: context,
                                builder: (_) => Saleorderadddialog(onMenuSelect: widget.onMenuSelect),
                              );
                            }
                            _closeMenu();
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(item['icon'], color: Colors.teal),
                                const SizedBox(width: 8),
                                Text(
                                  item['label'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.teal,
      onPressed: _toggleMenu,
      child: AnimatedRotation(
        turns: _isOpen ? 0.125 : 0,
        duration: const Duration(milliseconds: 200),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
