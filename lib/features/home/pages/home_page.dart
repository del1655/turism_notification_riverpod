import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const destinos = [
    {'nombre': 'Cancún', 'tipo': 'Playa'},
    {'nombre': 'Tulum', 'tipo': 'Zona arqueológica'},
    {'nombre': 'Bacalar', 'tipo': 'Laguna'},
    {'nombre': 'Isla Mujeres', 'tipo': 'Isla'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badge = ref.watch(badgeCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Destinos ($badge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () async {
              await ref.read(notificationServiceProvider).showLocal(
                title: 'Novedad turística',
                body: 'Nueva promo en Quintana Roo 🌴',
                payload: '/promo',
              );
              ref.read(badgeCountProvider.notifier).state++;
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF0F5), // rosa clarito
              Color(0xFFFFF8E0), // amarillo pastel
              Color(0xFFE6E0FF), // lila pastel
              Color(0xFFFFE6CC), // naranja pastel
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: destinos.length,
          itemBuilder: (_, i) {
            final d = destinos[i];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () async {
                  await ref.read(notificationServiceProvider).showLocal(
                    title: 'Explora ${d['nombre']}',
                    body: 'Descubre ${d['nombre']} (${d['tipo']})',
                    payload: '/destino/${d['nombre']}',
                  );
                  ref.read(badgeCountProvider.notifier).state++;
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1.5,
                        ),
                        boxShadow: [
                          // Sombra principal
                          BoxShadow(
                            color: Colors.purpleAccent.withOpacity(0.25),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                          // Sombra secundaria más clara para profundidad
                          BoxShadow(
                            color: Colors.purpleAccent.withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Icon(Icons.place, color: Color(0xFF7B4BFF), size: 36),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d['nombre']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A2EA6),
                                ),
                              ),
                              Text(
                                d['tipo']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF7B4BFF),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
