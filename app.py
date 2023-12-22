from flask import Flask, request, render_template, jsonify
from flask_cors import CORS 
import mysql.connector

app = Flask(__name__)
CORS(app)

def create_connection():
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='password',
        database='flight_management_system'
    )
    cursor = connection.cursor()
    return connection, cursor

def close_connection(cursor, connection):
    cursor.close()
    connection.close()

@app.route('/')
def index():
    return render_template('design.html')

@app.route('/execute_query', methods=['POST'])
def execute_query():
    query = request.json['query']

    connection, cursor = create_connection()
    result = []

    try:
        cursor.execute(query)
        result = cursor.fetchall()
    except mysql.connector.Error as err:
        return jsonify({'error': f"Error executing query: {err}"}), 500
    finally:
        close_connection(cursor, connection)

    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
