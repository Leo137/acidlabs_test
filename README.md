# README

Aplicacion obtiene el clima de 6 ciudades utilizando la API de DarkSky y despliega la hora local y temperatura para cada una de ellas.

La informacion de las ciudades es almacenada en Redis, en la llave `cities`. Los campos rescatados por la API son guardados en llaves redis con el formato `cities/<lattitude>/<longitude>/<key>`. Los errores al consultar la api son guardadas en un hash llamado `api.errors`.

Para incluir mas ciudades, modificar  `config/initializers/city_configuration.rb` y reiniciar aplicación.