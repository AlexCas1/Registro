import 'package:postgres/postgres.dart';

class DatabaseHelper {

  final String _host = 'ep-proud-sunset-aq28evwm-pooler.c-8.us-east-1.aws.neon.tech';
  final String _username = 'neondb_owner';
  final String _password = 'npg_Xfko4EjmuN1I';
  final String _database = 'neondb';

  //Funcion para obtener la conexion.
  Future<Connection> getConnection() async {

    return await Connection.open(
      Endpoint(
          host: _host,
          database: _database,
          username: _username,
          password: _password,
      ),

      settings: ConnectionSettings(
        sslMode: SslMode.require,
      ),

    );
  }

  Future<bool> registerUsers
      (String name, String email, String password) async {

    Connection? conn;

    try {
      conn = await getConnection();

      await conn.execute(
        Sql.named(
          "INSERT INTO users (name, email, password) VALUES (@name, @email, @password)"
        ),

        parameters: {
          'name': name,
          'email': email,
          'password': password,
        },

      );
      return true;
    } catch (e) {
      print('Error de base de datos: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }

}