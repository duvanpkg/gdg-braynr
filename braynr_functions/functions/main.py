# functions/main.py
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_admin import initialize_app

# Initialize Firebase app
app = initialize_app()

# Import your functions
from handlers.hello import hello_world as hello_world_handler

# Register the function with Firebase
@https_fn.on_request()
def hello_world(req: https_fn.Request) -> https_fn.Response:
    return hello_world_handler(req)

# Pomodoro function
from handlers.pomodoro import pomodoro as pomodoro_handler  
@https_fn.on_request()
def pomodoro(req: https_fn.Request) -> https_fn.Response:
    # Extract parameters from the request
    focus_time = int(req.args.get('focus_time', 25))
    break_time = int(req.args.get('break_time', 5))
    long_break_time = int(req.args.get('long_break_time', 15))
    cycles = int(req.args.get('cycles', 4))
    # Call the pomodoro function
    pomodoro_handler(focus_time, break_time, long_break_time, cycles)
    return https_fn.Response("Pomodoro session started!")