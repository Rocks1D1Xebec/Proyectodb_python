from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from mysql.connector import Error
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import date, datetime
from decimal import Decimal
import json

app = Flask(__name__)
app.secret_key = 'tu_clave_secreta_super_segura'

# Configuración de la base de datos
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'tienda_videojuegos'
}

def get_db_connection():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        if conn.is_connected():
            return conn
    except Error as e:
        print(f"Error conectando a la base de datos: {e}")
        return None

@app.route('/')
def index():
    if 'usuario_id' in session:
        return redirect(url_for('dashboard'))
    return render_template('index.html')

@app.route('/registro', methods=['POST'])
def registro():
    if request.method == 'POST':
        # Datos comunes
        correo = request.form['correo']
        password = request.form['password']
        tipo_cuenta = request.form['tipo_cuenta']
        
        if tipo_cuenta == 'administrador':
            flash('No se puede registrar un administrador públicamente.', 'danger')
            return redirect(url_for('index'))
            
        # Validar si el correo ya existe
        conn = get_db_connection()
        if not conn:
            flash('Error de conexión a la base de datos.', 'danger')
            return redirect(url_for('index'))
            
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id_cuenta FROM cuenta WHERE correo = %s", (correo,))
        if cursor.fetchone():
            flash('El correo ya está registrado.', 'danger')
            conn.close()
            return redirect(url_for('index'))
            
        # Hash de la contraseña
        hashed_password = generate_password_hash(password)
        fecha_actual = date.today()
        
        try:
            # Todas las cuentas se crean como activas, los devs dependen de la tabla desarrollador para publicar
            estado_inicial = 'activo'
            
            # 1. Insertar en tabla 'cuenta'
            cursor.execute(
                "INSERT INTO cuenta (correo, contraseña, fecha_registro, estado, tipo_cuenta) VALUES (%s, %s, %s, %s, %s)",
                (correo, hashed_password, fecha_actual, estado_inicial, tipo_cuenta)
            )
            id_cuenta = cursor.lastrowid
            
            # 2. Insertar en tabla específica según el tipo
            if tipo_cuenta == 'usuario':
                nombre_usuario = request.form['nombre_usuario']
                nombre = request.form['nombre']
                apellido = request.form['apellido']
                fecha_nacimiento = request.form['fecha_nacimiento']
                pais = request.form['pais']
                saldo_inicial = 0.00
                
                cursor.execute(
                    "INSERT INTO usuario (id_cuenta, nombre_usuario, nombre, apellido, fecha_nacimiento, pais, saldo_billetera) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                    (id_cuenta, nombre_usuario, nombre, apellido, fecha_nacimiento, pais, saldo_inicial)
                )
            elif tipo_cuenta == 'desarrollador':
                nombre_estudio = request.form['nombre_estudio']
                pais_dev = request.form['pais_dev']
                sitio_web = request.form.get('sitio_web', '')
                
                cursor.execute(
                    "INSERT INTO desarrollador (id_cuenta, nombre_estudio, pais, sitio_web, autorizado) VALUES (%s, %s, %s, %s, 0)",
                    (id_cuenta, nombre_estudio, pais_dev, sitio_web)
                )
                cursor.execute(
                    "INSERT INTO solicitud_autorizacion (id_cuenta_dev, fecha_solicitud, estado) VALUES (%s, %s, 'pendiente')",
                    (id_cuenta, fecha_actual)
                )
            
            conn.commit()
            flash('Registro exitoso. ¡Ahora puedes iniciar sesión!', 'success')
            
        except Error as e:
            conn.rollback()
            flash(f'Error en el registro: {e}', 'danger')
        finally:
            cursor.close()
            conn.close()
            
        return redirect(url_for('index'))

@app.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        correo = request.form['correo']
        password = request.form['password']
        
        conn = get_db_connection()
        if not conn:
            flash('Error de conexión a la base de datos.', 'danger')
            return redirect(url_for('index'))
            
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM cuenta WHERE correo = %s", (correo,))
        cuenta = cursor.fetchone()
        
        if cuenta and check_password_hash(cuenta['contraseña'], password):
            # Verificar si la cuenta está activa
            if cuenta['estado'] != 'activo':
                flash(f'Tu cuenta está {cuenta["estado"]}. Contacta al soporte técnico.', 'danger')
                return redirect(url_for('index'))
                
            session['usuario_id'] = cuenta['id_cuenta']
            session['tipo_cuenta'] = cuenta['tipo_cuenta']
            session['correo'] = cuenta['correo']
            return redirect(url_for('dashboard'))
        else:
            flash('Correo o contraseña incorrectos.', 'danger')
            
        cursor.close()
        conn.close()
        
    return redirect(url_for('index'))

