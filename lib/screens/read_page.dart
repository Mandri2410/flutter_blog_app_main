import 'package:flutter/material.dart';
import '../models/book.dart'; // Import model untuk Book dan Chapter

class ReadPage extends StatelessWidget {
  final List<Chapter> chapters;
  final int currentChapterIndex;
  final String author;
  final String coverUrl; // Tambahkan parameter untuk URL gambar buku

  const ReadPage({
    Key? key,
    required this.chapters,
    required this.currentChapterIndex,
    required this.author,
    required this.coverUrl, // Wajib diberikan saat memanggil halaman
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChapter = chapters[currentChapterIndex];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(currentChapter.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_size),
            onPressed: () {
              // Implement font size adjustment
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Implement additional options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tambahkan gambar buku
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  coverUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16), // Jarak antara gambar dan judul
            Text(
              currentChapter.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Author: $author",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Reads: ${currentChapter.reads}, Votes: ${currentChapter.votes}",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              currentChapter.content,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: currentChapterIndex > 0
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadPage(
                              chapters: chapters,
                              currentChapterIndex: currentChapterIndex - 1,
                              author: author,
                              coverUrl: coverUrl,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
              Text(
                'Chapter ${currentChapter.number} of ${chapters.length}',
                style: TextStyle(color: Colors.grey[400]),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.white,
                onPressed: currentChapterIndex < chapters.length - 1
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadPage(
                              chapters: chapters,
                              currentChapterIndex: currentChapterIndex + 1,
                              author: author,
                              coverUrl: coverUrl,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
