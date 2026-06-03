# IntelMQ Mailgen Contact

## Inicialización

Para inicializar el aplicativo, sólo debe de clonar el repositorio y posteriormente ejecutar el comando dentro de la carpeta en su máquina:

```powershell
docker compose -f docker-compose.exercise.yml up -d
```

Las credenciales de acceso creados para todos los aplicativos son:
```
username: admin
password: secret
```

Los aplicativos son los siguientes:
```
IntelMQ (creación de flujos): http://localhost:1380/intelmq-manager

Fody (gestión de correos): http://localhost:8080/
```

En caso de que no le acepte entrar a Fody, crea el usuario con el siguiente comando:
```powershell
docker exec intelmq-fody-backend /opt/intelmq-fody-backend/fody-adduser --user admin --password secret
```

Reglas de ejemplo para la selección del template del correo:
https://github.com/Intevation/intelmq-certbund-contact/tree/master/example-rules

En caso de querer eliminar el aplicativo, sólo debe de ejecutar el siguiente comando:

```powershell
docker compose -f docker-compose.exercise.yml down -v
```

