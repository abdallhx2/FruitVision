import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - الألوان الأساسية
  static const Color primaryDark = Color(0xFF294F15);   // أخضر داكن - للعناصر الرئيسية والشعار
  static const Color primaryLight = Color(0xFFC1D5A4);  // أخضر فاتح - للخلفيات والعناصر الثانوية
  static const Color accent = Color(0xFFAD252F);        // أحمر - للتنبيهات والأزرار المهمة
  
  // Background Colors - ألوان الخلفية
  static const Color background = Color(0xFFFAFAFA);    // خلفية فاتحة للتطبيق
  static const Color surface = Colors.white;            // خلفية العناصر
  static const Color surfaceLight = Color(0xFFF0F4EA);  // خلفية ثانوية بدرجة خفيفة من الأخضر
  
  // Text Colors - ألوان النصوص
  static const Color textPrimary = Color(0xFF294F15);   // نفس لون primaryDark للنصوص الرئيسية
  static const Color textSecondary = Color(0xFF6B8E4E);  // درجة أفتح للنصوص الثانوية
  static const Color textLight = Colors.white;          // للنصوص على الخلفيات الداكنة
  
  // Status Colors - ألوان الحالة
  static const Color success = Color(0xFF294F15);      // نجاح - أخضر داكن
  static const Color error = Color(0xFFAD252F);        // خطأ - أحمر
  static const Color warning = Color(0xFFC1D5A4);      // تحذير - أخضر فاتح
  
  // Ripeness Indicator Colors - مؤشرات النضج
  static const Color unripe = Color(0xFF294F15);       // غير ناضج - أخضر داكن
  static const Color ripe = Color(0xFFC1D5A4);         // ناضج - أخضر فاتح
  static const Color overripe = Color(0xFFAD252F);     // ناضج جداً - أحمر
  
  // Button Colors - ألوان الأزرار
  static const Color buttonPrimary = Color(0xFF294F15);    // الأزرار الرئيسية
  static const Color buttonSecondary = Color(0xFFC1D5A4);  // الأزرار الثانوية
  static const Color buttonAction = Color(0xFFAD252F);     // أزرار الإجراءات المهمة
}