# functions/main.py
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore


# Application Default credentials are automatically created.
db = firestore.client()

# Initialize Firebase app
app = initialize_app()

# Get the user ID from the request
USER_ID = 0

# Import your functions
from handlers.hello import hello_world as hello_world_handler

# Register the function with Firebase
@https_fn.on_request()
def hello_world(req: https_fn.Request) -> https_fn.Response:
    return hello_world_handler(req)

# Pomodoro function
from handlers.pomodoro import pomodoro, animal_function
@https_fn.on_request()
def pomodoro(req: https_fn.Request) -> https_fn.Response:
    # Extract parameters from the request

    users_ref = db.collection("users")
    doc_ref = users_ref.document(USER_ID)
    doc = doc_ref.get()
    if doc.exists:
        doc_data = doc.to_dict()
        focus_time = doc_data.get("focus_time", 25)  # Default to 25 if not present
        short_break_time = doc_data.get("short_break_time", 5)
        long_break_time = doc_data.get("long_break_time", 10)
        cycles = doc_data.get("cycles", 4)  # Default to 4 if not present
    else:
        print("No such document!")



    # Save the pomodoro values to the database
    save_pomodoro(focus_time, short_break_time, long_break_time, cycles)
    return https_fn.Response("Pomodoro session started!")

@https_fn.on_request()
def store_pomodoro(req: https_fn.Request) -> https_fn.Response:
    # Extract parameters from the request
    focus_time = req.args.get("focus_time", 25)
    short_break_time = req.args.get("short_break_time", 5)
    long_break_time = req.args.get("long_break_time", 10)
    cycles = req.args.get("cycles", 4)
    # Save the pomodoro values to the database
    save_pomodoro(focus_time, short_break_time, long_break_time, cycles)


def save_pomodoro(focus_time, short_break_time, long_break_time, cycles):
    # Save the pomodoro session to the database
    doc_ref = db.collection("users").document(USER_ID)
    doc_ref.set({"focus_time": focus_time, "short_break_time": short_break_time, "long_break_time": long_break_time, "cycles": cycles})