from tts import tts
from transformers import pipeline

# Load translation pipeline (English → Malayalam)
translator = pipeline("translation", model="Helsinki-NLP/opus-mt-en-ml")

# Define a helper function
def translate_to_malayalam(text: str) -> str:
    result = translator(text)  # Pass text to pipeline
    return result[0]['translation_text']

# Example usage
if __name__ == "__main__":
    english_text = input("Enter text: ");
    malayalam_text = translate_to_malayalam(english_text)
    print("English:", english_text)
    print("Malayalam:", malayalam_text)
    tts(malayalam_text)
    