@app.route('/dashboard')
def dashboard():
    if 'usuario_id' not in session:
        return redirect(url_for('index'))
    
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    if session['tipo_cuenta'] == 'usuario':
        cursor.execute("SELECT nombre, nombre_usuario, saldo_billetera FROM usuario WHERE id_cuenta = %s", (session['usuario_id'],))
        datos = cursor.fetchone()
        
        # Obtener todas las categorías
        cursor.execute("SELECT * FROM categoria ORDER BY nombre ASC")
        todas_las_categorias = cursor.fetchall()
        
        # Obtener juegos de la tienda que el usuario NO tenga todavía
        cursor.execute("""
            SELECT v.id_juego, v.titulo, v.descripcion, v.precio_base, v.fecha_lanzamiento, 
                   v.estado_publicacion, v.portada_url, v.tamaño_gb, v.motivo_rechazo, v.fecha_solicitud,
                   GROUP_CONCAT(c.nombre SEPARATOR ', ') as categorias
            FROM videojuego v
            LEFT JOIN videojuego_categoria vc ON v.id_juego = vc.id_juego
            LEFT JOIN categoria c ON vc.id_categoria = c.id_categoria
            WHERE v.estado_publicacion = 'publicado' 
            AND v.id_juego NOT IN (SELECT id_juego FROM biblioteca WHERE id_cuenta_usuario = %s)
            GROUP BY v.id_juego
        """, (session['usuario_id'],))
        juegos_tienda = cursor.fetchall()

        # Formatear fechas en Python para evitar conflictos con el símbolo % en SQL
        for juego in juegos_tienda:
            if juego['fecha_lanzamiento']:
                juego['fecha_lanzamiento'] = juego['fecha_lanzamiento'].strftime('%Y-%m-%d')
            if juego['fecha_solicitud']:
                juego['fecha_solicitud'] = juego['fecha_solicitud'].strftime('%Y-%m-%d %H:%M:%S')
            # También convertimos DECIMAL a float para evitar errores de JSON
            juego['precio_base'] = float(juego['precio_base'])
            juego['tamaño_gb'] = float(juego['tamaño_gb'])

        # Obtener requisitos de hardware para estos juegos
        cursor.execute("""
            SELECT * FROM requisitos_hardware 
            WHERE id_juego IN (SELECT id_juego FROM videojuego WHERE estado_publicacion = 'publicado')
        """)
        requisitos = cursor.fetchall()

        # Obtener todas las reseñas de los juegos publicados
        cursor.execute("""
            SELECT r.id_juego, r.calificacion, r.comentario, r.fecha, u.nombre_usuario 
            FROM reseña r
            JOIN usuario u ON r.id_cuenta_usuario = u.id_cuenta
        """)
        resenas = cursor.fetchall()
        
        # Formatear la fecha de las reseñas en Python
        for r in resenas:
            if r['fecha']:
                r['fecha'] = r['fecha'].strftime('%Y-%m-%d')
        
        # Obtener juegos de la biblioteca del usuario con sus categorías
        cursor.execute("""
            SELECT v.id_juego, v.titulo, v.descripcion, v.precio_base, v.fecha_lanzamiento, 
                   v.portada_url, v.tamaño_gb, b.fecha_agregado,
                   GROUP_CONCAT(c.nombre SEPARATOR ', ') as categorias
            FROM biblioteca b 
            JOIN videojuego v ON b.id_juego = v.id_juego 
            LEFT JOIN videojuego_categoria vc ON v.id_juego = vc.id_juego
            LEFT JOIN categoria c ON vc.id_categoria = c.id_categoria
            WHERE b.id_cuenta_usuario = %s
            GROUP BY v.id_juego, b.fecha_agregado
        """, (session['usuario_id'],))
        mis_juegos = cursor.fetchall()

        # Formatear datos de mis_juegos para JSON
        for juego in mis_juegos:
            if juego['fecha_lanzamiento']:
                juego['fecha_lanzamiento'] = juego['fecha_lanzamiento'].strftime('%Y-%m-%d')
            if juego['fecha_agregado']:
                juego['fecha_agregado'] = juego['fecha_agregado'].strftime('%Y-%m-%d')
            juego['precio_base'] = float(juego['precio_base'])
            juego['tamaño_gb'] = float(juego['tamaño_gb'])
        
        cursor.close()
        conn.close()
        return render_template('user_dashboard.html', 
                             datos=datos, 
                             juegos_tienda=juegos_tienda, 
                             mis_juegos=mis_juegos, 
                             requisitos=requisitos,
                             resenas=resenas,
                             categorias=todas_las_categorias)
        
    elif session['tipo_cuenta'] == 'desarrollador':
        cursor.execute("SELECT nombre_estudio, autorizado FROM desarrollador WHERE id_cuenta = %s", (session['usuario_id'],))
        datos = cursor.fetchone()
        
        # Obtener todas las categorías para el formulario
        cursor.execute("SELECT * FROM categoria ORDER BY nombre ASC")
        todas_las_categorias = cursor.fetchall()
        
        # Obtener juegos donde el usuario es principal O colaborador
        cursor.execute("""
            SELECT v.*, dv.rol 
            FROM videojuego v
            JOIN desarrollador_videojuego dv ON v.id_juego = dv.id_juego
            WHERE dv.id_cuenta_dev = %s
            ORDER BY v.fecha_solicitud DESC
        """, (session['usuario_id'],))
        mis_juegos = cursor.fetchall()
        
        cursor.close()
        conn.close()
        return render_template('dev_dashboard.html', datos=datos, mis_juegos=mis_juegos, categorias=todas_las_categorias)
        
    elif session['tipo_cuenta'] == 'administrador':
        cursor.execute("SELECT nombre_completo, nivel_acceso FROM administrador WHERE id_cuenta = %s", (session['usuario_id'],))
        datos = cursor.fetchone()
        
        # Obtener todas las categorías
        cursor.execute("SELECT * FROM categoria ORDER BY nombre ASC")
        todas_las_categorias = cursor.fetchall()
        
        # 1. Solicitudes de desarrolladores pendientes
        cursor.execute("""
            SELECT s.id_solicitud, d.nombre_estudio, d.pais, s.fecha_solicitud 
            FROM solicitud_autorizacion s 
            JOIN desarrollador d ON s.id_cuenta_dev = d.id_cuenta 
            WHERE s.estado = 'pendiente'
        """)
        devs_pendientes = cursor.fetchall()
        
        # 2. Juegos pendientes de revisión
        cursor.execute("SELECT * FROM videojuego WHERE estado_publicacion = 'pendiente'")
        juegos_pendientes = cursor.fetchall()

        # 3. Catálogo completo de juegos (para gestión)
        cursor.execute("SELECT * FROM videojuego ORDER BY fecha_solicitud DESC")
        todos_los_juegos = cursor.fetchall()

        # 4. Gestión de todas las cuentas (Usuarios y Devs)
        cursor.execute("""
            SELECT c.id_cuenta, c.correo, c.tipo_cuenta, c.estado, 
                   COALESCE(u.nombre_usuario, d.nombre_estudio) as nombre_identificador
            FROM cuenta c
            LEFT JOIN usuario u ON c.id_cuenta = u.id_cuenta
            LEFT JOIN desarrollador d ON c.id_cuenta = d.id_cuenta
            WHERE c.tipo_cuenta != 'administrador'
        """)
        todas_las_cuentas = cursor.fetchall()
        
        # 5. Obtener todos los administradores
        cursor.execute("""
            SELECT c.id_cuenta, c.correo, c.estado, a.nombre_completo, a.nivel_acceso
            FROM cuenta c
            JOIN administrador a ON c.id_cuenta = a.id_cuenta
        """)
        todos_los_admins = cursor.fetchall()
        
        cursor.close()
        conn.close()
        return render_template('admin_dashboard.html', 
                             datos=datos, 
                             devs_pendientes=devs_pendientes, 
                             juegos_pendientes=juegos_pendientes,
                             todos_los_juegos=todos_los_juegos,
                             todas_las_cuentas=todas_las_cuentas,
                             todos_los_admins=todos_los_admins,
                             categorias=todas_las_categorias)

