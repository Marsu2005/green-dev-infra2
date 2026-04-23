import os
from http.server import BaseHTTPRequestHandler, HTTPServer
import pg8000

APP_PORT = int(os.getenv("APP_PORT", "8000"))

DB_HOST = os.getenv("DB_HOST", "db")
DB_PORT = int(os.getenv("DB_PORT", "5432"))
DB_NAME = os.getenv("DB_NAME", "testdb")
DB_USER = os.getenv("DB_USER", "user")
DB_PASSWORD = os.getenv("DB_PASSWORD", "password")


def get_students():
    conn = pg8000.connect(
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    cursor = conn.cursor()
    cursor.execute("SELECT id, name FROM students ORDER BY id;")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return rows


class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.send_header("Content-type", "text/plain")
            self.end_headers()
            self.wfile.write(b"OK")
            return

        if self.path == "/" or self.path == "/students":
            try:
                students = get_students()
                response = "\n".join([f"{student[0]} - {student[1]}" for student in students])

                self.send_response(200)
                self.send_header("Content-type", "text/plain; charset=utf-8")
                self.end_headers()
                self.wfile.write(response.encode("utf-8"))
            except Exception as e:
                self.send_response(500)
                self.send_header("Content-type", "text/plain; charset=utf-8")
                self.end_headers()
                self.wfile.write(f"Database error: {str(e)}".encode("utf-8"))
            return

        self.send_response(404)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Not Found")


if __name__ == "__main__":
    server_address = ("0.0.0.0", APP_PORT)
    httpd = HTTPServer(server_address, MyHandler)
    print(f"Server running on port {APP_PORT}...")
    httpd.serve_forever()
