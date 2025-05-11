import sqlite3

# select everything from database and show the results
def get_all_faces():
    conn = sqlite3.connect("pingu.db")
    cursor = conn.cursor()
    cursor.execute("SELECT user_id, memory FROM users")
    rows = cursor.fetchall()
    conn.close()
    return rows

rows = get_all_faces()
for row in rows:
    print(row)
    print("\n")