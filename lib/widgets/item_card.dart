import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.index});

  final int index;

  static const _books = [
    ('The Lost City', 'James Turner', 'Fiction', Color(0xFF5C6BC0), 4.5),
    ('Quantum Minds', 'Dr. Sara Patel', 'Science', Color(0xFF26A69A), 4.2),
    ('Ancient Worlds', 'M. Holloway', 'History', Color(0xFFEC407A), 4.8),
    ('Code & Create', 'Alex Chen', 'Technology', Color(0xFFFF7043), 3.9),
    ('The Art of Design', 'L. Fontaine', 'Arts', Color(0xFF8D6E63), 4.6),
    ('Ocean of Stars', 'N. Krishnan', 'Science', Color(0xFF42A5F5), 4.1),
  ];

  @override
  Widget build(BuildContext context) {
    final (title, author, genre, color, rating) =
        _books[index % _books.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 82,
            height: 120,
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white38,
              size: 36,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppConfig.accentColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      genre,
                      style: GoogleFonts.getFont(
                        AppConfig.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppConfig.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.getFont(
                      AppConfig.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1D2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    author,
                    style: GoogleFonts.getFont(
                      AppConfig.fontFamily,
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 16,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        rating.toString(),
                        style: GoogleFonts.getFont(
                          AppConfig.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConfig.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(68, 32),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'View',
                          style: GoogleFonts.getFont(
                            AppConfig.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
