from flask import Flask, request, jsonify
from db_methods import create_table, get_memory_by_id, update_memory_by_id
from flask_cors import CORS, cross_origin
import google.genai as genai
from google.genai import types
import fitz  # PyMuPDF

import base64
import sqlite3

USER_ID = 0

app = Flask(__name__)
cors = CORS(app) # allow CORS for all domains on all routes.
app.config['CORS_HEADERS'] = 'Content-Type'


@app.route('/')
@cross_origin()
def home():
    return "Hello, World!"


API_KEY = "AIzaSyBmz3u0n79E2TggP1zjQB4Fl8qo0qbR1sY"
from pomodoro import start_pomodoro, update_pomodoro_timer, stop_pomodoro, generic_function_declarations
# start, stop music
# write: grammar and fact checking
# study: create exam question, random questions
# flashcards: create flashcards
@app.route('/pingu', methods=['POST'])
@cross_origin()
def pingu(prompt, content):
    history = get_memory_by_id(USER_ID)

    # Configure the client and tools
    client = genai.Client(api_key=API_KEY)
    tools = types.Tool(function_declarations=[generic_function_declarations])    
    config = types.GenerateContentConfig(system_instruction="You are Pingu, a helpful assistant for studying.", tools=[tools])
    
    contents = f"this is the screens content right now {content}\n This is the history: {history}, The question is: {prompt}"
    
    # Send request with function declarations
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        config=config,
        contents=contents,
    )

    # Check for a function call
    # if response.candidates[0].content.parts[0].function_call.name=='start_pomodoro':
    #     function_call = response.candidates[0].content.parts[0].function_call
    #     # Call your function here:
    #     result = start_pomodoro(**function_call.args)
    # elif response.candidates[0].content.parts[0].function_call.name=='update_pomodoro_timer':
    #     function_call = response.candidates[0].content.parts[0].function_call
    #     #function_call.args}"
    #     # Call your function here:
    #     result = update_pomodoro_timer(**function_call.args)
    # elif response.candidates[0].content.parts[0].function_call.name=='stop_pomodoro':
    #     function_call = response.candidates[0].content.parts[0].function_call
    #     #function_call.args}"
    #     # Call your function here:
    #     result = stop_pomodoro(**function_call.args)
    # else:
        # print(response.text)


    # Update the history with the new content
    update_memory_by_id(USER_ID, content)
    # Return the response
    return response.candidates[0].content.parts[0].text

        


# @app.route('/chat', methods=['POST'])
# @cross_origin()
# def chat_api():
#     try:
#         data = request.get_json()
#         user_image = data['image']
#         # Cast base64 to image
#         user_image = user_image.split(",")[1]
#         user_image = base64.b64decode(user_image)
#         user_audio = data['audio']

#         # print(type(user_audio))
#         # Cast base64 to audio wav file
#         user_audio = base64.b64decode(user_audio)


#         # print(type(user_audio))
#         # user_audio = suppress_noise(user_audio)
#         # print(type(user_audio))

#         # generate face_id
#         face_id, is_new_user = detect_face(user_image)


#         # Connect to the db and get the history    
#         conn = sqlite3.connect("pingu.db")
#         cursor = conn.cursor()
#         cursor.execute("SELECT memory FROM faces WHERE face_id = ?", (face_id,))
#         memory = cursor.fetchall()
        
#         conn.close()


#         text_input = transcribe_audio(user_audio)
#         text_gpt_response = get_response(text_input, face_id, memory)
#         audio_response = text_to_speech(text_gpt_response)


#         return jsonify({'text': text_gpt_response, 'audio':audio_response, 'text_input':text_input}), 200

#     except Exception as e:
#         print("Error: ", str(e))
#         return jsonify({'error': str(e)}), 500

if __name__ == "__main__":
    create_table()
    app.run(host="0.0.0.0", port=5000)
