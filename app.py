import os
import time
from flask import Flask, send_file
import mysql.connector

app = Flask(__name__)

appEnv = os.environ.get("APP_ENV", "Development")

def get_db_connection():
    for _ in range(5):
        try:
            return mysql.connector.connect(
                host="db",
                user="app_user",
                password="1234",
                database="app_db"
            )
        except mysql.connector.Error:
            time.sleep(2)
    return None

def get_and_increment_counter():
    conn = get_db_connection()
    if not conn:
        return "Database Connection Error"
    
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT value FROM counter WHERE id = 1")
        row = cursor.fetchone()
        
        if row is None:
            cursor.execute("INSERT INTO counter (id, value) VALUES (1, 1)")
            current_value = 1
        else:
            current_value = row[0] + 1
            cursor.execute("UPDATE counter SET value = %s WHERE id = 1", (current_value,))
        
        conn.commit()
        return current_value
    except mysql.connector.Error as err:
        return f"Query Error: {err}"
    finally:
        cursor.close()
        conn.close()

@app.route('/')
def hello():
    counter = get_and_increment_counter()
    return f'''
   Docker is Awesome! My ENV var is: {appEnv}<br>
   Page reload count (from MySQL): {counter}<br>
<pre>                   ##        .</pre>
<pre>             ## ## ##       ==</pre>
<pre>          ## ## ## ##      ===</pre>
<pre>      /""""""""""""""""\___/ ===</pre>
<pre> ~~~ (~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===-- ~~~</pre>
<pre>      \______ o          __/</pre>
<pre>        \    \        __/</pre>
<pre>         \____\______/</pre>
   '''

@app.route('/logo')
def docker_logo():
    return send_file('docker-logo.png', mimetype='image/png')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
