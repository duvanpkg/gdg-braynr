# functions/handlers/hello.py

from firebase_functions import https_fn

def hello_world(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")