@app.route('/admin/crear_categoria', methods=['POST'])
def admin_crear_categoria():
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    nombre_categoria = request.form.get('nombre')
    if not nombre_categoria:
        return redirect(url_for('dashboard'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO categoria (nombre) VALUES (%s)", (nombre_categoria,))
        conn.commit()
        flash(f'Categoría "{nombre_categoria}" creada con éxito.', 'success')
    except Error as e:
        conn.rollback()
        flash('Error al crear la categoría. (¿Ya existe?)', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/crear_admin', methods=['POST'])
def admin_crear_admin():
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    correo = request.form.get('correo')
    password = request.form.get('password')
    nombre_completo = request.form.get('nombre_completo')
    
    if not correo or not password or not nombre_completo:
        flash('Faltan datos para crear el administrador.', 'danger')
        return redirect(url_for('dashboard'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Verificar si existe el correo
        cursor.execute("SELECT id_cuenta FROM cuenta WHERE correo = %s", (correo,))
        if cursor.fetchone():
            flash('El correo ya está en uso.', 'danger')
        else:
            hashed_password = generate_password_hash(password)
            # 1. Insertar en cuenta
            cursor.execute(
                "INSERT INTO cuenta (correo, contraseña, fecha_registro, estado, tipo_cuenta) VALUES (%s, %s, CURDATE(), 'activo', 'administrador')",
                (correo, hashed_password)
            )
            id_cuenta = cursor.lastrowid
            
            # 2. Insertar en administrador
            cursor.execute(
                "INSERT INTO administrador (id_cuenta, nombre_completo, nivel_acceso) VALUES (%s, %s, 1)",
                (id_cuenta, nombre_completo)
            )
            conn.commit()
            flash('Nuevo administrador creado con éxito.', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error al crear administrador: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/cambiar_estado_cuenta/<int:id_cuenta>', methods=['POST'])
def admin_cambiar_estado_cuenta(id_cuenta):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    nuevo_estado = request.form.get('estado')
    if nuevo_estado not in ['activo', 'suspendido']:
        flash('Estado no válido.', 'danger')
        return redirect(url_for('dashboard'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("UPDATE cuenta SET estado = %s WHERE id_cuenta = %s", (nuevo_estado, id_cuenta))
        conn.commit()
        flash(f'La cuenta #{id_cuenta} ahora está {nuevo_estado}.', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error al cambiar estado: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/retirar_juego/<int:id_juego>', methods=['POST'])
def admin_retirar_juego(id_juego):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    motivo = request.form.get('motivo', 'Incumplimiento de términos de servicio.')
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("UPDATE videojuego SET estado_publicacion = 'retirado', motivo_rechazo = %s WHERE id_juego = %s", (motivo, id_juego))
        conn.commit()
        flash('El videojuego ha sido retirado de la tienda.', 'danger')
    except Error as e:
        conn.rollback()
        flash(f'Error al retirar: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/aprobar_dev/<int:id_solicitud>', methods=['POST'])
def admin_aprobar_dev(id_solicitud):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Obtener el id_cuenta_dev
        cursor.execute("SELECT id_cuenta_dev FROM solicitud_autorizacion WHERE id_solicitud = %s", (id_solicitud,))
        solicitud = cursor.fetchone()
        
        if solicitud:
            id_dev = solicitud[0]
            # 1. Actualizar solicitud
            cursor.execute("UPDATE solicitud_autorizacion SET estado = 'aprobada', fecha_resolucion = CURDATE(), id_cuenta_admin = %s WHERE id_solicitud = %s", (session['usuario_id'], id_solicitud))
            # 2. Actualizar cuenta a activo
            cursor.execute("UPDATE cuenta SET estado = 'activo' WHERE id_cuenta = %s", (id_dev,))
            # 3. Actualizar desarrollador a autorizado
            cursor.execute("UPDATE desarrollador SET autorizado = 1, fecha_autorizacion = CURDATE() WHERE id_cuenta = %s", (id_dev,))
            
            conn.commit()
            flash('Desarrollador aprobado y cuenta activada exitosamente.', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error al aprobar: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/rechazar_dev/<int:id_solicitud>', methods=['POST'])
def admin_rechazar_dev(id_solicitud):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("UPDATE solicitud_autorizacion SET estado = 'rechazada', fecha_resolucion = CURDATE(), id_cuenta_admin = %s, motivo_rechazo = 'Rechazado por el administrador' WHERE id_solicitud = %s", (session['usuario_id'], id_solicitud))
        conn.commit()
        flash('Solicitud de desarrollador rechazada.', 'warning')
    except Error as e:
        conn.rollback()
        flash(f'Error al rechazar: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/aprobar_juego/<int:id_juego>', methods=['POST'])
def admin_aprobar_juego(id_juego):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("UPDATE videojuego SET estado_publicacion = 'publicado', fecha_lanzamiento = CURDATE() WHERE id_juego = %s", (id_juego,))
        conn.commit()
        flash('Juego aprobado y publicado en la tienda exitosamente.', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error al aprobar: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/rechazar_juego/<int:id_juego>', methods=['POST'])
def admin_rechazar_juego(id_juego):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return redirect(url_for('index'))
        
    motivo = request.form.get('motivo', 'No se especificó un motivo.')
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("UPDATE videojuego SET estado_publicacion = 'rechazado', motivo_rechazo = %s WHERE id_juego = %s", (motivo, id_juego))
        conn.commit()
        flash('Juego rechazado y notificación enviada al desarrollador.', 'warning')
    except Error as e:
        conn.rollback()
        flash(f'Error al rechazar: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/admin/ejecutar_sql', methods=['POST'])
def admin_ejecutar_sql():
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'administrador':
        return {"error": "No autorizado"}, 403
    
    data = request.get_json()
    query = data.get('query')
    
    if not query:
        return {"error": "Consulta vacía"}, 400
        
    conn = get_db_connection()
    if not conn:
        return {"error": "Error de conexión a la base de datos"}, 500
        
    cursor = conn.cursor(dictionary=True)
    try:
        # Intentar ejecutar la consulta
        # Nota: mysql-connector no soporta múltiples sentencias por defecto en execute()
        # pero para una consola simple está bien.
        cursor.execute(query)
        
        # Verificar si la consulta devuelve resultados (SELECT, SHOW, etc)
        is_select = query.strip().upper().startswith(('SELECT', 'SHOW', 'DESCRIBE', 'EXPLAIN'))
        
        if is_select:
            results = cursor.fetchall()
            # Serializar tipos no compatibles con JSON
            for row in results:
                for key, value in row.items():
                    if isinstance(value, (date, datetime)):
                        row[key] = value.isoformat()
                    elif isinstance(value, Decimal):
                        row[key] = float(value)
            
            return {
                "success": True, 
                "type": "select", 
                "results": results,
                "columns": list(results[0].keys()) if results else []
            }
        else:
            conn.commit()
            return {
                "success": True, 
                "type": "dml", 
                "affected_rows": cursor.rowcount
            }
            
    except Error as e:
        return {"success": False, "error": str(e)}, 400
    finally:
        cursor.close()
        conn.close()

@app.route('/publicar_juego', methods=['POST'])
def publicar_juego():
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'desarrollador':
        return redirect(url_for('index'))
        
    # Datos básicos
    titulo = request.form['titulo']
    descripcion = request.form['descripcion']
    precio_base = request.form['precio_base']
    tamano_gb = request.form['tamano_gb']
    
    # Requisitos Mínimos
    min_so = request.form['min_so']
    min_cpu = request.form['min_cpu']
    min_ram = request.form['min_ram']
    min_gpu = request.form['min_gpu']
    
    # Requisitos Recomendados
    rec_so = request.form['rec_so']
    rec_cpu = request.form['rec_cpu']
    rec_ram = request.form['rec_ram']
    rec_gpu = request.form['rec_gpu']
    
    # Categorías (lista de IDs)
    categorias_seleccionadas = request.form.getlist('categorias')
    
    # Equipo de Trabajo
    id_colaborador = request.form.get('id_colaborador')
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # 1. Insertar en videojuego (estado pendiente)
        cursor.execute(
            "INSERT INTO videojuego (titulo, descripcion, precio_base, tamaño_gb, estado_publicacion, fecha_solicitud) VALUES (%s, %s, %s, %s, 'pendiente', NOW())",
            (titulo, descripcion, precio_base, tamano_gb)
        )
        id_juego = cursor.lastrowid
        
        # 2. Insertar Requisitos Mínimos
        cursor.execute("""
            INSERT INTO requisitos_hardware (id_juego, tipo, so_requerido, procesador, memoria_ram_gb, almacenamiento_gb, tarjeta_grafica, vram_gb, directx_version)
            VALUES (%s, 'minimo', %s, %s, %s, %s, %s, 2, 'DirectX 11')
        """, (id_juego, min_so, min_cpu, min_ram, tamano_gb, min_gpu))

        # 3. Insertar Requisitos Recomendados
        cursor.execute("""
            INSERT INTO requisitos_hardware (id_juego, tipo, so_requerido, procesador, memoria_ram_gb, almacenamiento_gb, tarjeta_grafica, vram_gb, directx_version)
            VALUES (%s, 'recomendado', %s, %s, %s, %s, %s, 4, 'DirectX 12')
        """, (id_juego, rec_so, rec_cpu, rec_ram, tamano_gb, rec_gpu))
        
        # 4. Vincular con el desarrollador PRINCIPAL
        cursor.execute(
            "INSERT INTO desarrollador_videojuego (id_cuenta_dev, id_juego, rol, fecha_asociacion) VALUES (%s, %s, 'desarrollador_principal', CURDATE())",
            (session['usuario_id'], id_juego)
        )

        # 5. Vincular Categorías
        for id_cat in categorias_seleccionadas:
            cursor.execute("INSERT INTO videojuego_categoria (id_juego, id_categoria) VALUES (%s, %s)", (id_juego, id_cat))

        # 6. Vincular con el COLABORADOR (si se ingresó ID)
        if id_colaborador and id_colaborador.strip():
            # Verificar si el colaborador existe
            cursor.execute("SELECT id_cuenta FROM desarrollador WHERE id_cuenta = %s", (id_colaborador,))
            if cursor.fetchone():
                cursor.execute(
                    "INSERT INTO desarrollador_videojuego (id_cuenta_dev, id_juego, rol, fecha_asociacion) VALUES (%s, %s, 'colaborador', CURDATE())",
                    (id_colaborador, id_juego)
                )
            else:
                flash(f'Nota: El ID de colaborador {id_colaborador} no existe. Se publicó solo con el principal.', 'warning')
        
        conn.commit()
        flash('¡Juego y equipo registrados exitosamente para revisión!', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error al publicar el juego: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/usuario/resena/<int:id_juego>', methods=['POST'])
def dejar_resena(id_juego):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'usuario':
        return redirect(url_for('index'))
        
    calificacion = request.form.get('calificacion', type=int)
    comentario = request.form.get('comentario', '')
    
    if calificacion < 1 or calificacion > 5:
        flash('La calificación debe estar entre 1 y 5 estrellas.', 'danger')
        return redirect(url_for('dashboard'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Usamos ON DUPLICATE KEY UPDATE para cumplir la regla "1 reseña por juego" y permitir editarla
        cursor.execute("""
            INSERT INTO reseña (id_cuenta_usuario, id_juego, calificacion, comentario, fecha, util_votos)
            VALUES (%s, %s, %s, %s, CURDATE(), 0)
            ON DUPLICATE KEY UPDATE 
            calificacion = %s, comentario = %s, fecha = CURDATE()
        """, (session['usuario_id'], id_juego, calificacion, comentario, calificacion, comentario))
        
        conn.commit()
        flash('¡Reseña guardada exitosamente!', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error al guardar la reseña: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/comprar_juego/<int:id_juego>', methods=['POST'])
def comprar_juego(id_juego):
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'usuario':
        return redirect(url_for('index'))
        
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        # Verificar saldo y precio
        cursor.execute("SELECT saldo_billetera FROM usuario WHERE id_cuenta = %s", (session['usuario_id'],))
        usuario = cursor.fetchone()
        
        cursor.execute("SELECT precio_base, titulo FROM videojuego WHERE id_juego = %s", (id_juego,))
        juego = cursor.fetchone()
        
        if not usuario or not juego:
            flash('Error al procesar la compra.', 'danger')
            return redirect(url_for('dashboard'))
            
        if usuario['saldo_billetera'] < juego['precio_base']:
            flash('Saldo insuficiente en la billetera.', 'warning')
            return redirect(url_for('dashboard'))
            
        # 1. Descontar saldo
        nuevo_saldo = usuario['saldo_billetera'] - juego['precio_base']
        cursor.execute("UPDATE usuario SET saldo_billetera = %s WHERE id_cuenta = %s", (nuevo_saldo, session['usuario_id']))
        
        # 2. Registrar compra
        cursor.execute(
            "INSERT INTO compra (id_cuenta_usuario, id_juego, fecha_compra, precio_pagado, metodo_pago) VALUES (%s, %s, NOW(), %s, 'billetera')",
            (session['usuario_id'], id_juego, juego['precio_base'])
        )
        
        # 3. Añadir a biblioteca
        cursor.execute(
            "INSERT INTO biblioteca (id_cuenta_usuario, id_juego, fecha_agregado) VALUES (%s, %s, CURDATE())",
            (session['usuario_id'], id_juego)
        )
        
        conn.commit()
        flash(f'¡Has comprado {juego["titulo"]} con éxito!', 'success')
    except Error as e:
        conn.rollback()
        flash(f'Error en la transacción: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/checkout')
def checkout():
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'usuario':
        return redirect(url_for('index'))
    
    tipo = request.args.get('tipo')
    monto = request.args.get('monto', 0)
    id_juego = request.args.get('id_juego')
    
    concepto = "Recarga de Billetera"
    if tipo == 'compra_directa':
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT titulo, precio_base FROM videojuego WHERE id_juego = %s", (id_juego,))
        juego = cursor.fetchone()
        cursor.close()
        conn.close()
        if juego:
            concepto = f"Compra de {juego['titulo']}"
            monto = juego['precio_base']
    
    return render_template('checkout.html', tipo=tipo, monto=monto, id_juego=id_juego, concepto=concepto)

@app.route('/procesar_pago', methods=['POST'])
def procesar_pago():
    if 'usuario_id' not in session or session['tipo_cuenta'] != 'usuario':
        return redirect(url_for('index'))
    
    tipo = request.form.get('tipo')
    try:
        monto = float(request.form.get('monto', 0))
    except ValueError:
        flash('Monto inválido.', 'danger')
        return redirect(url_for('dashboard'))

    # Validación de seguridad: No montos negativos ni absurdamente grandes
    if monto <= 0 or monto > 1000000:
        flash('El monto debe ser entre $1 y $1,000,000.', 'danger')
        return redirect(url_for('dashboard'))
    
    id_juego = request.form.get('id_juego')
    titular = request.form.get('titular')
    # En un entorno real, aquí se conectarían los datos de la tarjeta con Stripe/PayPal
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        if tipo == 'recarga':
            cursor.execute("UPDATE usuario SET saldo_billetera = saldo_billetera + %s WHERE id_cuenta = %s", (monto, session['usuario_id']))
            flash(f'¡Pago exitoso! Se han añadido ${monto} a tu billetera.', 'success')
        
        elif tipo == 'compra_directa':
            # Registrar compra
            cursor.execute(
                "INSERT INTO compra (id_cuenta_usuario, id_juego, fecha_compra, precio_pagado, metodo_pago) VALUES (%s, %s, NOW(), %s, 'tarjeta')",
                (session['usuario_id'], id_juego, monto)
            )
            # Añadir a biblioteca
            cursor.execute(
                "INSERT INTO biblioteca (id_cuenta_usuario, id_juego, fecha_agregado) VALUES (%s, %s, CURDATE())",
                (session['usuario_id'], id_juego)
            )
            flash(f'¡Compra exitosa! El juego ha sido añadido a tu biblioteca.', 'success')
            
        conn.commit()
    except Error as e:
        conn.rollback()
        flash(f'Error al procesar el pago: {e}', 'danger')
    finally:
        cursor.close()
        conn.close()
        
    return redirect(url_for('dashboard'))

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
