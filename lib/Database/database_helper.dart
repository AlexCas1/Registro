import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  // Configura tus credenciales de MySQL Workbench aquí
  final String _host = 'localhost'; // Usa '10.0.2.2' si usas emulador Android
  final int _port = 3306;
  final String _user = 'root'; // Tu usuario de MySQL
  final String _password = 'tu_password'; // Tu contraseña de MySQL
  final String _db = 'tu_base_de_datos'; // El nombre del schema en Workbench

  Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _password,
      db: _db,
    );
    return await MySqlConnection.connect(settings);
  }

  Future<bool> registrarUsuario(String nombre, String correo, String password) async {
    MySqlConnection? conn;
    try {
      conn = await getConnection();
      // Asegúrate de tener una tabla 'usuarios' con columnas: nombre, correo, password
      var result = await conn.query(
        'INSERT INTO usuarios (nombre, correo, password) VALUES (?, ?, ?)',
        [nombre, correo, password],
      );
      return result.insertId != null;
    } catch (e) {
      print('Error de base de datos: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
}