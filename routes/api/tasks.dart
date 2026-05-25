import 'package:dart_frog/dart_frog.dart';
import 'package:supabase/supabase.dart' hide HttpMethod;

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final supabase = context.read<SupabaseClient>();

  // 1. Обробка GET-запиту (Читання списку)
  if (request.method == HttpMethod.get) {
    try {
      final data = await supabase.from('tasks').select();
      return Response.json(body: data);
    } catch (e) {
      return Response.json(statusCode: 500, body: {'error': 'Помилка: $e'});
    }
  }

  // 2. Обробка POST-запиту (Створення нової задачі)
  if (request.method == HttpMethod.post) {
    try {
      // Читаємо JSON, який ми відправимо з Postman
      final body = await request.json() as Map<String, dynamic>;

      // Записуємо дані в таблицю tasks
      final response = await supabase.from('tasks').insert({
        'titel': body['titel'],
        'description': body['description'],
        'duration': body['duration'],
        'execution_date': body['execution_date'],
        'task_profesion': body['task_profesion'] ?? false,
        'user_id': body['user_id'],
      }).select();

      // Віддаємо успішну відповідь
      return Response.json(body: response.first);
    } catch (e) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Помилка запису: $e'},
      );
    }
  }

  // Якщо метод інший (PUT, DELETE тощо)
  return Response.json(statusCode: 405, body: {'error': 'Method not allowed'});
}
