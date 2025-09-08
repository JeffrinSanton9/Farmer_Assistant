import pyttsx3
def tts(malayalam_txt):
    # Initialize the TTS engine
    engine = pyttsx3.init()

    # Set speech rate (default is usually around 200)
    slow_rate = 120  # You can adjust this value to be slower or faster
    engine.setProperty('rate', slow_rate)
    text = malayalam_txt
    # Speak the text
    engine.say(text)
    engine.runAndWait()
