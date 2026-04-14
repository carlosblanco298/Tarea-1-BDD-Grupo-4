# README Tarea 1 BDD Grupo-4

## Información Curso:
**Nombre**: Bases de Datos
**Siglas**: IIC2413
**Sección**: 3
**Profesor**: Reutter Juan

## Integrantes:
+ Matthew Babbitt. N° Alumno: 25662953
+ Carlos Blanco. N° Alumno: 2566316J
+ Cristóbal Morales. N° Alumno: 25663933

## Cómo ejecutar la aplicación

### Prerrequisitos
- Python 3.x
- pip
- PostgreSQL

### Pasos
1. **Crear un entorno virtual:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # En Windows: venv\Scripts\activate
   ```
2. **Instalar dependencias:**
   No se ha encontrado un archivo `requirements.txt`. Asumiendo que las dependencias son `flask`, `psycopg2-binary` y `python-dotenv`, puedes instalarlas con:
   ```bash
   pip install flask psycopg2-binary python-dotenv
   ```
3. **Configurar la base de datos:**
    - Asegúrate de tener PostgreSQL instalado y corriendo.
    - Crea una base de datos para el proyecto.
    - Crea un archivo `.env` en la raíz del proyecto con la siguiente estructura, reemplazando los valores con tus credenciales:
      ```
      DB_HOST=localhost
      DB_PORT=5432
      DB_NAME=nombre_de_tu_bd
      DB_USER=tu_usuario
      DB_PASSWORD=tu_contraseña
      ```
4. **Poblar la base de datos:**
   Ejecuta los siguientes comandos para crear las tablas e insertar los datos iniciales:
   ```bash
   psql -U tu_usuario -d nombre_de_tu_bd -f schemas.sql
   psql -U tu_usuario -d nombre_de_tu_bd -f data.sql
   ```
5. **Ejecutar la aplicación:**
   ```bash
   python app/backend/src/server.py
   ```
6. Abre tu navegador y ve a `http://localhost:3000`.
