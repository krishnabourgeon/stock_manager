// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;

// /// A text field that shows a live Malayalam translation below as you type.
// ///
// /// Usage:
// ///   MalayalamTranslatorField(
// ///     controller: _myController,
// ///     labelText: 'Product Name',
// ///     onTranslated: (mal) => setState(() => _malName = mal),
// ///   )
// class MalayalamTranslatorField extends StatefulWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final String? hintText;
//   final Function(String malayalam)? onTranslated;
//   final String? Function(String?)? validator;
//   final int maxLines;

//   const MalayalamTranslatorField({
//     super.key,
//     required this.controller,
//     required this.labelText,
//     this.hintText,
//     this.onTranslated,
//     this.validator,
//     this.maxLines = 1,
//   });

//   @override
//   State<MalayalamTranslatorField> createState() =>
//       _MalayalamTranslatorFieldState();
// }

// class _MalayalamTranslatorFieldState extends State<MalayalamTranslatorField> {

//   String _translatedText = '';
//   bool _isModelReady = false;
//   bool _isDownloading = false;
//   bool _isTranslating = false;
//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//     _initTranslator();
//     widget.controller.addListener(_onTextChanged);
//   }

//   Future<void> _initTranslator() async {
//   setState(() => _isModelReady = true);
//   if (widget.controller.text.isNotEmpty) {
//     _translate(widget.controller.text);
//   }
// }

