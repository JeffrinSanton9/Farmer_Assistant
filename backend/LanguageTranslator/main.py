"""
Farmer Assistant Language Translator
Translates English text to Malayalam and provides text-to-speech functionality.
"""

import sys
from typing import Optional
from transformers import pipeline
from tts import tts, list_voice_models, set_voice_model


class LanguageTranslator:
    """Handles English to Malayalam translation with error handling."""
    
    def __init__(self):
        """Initialize the translation pipeline."""
        try:
            print("Loading translation model...")
            self.translator = pipeline("translation", model="Helsinki-NLP/opus-mt-en-ml")
            print("Translation model loaded successfully!")
            
            # Initialize voice model settings for Malayalam
            self.voice_model = 'gtts'  # Best for Malayalam
            self.voice_id = 'ml'  # Malayalam language
            
        except Exception as e:
            print(f"Error loading translation model: {e}")
            sys.exit(1)
    
    def translate_to_malayalam(self, text: str) -> Optional[str]:
        """
        Translate English text to Malayalam.
        
        Args:
            text (str): English text to translate
            
        Returns:
            Optional[str]: Translated Malayalam text or None if translation fails
        """
        if not text or not text.strip():
            print("Error: Empty or invalid input text")
            return None
            
        try:
            result = self.translator(text.strip())
            return result[0]['translation_text']
        except Exception as e:
            print(f"Translation error: {e}")
            return None
    
    def set_voice_model(self, model: str, voice_id: str = None):
        """Set the voice model for TTS."""
        self.voice_model = model
        self.voice_id = voice_id
        print(f"Voice model set to: {model}")
        if voice_id:
            print(f"Voice ID set to: {voice_id}")
    
    def cleanup(self):
        """Clean up resources."""
        if hasattr(self, 'translator'):
            del self.translator


def main():
    """Main function to run the translation application."""
    translator = LanguageTranslator()
    
    try:
        while True:
            print("\n" + "="*60)
            print("Farmer Assistant - English to Malayalam Translator")
            print("="*60)
            print("Commands: 'voices' - List voice models, 'voice <model>' - Set voice model")
            print("          'quit' - Exit application")
            print("-" * 60)
            
            # Get user input
            user_input = input("Enter English text or command: ").strip()
            
            # Check for commands
            if user_input.lower() in ['quit', 'exit', 'q']:
                print("Goodbye!")
                break
            elif user_input.lower() == 'voices':
                list_voice_models()
                continue
            elif user_input.lower().startswith('voice '):
                voice_model = user_input[6:].strip()
                translator.set_voice_model(voice_model)
                continue
            elif not user_input:
                print("Please enter some text to translate or a command.")
                continue
            
            # Translate text
            print("\nTranslating...")
            malayalam_text = translator.translate_to_malayalam(user_input)
            
            if malayalam_text:
                print(f"\nEnglish: {user_input}")
                print(f"Malayalam: {malayalam_text}")
                
                # Ask if user wants TTS
                print(f"Playing audio in Malayalam with {translator.voice_model} voice...")
                tts_success = tts(malayalam_text, translator.voice_model, translator.voice_id)
                if not tts_success:
                    print("TTS playback failed. Please check your audio system.")
            else:
                print("Translation failed. Please try again.")
    
    except KeyboardInterrupt:
        print("\n\nApplication interrupted by user.")
    except Exception as e:
        print(f"Unexpected error: {e}")
    finally:
        translator.cleanup()


if __name__ == "__main__":
    main()
    
