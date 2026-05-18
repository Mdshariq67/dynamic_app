import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';
import '../widgets/app_header.dart';
import 'listing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _categories = [
    ('All', Icons.grid_view_rounded),
    ('Fiction', Icons.auto_stories_rounded),
    ('Science', Icons.science_rounded),
    ('History', Icons.history_edu_rounded),
    ('Technology', Icons.computer_rounded),
    ('Arts', Icons.palette_rounded),
  ];

  static const _featured = [
    ('The Lost City', 'James Turner', 'Fiction', Color(0xFF5C6BC0)),
    ('Quantum Minds', 'Dr. Sara Patel', 'Science', Color(0xFF26A69A)),
    ('Ancient Worlds', 'M. Holloway', 'History', Color(0xFFEC407A)),
    ('Code & Create', 'Alex Chen', 'Technology', Color(0xFFFF7043)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: AppHeader()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SearchBar(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListingScreen()),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: Text(
                'Categories',
                style: GoogleFonts.getFont(
                  AppConfig.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1D2E),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final (label, icon) = _categories[i];
                  return _CategoryChip(
                    label: label,
                    icon: icon,
                    selected: i == 0,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Books',
                    style: GoogleFonts.getFont(
                      AppConfig.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1D2E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ListingScreen()),
                    ),
                    child: Text(
                      'See all →',
                      style: GoogleFonts.getFont(
                        AppConfig.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppConfig.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 204,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _featured.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, i) {
                  final (title, author, genre, color) = _featured[i];
                  return _FeaturedCard(
                    title: title,
                    author: author,
                    genre: genre,
                    color: color,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 36),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListingScreen()),
                ),
                icon: const Icon(Icons.menu_book_rounded),
                label: Text(
                  'Browse Full Collection',
                  style: GoogleFonts.getFont(
                    AppConfig.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
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
            Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 22),
            const SizedBox(width: 10),
            Text(
              'Search books, authors...',
              style: GoogleFonts.getFont(
                AppConfig.fontFamily,
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.icon,
    this.selected = false,
  });

  final String label;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppConfig.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          if (!selected)
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: selected ? Colors.white : AppConfig.primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.getFont(
              AppConfig.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppConfig.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({
    required this.title,
    required this.author,
    required this.genre,
    required this.color,
  });

  final String title;
  final String author;
  final String genre;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 142,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 118,
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(
              child: Icon(
                Icons.menu_book_rounded,
                color: Colors.white38,
                size: 46,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.getFont(
                    AppConfig.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1D2E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  author,
                  style: GoogleFonts.getFont(
                    AppConfig.fontFamily,
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppConfig.accentColor,
                    borderRadius: BorderRadius.circular(5),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
