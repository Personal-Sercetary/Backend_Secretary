import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

// 1. Завантажуємо .env файл ОДИН РАЗ при старті сервера
final env = DotEnv(includePlatformEnvironment: true)..load();

// 2. Отримуємо ключі (використовуємо ! бо ми впевнені, що вони є в .env)
final supabaseUrl = env['SUPABASE_URL']!;
final supabaseKey = env['SUPABASE_SERVICE_ROLE_KEY']!;

// 3. Створюємо клієнт Supabase ОДИН РАЗ
final supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);

// 4. Мідлвар просто передає готовий клієнт у ваші маршрути
Handler middleware(Handler handler) {
  return handler.use(provider<SupabaseClient>((_) => supabaseClient));
}
