import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_tumor/constant/colorclass.dart';

class TumorDetailScreen extends StatefulWidget {
  final String tumorType;
  final double confidence;

  const TumorDetailScreen({required this.tumorType, required this.confidence});

  @override
  _TumorDetailScreenState createState() => _TumorDetailScreenState();
}

class _TumorDetailScreenState extends State<TumorDetailScreen> {
  late String randomImage;

  final Map<String, Map<String, dynamic>> tumorData = {
    'glioma': {
      'medicine': 'Temozolomide (chemotherapy), Bevacizumab (anti-angiogenic)',
      'suggestion': 'Regular MRI follow-ups, neurosurgeon visits, and possible surgical resection followed by radiotherapy.',
      'exercise': 'Gentle stretching, walking 20–30 mins daily, and guided breathing to reduce fatigue.',
      'images': [
        'https://example.com/glioma_1.jpg',
        'https://example.com/glioma_2.jpg',
        'https://example.com/glioma_3.jpg',
      ]
    },
    'meningioma': {
      'medicine': 'Dexamethasone (for swelling), Levetiracetam (seizure control)',
      'suggestion': 'Monitor with MRI every 6–12 months, consult neuro-oncologist, consider Gamma Knife radiosurgery.',
      'exercise': 'Mild neck stretches, balance exercises, and chair yoga under supervision.',
      'images': [
        'https://example.com/meningioma_1.jpg',
        'https://example.com/meningioma_2.jpg',
        'https://example.com/meningioma_3.jpg',
      ]
    },
    'notumor': {
      'medicine': 'No medication needed.',
      'suggestion': 'You are healthy. Maintain a balanced diet and stay active. Annual checkups are recommended.',
      'exercise': 'Cardio (jogging, brisk walking), strength training, and yoga.',
      'images': [
        'https://example.com/healthy_1.jpg',
        'https://example.com/healthy_2.jpg',
      ]
    },
    'pituitary': {
      'medicine': 'Cabergoline (dopamine agonist), Hormone replacement therapy (if needed)',
      'suggestion': 'Endocrinologist consultation every 3 months, monitor hormone levels, possible surgery if tumor enlarges.',
      'exercise': 'Low-impact exercises like yoga, pilates, and swimming are ideal for hormonal balance.',
      'images': [
        'https://example.com/pituitary_1.jpg',
        'https://example.com/pituitary_2.jpg',
        'https://example.com/pituitary_3.jpg',
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    final tumorTypeLower = widget.tumorType.toLowerCase();
    final imageList = tumorData[tumorTypeLower]?['images'] ?? [];
    if (imageList.isNotEmpty) {
      randomImage = imageList[Random().nextInt(imageList.length)];
    } else {
      randomImage = 'https://example.com/default.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tumorTypeLower = widget.tumorType.toLowerCase();
    final data = tumorData[tumorTypeLower] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tumor Details'),
        backgroundColor: MyColors.theme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: data.isEmpty
            ? const Center(
          child: Text("Invalid tumor type", style: TextStyle(fontSize: 18)),
        )
            : widget.confidence < 60
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 60),
              SizedBox(height: 16),
              Text(
                'Prediction confidence is too low.\nPlease upload a clearer image.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tumor Type: ${widget.tumorType[0].toUpperCase()}${widget.tumorType.substring(1)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Confidence: ${widget.confidence.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    randomImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Text("Image failed to load"),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildInfoCard(
                title: 'Recommended Medicine',
                icon: Icons.medication,
                content: data['medicine'],
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'Doctor Suggestion',
                icon: Icons.health_and_safety_outlined,
                content: data['suggestion'],
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'Exercise Advice',
                icon: Icons.fitness_center,
                content: data['exercise'],
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required String? content,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color)),
                  const SizedBox(height: 8),
                  Text(
                    content ?? "No data available.",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
