import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon; // Peut être null si tu ne souhaites pas utiliser d'icône
  final String? text;
  final VoidCallback? onPressed; // Permet d'accepter null
  final Color color;

  const CustomButton({super.key, 
    this.icon, // Paramètre optionnel
    this.text,
    required this.onPressed, // Le onPressed peut être null
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, // Peut maintenant être null
      icon: icon != null ? Icon(icon, color: Colors.white) : const SizedBox.shrink(),
      label: Text(
        text ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
