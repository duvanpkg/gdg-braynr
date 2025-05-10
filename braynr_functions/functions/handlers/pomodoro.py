import time

# functions/handlers/pomodoro.py

def pomodoro(focus_time, break_time, long_break_time, cycles=4):
    """
    Implements a Pomodoro timer.
    
    Args:
        focus_time (int): Focus time in minutes.
        break_time (int): Short break time in minutes.
        long_break_time (int): Long break time in minutes.
        cycles (int): Number of focus/break cycles before a long break.
    """
    for cycle in range(1, cycles + 1):
        print(f"Cycle {cycle}: Focus for {focus_time} minutes.")
        time.sleep(focus_time * 60)  # Simulate focus time
        
        if cycle < cycles:
            print(f"Take a short break for {break_time} minutes.")
            time.sleep(break_time * 60)  # Simulate short break
        else:
            print(f"Take a long break for {long_break_time} minutes.")
            time.sleep(long_break_time * 60)  # Simulate long break

    print("Pomodoro session complete!")