import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const EventListScreen(),
    );
  }
}

class Event {
  final String title;
  final String date;
  final String imagePath;
  final double price;

  Event(this.title, this.date, this.imagePath, this.price);
}

List<Event> bookedEvents = [];

final List<Event> events = [
  Event(
    'Bring Your Cake',
    '2025-06-10',
    'assets/1.jpg', // local image
    10.0,
  ),
  Event(
    'Music Fiesta',
    '2025-06-20',
    'assets/2.jpg', // local image
    30.0,
  ),
  Event(
    'tech talk',
    '2025-30-10',
    'assets/3.jpeg', // local image
    20.0,
  ),
];

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event List')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  leading: Hero(
                    tag: event.title,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        event.imagePath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(event.title),
                  subtitle: Text("Date: ${event.date} | \$${event.price}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailScreen(event: event),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingConfirmationScreen(),
                    ),
                  );
                },
                child: const Text("Your Bookings"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Column(
        children: [
          Hero(
            tag: event.title,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                event.imagePath,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Date: ${event.date}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "Price: \$${event.price}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    bookedEvents.add(event);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${event.title} booked successfully!"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Book This Event"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double total = bookedEvents.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Bookings")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bookedEvents.length,
              itemBuilder: (context, index) {
                final e = bookedEvents[index];
                return ListTile(
                  title: Text(e.title),
                  subtitle: Text("Date: ${e.date} | \$${e.price}"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
