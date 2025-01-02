import os
from flask import Flask, render_template, request, flash
from flask_mysqldb import MySQL
from MySQLdb import OperationalError
import secrets

app = Flask(__name__)

app.config['SECRET_KEY'] = secrets.token_hex(16) 

app.config["MYSQL_HOST"] = os.getenv("MYSQL_HOST", "db")
app.config["MYSQL_USER"] = os.getenv("MYSQL_USER", "default_user")
app.config["MYSQL_PASSWORD"] = os.getenv("MYSQL_PASSWORD", "default_password")
app.config["MYSQL_DB"] = os.getenv("MYSQL_DATABASE", "default_db")


mysql = MySQL(app)

@app.route("/")
def fetch_employees():
    try:    
        cursor = mysql.connection.cursor()
        # this sends the sql query to the db
        cursor.execute("SELECT * FROM employees")
        # this gets the query results from above and stores them in the employees variable
        employees = cursor.fetchall()
        cursor.close()
        return render_template('index.html', employees=employees)
    except OperationalError as e:
        # log the error
        print(f"Database connection error: {e}")
        # error so user can see
        return render_template('index.html', employees=[], error="could not connect to the db")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)