import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/notifications/notification_service.dart';

// Servicio de notificaciones
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final svc = NotificationService();
  svc.init();
  return svc;
});

// Contador de notificaciones usando Notifier
class BadgeCountNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }

  void reset() {
    state = 0;
  }
}

final badgeCountProvider = NotifierProvider<BadgeCountNotifier, int>(() {
  return BadgeCountNotifier();
});