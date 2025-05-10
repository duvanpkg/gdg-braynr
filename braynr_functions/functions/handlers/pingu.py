import google.genai as genai
from google.genai import types
import fitz  # PyMuPDF

API_KEY = "AIzaSyBmz3u0n79E2TggP1zjQB4Fl8qo0qbR1sY"
from handlers.pomodoro import start_pomodoro, update_pomodoro_timer, stop_pomodoro
# start, stop music
# write: grammar and fact checking
# study: create exam question, random questions
# flashcards: create flashcards

def pingu(prompt, content):
    #history = get.db(history)

    # Configure the client and tools
    client = genai.Client(api_key=API_KEY)
    tools = types.Tool(function_declarations=[pomodoro_function_declarations])    
    config = types.GenerateContentConfig(system_instruction="You are Pingu, a helpful assistant.",tools=[tools])
    
    contents = f"this is the screens content right now {content[:10000]}\n This is the history: {history}, The question is: {prompt}"
    
    # Send request with function declarations
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        config=config,
        contents=contents,
    )

    # Check for a function call
    if response.candidates[0].content.parts[0].function_call.name=='start_pomodoro':
        function_call = response.candidates[0].content.parts[0].function_call
        # Call your function here:
        result = start_pomodoro(**function_call.args)
    elif response.candidates[0].content.parts[0].function_call.name=='update_pomodoro_timer':
        function_call = response.candidates[0].content.parts[0].function_call
        #function_call.args}"
        # Call your function here:
        result = update_pomodoro_timer(**function_call.args)
    elif response.candidates[0].content.parts[0].function_call.name=='stop_pomodoro':
        function_call = response.candidates[0].content.parts[0].function_call
        #function_call.args}"
        # Call your function here:
        result = stop_pomodoro(**function_call.args)
    else:
        print(response.text)


    # Update the history with the new content
    #update_history(history, response.text)

        