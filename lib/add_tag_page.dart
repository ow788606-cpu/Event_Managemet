import 'package:flutter/material.dart';

class AddTagPage extends StatefulWidget {
  const AddTagPage({super.key});

  @override
  State<AddTagPage> createState() => _AddTagPageState();
}

class _AddTagPageState extends State<AddTagPage> {
  final _formKey = GlobalKey<FormState>();
  final _tagNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _colorHexController = TextEditingController(text: '#520350');
  Color _selectedColor = const Color(0xFF520350);

  final List<Color> _predefinedColors = [
    const Color(0xFF520350),
    const Color(0xFF3498DB),
    const Color(0xFF1ABC9C),
    const Color(0xFF8E44AD),
    const Color(0xFF27AE60),
    const Color(0xFFC0392B),
    const Color(0xFF2C3E50),
    const Color(0xFFF39C12),
    const Color(0xFF9B59B6),
    const Color(0xFFE74C3C),
    const Color(0xFF16A085),
    const Color(0xFFD35400),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Tag', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF520350))),
              Text('Create a new tag for better organization.', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('All Tags', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Tag Name ',
                    style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _tagNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter tag name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Description', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Color', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!, width: 2),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _colorHexController,
                        decoration: InputDecoration(
                          hintText: '#520350',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.startsWith('#') && value.length == 7) {
                            try {
                              setState(() {
                                _selectedColor = Color(int.parse(value.substring(1), radix: 16) + 0xFF000000);
                              });
                            } catch (e) {
                              // Invalid color format
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Pick a color that will be shown as a swatch in the list.', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _predefinedColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                          final hexString = color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase();
                          _colorHexController.text = '#$hexString';
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedColor == color ? Colors.black : Colors.grey[300]!,
                            width: _selectedColor == color ? 3 : 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tag added successfully!')),
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF520350),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Add Tag', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(color: Colors.grey[400]!),
                      ),
                      child: Text('Close', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tagNameController.dispose();
    _descriptionController.dispose();
    _colorHexController.dispose();
    super.dispose();
  }
}
