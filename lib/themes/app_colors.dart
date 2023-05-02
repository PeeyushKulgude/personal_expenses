import 'package:flutter/material.dart';

class AppColors {
  static Color appBarIconColorDark = const Color.fromRGBO(255, 255, 255, 1);
  static Color appBarIconColorLight = const Color.fromRGBO(0, 0, 0, 0.8);
  static Color appBarFillColor = const Color.fromRGBO(72, 145, 148, 70);

  static Color cardBackgroundColorDark = const Color.fromARGB(156, 27, 27, 27);
  static Color cardBackgroundColorLight = const Color.fromRGBO(227, 227, 227, 1);
  static Color cardBorderSideColorDark = const Color.fromARGB(156, 39, 39, 39);
  static Color cardBorderSideColorLight = const Color.fromRGBO(206, 206, 206, 1);

  static Color alertDialogBackgroundColorDark = const Color.fromRGBO(27, 27, 27, 0.95);
  static Color alertDialogBackgroundColorLight = const Color.fromRGBO(227, 227, 227, 0.95);

  static Color incomePrimaryColor = const Color.fromRGBO(50, 176, 74, 1);
  static Color incomeBackgroundColor = const Color.fromRGBO(50, 176, 74, 0.4);
  static Color incomeBorderColor = const Color.fromRGBO(50, 176, 74, 1);

  static Color expensePrimaryColor = const Color.fromRGBO(241, 89, 42, 1);
  static Color expenseBackgroundColor = const Color.fromRGBO(241, 89, 42, 0.4);
  static Color expenseBorderColor = const Color.fromRGBO(241, 89, 42, 1);

  static Color dayHeaderContainerTextColorDark = const Color.fromRGBO(89, 181, 185, 100);
  static Color dayHeaderContainerTextColorLight = const Color.fromRGBO(0, 0, 0, 0.7);
  static Color dayHeaderContainerBackgroundColorDark = const Color.fromRGBO(48, 48, 48, 100);
  static Color dayHeaderContainerBackgroundColorLight = const Color.fromRGBO(114, 172, 175, 1);
  static Color dayHeaderContainerBorderColorDark = const Color.fromRGBO(71, 71, 71, 100);
  static Color dayHeaderContainerBorderColorLight = const Color.fromRGBO(125, 176, 178, 1);
  static Color dayHeaderDateTextColorDark = const Color.fromRGBO(72, 145, 148, 0.7);
  static Color dayHeaderDateTextColorLight = const Color.fromRGBO(0, 0, 0, 0.4);

  static Color iconColor1Dark = const Color.fromRGBO(255, 255, 255, 1);
  static Color iconColor1Light = const Color.fromARGB(255, 126, 126, 126);
  static Color deleteIconColor = const Color.fromRGBO(255, 0, 0, 1);

  static Color downArrowColor = const Color.fromRGBO(75, 181, 67, 1);
  static Color upArrowColor = const Color.fromRGBO(255, 0, 0, 1);

  static Color titleTextColorDark = const Color.fromRGBO(255, 255, 255, 1);
  static Color titleTextColorLight = const Color.fromRGBO(0, 0, 0, 0.8);
  static Color subtitleTextColorDark = const Color.fromRGBO(255, 255, 255, 0.6);
  static Color subtitleTextColorLight = const Color.fromRGBO(0, 0, 0, 0.4);

  static Color chartBarBorderColorDark = const Color.fromRGBO(0, 0, 0, 100);
  static Color chartBarBorderColorLight = const Color.fromRGBO(250, 250, 250, 1);
  static Color chartBarBackgroundColorDark = const Color.fromRGBO(61, 61, 61, 100);
  static Color chartBarBackgroundColorLight = const Color.fromRGBO(227, 227, 227, 1);

  static Color newTransactionIconColorDark = const Color.fromRGBO(255, 255, 255, 1);
  static Color newTransactionIconColorLight = const Color.fromARGB(255, 126, 126, 126);

  static Color newTransactionTextFieldColorDark = const Color.fromARGB(255, 33, 150, 243);
  static Color newTransactionTextFieldColorLight = const Color.fromARGB(255, 0, 0, 0);

  static Color canvasColorDark = const Color.fromRGBO(17, 17, 17, 1);
  static Color canvasColorLight = const Color.fromRGBO(250, 250, 250, 1);

  static Color fieldColorLight = const Color.fromRGBO(240, 240, 240, 1);

  static final List<Color> pieChartColors = [
    const Color(0xFFFF0000), // Red
    const Color(0xFFFFA500), // Orange
    const Color(0xFFFFFF00), // Yellow
    const Color(0xFF008000), // Green
    const Color(0xFF0000FF), // Blue
    const Color(0xFF800080), // Purple
    const Color(0xFFFFC0CB), // Pink
    const Color(0xFFA52A2A), // Brown
    const Color(0xFFFFFFFF), // White
    const Color(0xFF808080), // Gray
    const Color(0xFF00FFFF), // Cyan
    const Color(0xFFFF00FF), // Magenta
    const Color(0xFFE6E6FA), // Lavender
    const Color(0xFF000080), // Navy blue
    const Color(0xFF40E0D0), // Turquoise
    const Color(0xFF808000), // Olive green
    const Color(0xFF800000), // Maroon
    const Color(0xFFFF7F50), // Coral
    const Color(0xFFFFE5B4), // Peach
    const Color(0xFFFA8072), // Salmon
    const Color(0xFF87CEEB), // Sky blue
    const Color(0xFFD2B48C), // Tan
    const Color(0xFF008080), // Teal
    const Color(0xFFFF6347), // Tomato
    const Color(0xFFF5F5DC), // Beige
    const Color(0xFFCB4154), // Brick red
    const Color(0xFF800020), // Burgundy
    const Color(0xFF7B3F00), // Chocolate brown
    const Color(0xFF006400), // Dark green
    const Color(0xFF228B22), // Forest green
    const Color(0xFFFFD700), // Gold
    const Color(0xFFFF69B4), // Hot pink
    const Color(0xFF4B0082), // Indigo
    const Color(0xFFFFFFF0), // Ivory
    const Color(0xFFF0E68C), // Khaki
    const Color(0xFFADD8E6), // Light blue
    const Color(0xFFC8A2C8), // Lilac
    const Color(0xFF00FF00), // Lime green
    const Color(0xFF98FF98), // Mint green
    const Color(0xFFFFDB58), // Mustard yellow
    const Color(0xFF39FF14), // Neon green
    const Color(0xFF808000), // Olive
    const Color(0xFFDA70D6), // Orchid
    const Color(0xFFEEE8AA), // Pale yellow
    const Color(0xFFFF007F), // Rose
    const Color(0xFF8B3103), // Rust
    const Color(0xFF2E8B57), // Sea green
    const Color(0xFF6A5ACD), // Slate blue
    const Color(0xFF43464B), // Steel gray
  ];
}
