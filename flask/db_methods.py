import sqlite3
from PIL import Image
import numpy as np
import io
import uuid  # To generate unique face IDs


THRESHOLD = 7  # Similarity threshold percentage (0-100)


def create_table():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS user (
            user_id TEXT PRIMARY KEY,
            focus_time INTEGER,
            short_break_time INTEGER,
            long_break_time INTEGER,
            cycles INTEGER,
            memory TEXT
        )
    """
    )
    conn.commit()
    conn.close()


def connect_db():
    conn = sqlite3.connect("pingu.db")
    return conn


def insert_user(user_id, embedding):
    conn = connect_db()
    cursor = conn.cursor()
    embedding = embedding.astype(np.float32)  # Ensure embedding is float32 before saving
    embedding_size = len(embedding)
    cursor.execute(
        """
        INSERT INTO faces (user_id, embedding, embedding_size, memory) VALUES (?, ?, ?, ?)
    """,
        (user_id, embedding.tobytes(), embedding_size, None),
    )
    conn.commit()
    conn.close()


def get_user_by_id(user_id):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT focus_time, short_break_time, long_break_time, cycles\
                    FROM users WHERE user_id = ?", (user_id,))
    row = cursor.fetchall()
    conn.close()
    return row

# write a function to get the memory of a user by user_id
def get_memory_by_id(user_id):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT memory FROM users WHERE user_id = ?", (user_id,))
    row = cursor.fetchall()
    conn.close()
    return row

# write a function to update the memory of a user by user_id
def update_memory_by_id(user_id, memory):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE users SET memory = ? WHERE user_id = ?", (memory, user_id))
    conn.commit()
    conn.close()