//   void _onTextChanged() {
//     final text = widget.controller.text.trim();
//     if (text.isEmpty) {
//       setState(() => _translatedText = '');
//       widget.onTranslated?.call('');
//       return;
//     }
//     // Debounce — wait 600ms after typing stops
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 600), () {
//       _translate(text);
//     });
//   }


// // Replace _translate:
// Future<void> _translate(String text) async {
//   if (text.isEmpty) return;
//   setState(() => _isTranslating = true);
//   try {
//     // MyMemory free API — no key needed, 1000 words/day free
//     final uri = Uri.parse(
//       'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(text)}&langpair=en|ml',
//     );
//     final res = await http.get(uri).timeout(const Duration(seconds: 5));
//     if (res.statusCode == 200) {
//       final json = jsonDecode(res.body);
//       final translated = json['responseData']['translatedText'] as String;
//       if (mounted) {
//         setState(() => _translatedText = translated);
//         widget.onTranslated?.call(translated);
//       }
//     }
//   } catch (e) {
//     debugPrint('Translation error: $e');
//   } finally {
//     if (mounted) setState(() => _isTranslating = false);
//   }
// }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     widget.controller.removeListener(_onTextChanged);

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ── Main text field ──────────────────────────────────────────────
//         TextFormField(
//           controller: widget.controller,
//           maxLines: widget.maxLines,
//           decoration: InputDecoration(
//             labelText: widget.labelText,
//             hintText: widget.hintText,
//             border: const OutlineInputBorder(),
//             suffixIcon: _isDownloading
//                 ? Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: SizedBox(
//                       width: 18,
//                       height: 18,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: Colors.orange.shade600,
//                       ),
//                     ),
//                   )
//                 : _isTranslating
//                     ? Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Colors.blue.shade400,
//                           ),
//                         ),
//                       )
//                     : null,
//           ),
//           validator: widget.validator,
//         ),

//         // ── Malayalam translation preview ────────────────────────────────
//         if (_isDownloading) ...[
//           6.verticalSpace,
//           Row(
//             children: [
//               Icon(Icons.download_rounded,
//                   size: 14, color: Colors.orange.shade600),
//               6.horizontalSpace,
//               Text(
//                 'Downloading Malayalam language model...',
//                 style: TextStyle(
//                   fontSize: 11.sp,
//                   color: Colors.orange.shade700,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//         ] else if (_translatedText.isNotEmpty) ...[
//           6.verticalSpace,
//           Container(
//             width: double.infinity,
//             padding:
//                 EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.blue.shade200),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Malayalam 'മ' icon label
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade700,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Text(
//                     'മ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 11.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 8.horizontalSpace,
//                 Expanded(
//                   child: Text(
//                     _translatedText,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.blue.shade900,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 // Copy button
//                 GestureDetector(
//                   onTap: () {
//                     Clipboard.setData(
//                         ClipboardData(text: _translatedText));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: const Text('Malayalam text copied'),
//                         duration: const Duration(seconds: 1),
//                         behavior: SnackBarBehavior.floating,
//                         backgroundColor: Colors.blue.shade700,
//                       ),
//                     );
//                   },
//                   child: Icon(
//                     Icons.copy_rounded,
//                     size: 16,
//                     color: Colors.blue.shade400,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

/// A text field that shows a live Malayalam transliteration below as you type.
///
/// Typing Manglish (English phonetic) → gets converted to Malayalam script.
/// e.g. "mango" → "മാങ്ങ", "veedu" → "വീട്"
///
/// Uses Google's free Inputtools transliteration endpoint (no API key needed).
///
/// Usage:
///   MalayalamTranslatorField(
///     controller: _myController,
///     labelText: 'Product Name',
///     onTranslated: (mal) => setState(() => _malName = mal),
///   )
class MalayalamTranslatorField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final Function(String malayalam)? onTranslated;
  final String? Function(String?)? validator;
  final int maxLines;

  const MalayalamTranslatorField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.onTranslated,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<MalayalamTranslatorField> createState() =>
      _MalayalamTranslatorFieldState();
}

class _MalayalamTranslatorFieldState extends State<MalayalamTranslatorField> {
  String _translatedText = '';
  bool _isTranslating = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    if (widget.controller.text.isNotEmpty) {
      _transliterate(widget.controller.text);
    }
  }

  void _onTextChanged() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) {
      setState(() => _translatedText = '');
      widget.onTranslated?.call('');
      return;
    }
    // Debounce — wait 500ms after typing stops
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _transliterate(text);
    });
  }

  /// Converts Manglish (phonetic English) → Malayalam script
  /// using Google Inputtools transliteration.
  ///
  /// API endpoint:
  /// https://inputtools.google.com/request?text=mango&itc=ml-t-i0-und&num=1
  /// Response: ["SUCCESS", [["mango", ["മാങ്ങ", ...], ...]]]
  Future<void> _transliterate(String text) async {
    if (text.isEmpty) return;

    // Transliterate the full phrase in one API call for multi-word inputs
    setState(() => _isTranslating = true);
    try {
      final uri = Uri.parse(
        'https://inputtools.google.com/request'
        '?text=${Uri.encodeComponent(text.trim())}'
        '&itc=ml-t-i0-und' // ml = Malayalam, t = transliteration
        '&num=1'
        '&cp=0&cs=1'
        '&ie=utf-8&oe=utf-8',
      );

      final res = await http.get(uri).timeout(const Duration(seconds: 5));

      if (res.statusCode == 200) {
        final dynamic json = jsonDecode(res.body);
        // Response: ["SUCCESS", [["mango", ["മാങ്ങ"], {}, []]]]
        if (json is List &&
            json.length >= 2 &&
            json[0] == 'SUCCESS' &&
            json[1] is List &&
            (json[1] as List).isNotEmpty) {
          final firstEntry = (json[1] as List)[0];
          if (firstEntry is List &&
              firstEntry.length >= 2 &&
              firstEntry[1] is List &&
              (firstEntry[1] as List).isNotEmpty) {
            final result = firstEntry[1][0] as String;
            if (mounted) {
              setState(() => _translatedText = result);
              widget.onTranslated?.call(result);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Transliteration error: $e');
    } finally {
      if (mounted) setState(() => _isTranslating = false);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Main text field ──────────────────────────────────────────────
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText ?? 'Type in Manglish (e.g. mango, veedu)',
            border: const OutlineInputBorder(),
            suffixIcon: _isTranslating
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blue.shade400,
                      ),
                    ),
                  )
                : null,
          ),
          validator: widget.validator,
        ),

        // ── Malayalam transliteration preview ───────────────────────────
        if (_translatedText.isNotEmpty) ...[
          6.verticalSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Malayalam 'മ' icon label
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'മ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    _translatedText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Copy button
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: _translatedText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Malayalam text copied'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.blue.shade700,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.copy_rounded,
                    size: 16,
                    color: Colors.blue.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}


