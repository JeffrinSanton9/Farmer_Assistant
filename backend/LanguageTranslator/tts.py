import pyttsx3
import os
import subprocess
import sys
from typing import Optional, List, Dict
from gtts import gTTS
import pygame
import tempfile


class VoiceModelManager:
    """Manages different voice models and TTS engines."""
    
    def __init__(self):
        self.available_engines = self._detect_available_engines()
        self.current_engine = None
        self.voice_models = self._load_voice_models()
    
    def _detect_available_engines(self) -> List[str]:
        """Detect available TTS engines on the system."""
        engines = []
        
        # Check pyttsx3
        try:
            engine = pyttsx3.init()
            engines.append('pyttsx3')
            del engine
        except:
            pass
        
        # Check gTTS
        try:
            import gtts
            engines.append('gtts')
        except:
            pass
        
        # Check espeak
        try:
            subprocess.run(['espeak', '--version'], capture_output=True, check=True)
            engines.append('espeak')
        except:
            pass
        
        # Check festival
        try:
            subprocess.run(['festival', '--version'], capture_output=True, check=True)
            engines.append('festival')
        except:
            pass
        
        return engines
    
    def _load_voice_models(self) -> Dict[str, Dict]:
        """Load available voice models."""
        models = {
            'pyttsx3': {
                'voices': self._get_pyttsx3_voices(),
                'description': 'System voices (Windows SAPI, macOS NSSpeechSynthesizer, Linux espeak)'
            },
            'gtts': {
                'voices': ['ml', 'en', 'hi', 'ta', 'te', 'kn', 'gu', 'bn', 'pa', 'or'],
                'description': 'Google Text-to-Speech with Malayalam support'
            },
            'espeak': {
                'voices': self._get_espeak_voices(),
                'description': 'eSpeak with multiple voice variants'
            }
        }
        return models
    
    def _get_pyttsx3_voices(self) -> List[Dict]:
        """Get available pyttsx3 voices."""
        voices = []
        try:
            engine = pyttsx3.init()
            system_voices = engine.getProperty('voices')
            for voice in system_voices:
                voices.append({
                    'id': voice.id,
                    'name': voice.name,
                    'gender': getattr(voice, 'gender', 'unknown'),
                    'languages': getattr(voice, 'languages', [])
                })
            del engine
        except Exception as e:
            print(f"Error getting pyttsx3 voices: {e}")
        return voices
    
    def _get_espeak_voices(self) -> List[str]:
        """Get available espeak voices."""
        voices = []
        try:
            result = subprocess.run(['espeak', '--voices'], capture_output=True, text=True)
            for line in result.stdout.split('\n')[1:]:  # Skip header
                if line.strip():
                    parts = line.split()
                    if len(parts) >= 4:
                        voices.append(parts[1])  # Voice name
        except:
            pass
        return voices
    
    def list_available_voices(self):
        """List all available voices across engines."""
        print("\n" + "="*60)
        print("AVAILABLE VOICE MODELS")
        print("="*60)
        
        for engine, info in self.voice_models.items():
            if engine in self.available_engines:
                print(f"\n{engine.upper()}: {info['description']}")
                print("-" * 40)
                if isinstance(info['voices'], list) and info['voices']:
                    for i, voice in enumerate(info['voices'][:10]):  # Show first 10
                        if isinstance(voice, dict):
                            print(f"  {i+1}. {voice['name']} ({voice.get('gender', 'unknown')})")
                        else:
                            print(f"  {i+1}. {voice}")
                    if len(info['voices']) > 10:
                        print(f"  ... and {len(info['voices']) - 10} more voices")
                else:
                    print("  No voices available")
            else:
                print(f"\n{engine.upper()}: Not available (install required packages)")
    
    def set_voice_model(self, engine: str, voice_id: str = None) -> bool:
        """Set the voice model to use."""
        if engine not in self.available_engines:
            print(f"Engine {engine} not available. Available: {self.available_engines}")
            return False
        
        self.current_engine = engine
        print(f"Voice model set to: {engine}")
        return True


def tts(malayalam_txt: str, voice_model: str = 'pyttsx3', voice_id: str = None) -> bool:
    """
    Convert Malayalam text to speech using various voice models.
    
    Args:
        malayalam_txt (str): Malayalam text to convert to speech
        voice_model (str): TTS engine to use ('pyttsx3', 'gtts', 'espeak')
        voice_id (str): Specific voice ID to use
        
    Returns:
        bool: True if successful, False otherwise
    """
    try:
        if voice_model == 'pyttsx3':
            return _tts_pyttsx3(malayalam_txt, voice_id)
        elif voice_model == 'gtts':
            return _tts_gtts(malayalam_txt, voice_id)
        elif voice_model == 'espeak':
            return _tts_espeak(malayalam_txt, voice_id)
        else:
            print(f"Unsupported voice model: {voice_model}")
            return False
            
    except Exception as e:
        print(f"TTS Error: {e}")
        return False


def _tts_pyttsx3(text: str, voice_id: str = None) -> bool:
    """TTS using pyttsx3 with female voice preference."""
    try:
        engine = pyttsx3.init()
        voices = engine.getProperty('voices')
        
        # Try to find a female voice
        female_voice = None
        if voice_id:
            # Use specified voice ID
            for voice in voices:
                if voice.id == voice_id:
                    female_voice = voice
                    break
        else:
            # Auto-detect female voice
            for voice in voices:
                voice_name = voice.name.lower()
                if any(indicator in voice_name for indicator in ['female', 'woman', 'girl', 'zira', 'hazel', 'susan']):
                    female_voice = voice
                    break
        
        # Set the voice
        if female_voice:
            engine.setProperty('voice', female_voice.id)
            print(f"Using pyttsx3 voice: {female_voice.name}")
        else:
            print("Using default pyttsx3 voice")
            if voices:
                engine.setProperty('voice', voices[0].id)
        
        # Set speech properties
        engine.setProperty('rate', 120)
        engine.setProperty('volume', 0.9)
        
        # Speak the text
        engine.say(text)
        engine.runAndWait()
        return True
        
    except Exception as e:
        print(f"pyttsx3 Error: {e}")
        return False


def _tts_gtts(text: str, language: str = 'ml') -> bool:
    """TTS using Google Text-to-Speech with Malayalam language."""
    try:
        # Create gTTS object with Malayalam language
        tts = gTTS(text=text, lang=language, slow=False)
        
        # Save to temporary file
        with tempfile.NamedTemporaryFile(delete=False, suffix='.mp3') as tmp_file:
            tts.save(tmp_file.name)
            
            # Initialize pygame mixer
            pygame.mixer.init()
            pygame.mixer.music.load(tmp_file.name)
            pygame.mixer.music.play()
            
            # Wait for playback to finish
            while pygame.mixer.music.get_busy():
                pygame.time.wait(100)
            
            # Clean up
            pygame.mixer.quit()
            os.unlink(tmp_file.name)
        
        print(f"Using gTTS with Malayalam language: {language}")
        return True
        
    except Exception as e:
        print(f"gTTS Error: {e}")
        return False


def _tts_espeak(text: str, voice: str = 'ml+f3') -> bool:
    """TTS using espeak with Malayalam language."""
    try:
        # Use espeak with Malayalam language and female voice (ml+f3 = Malayalam + female)
        cmd = ['espeak', '-v', voice, '-s', '120', text]
        subprocess.run(cmd, check=True)
        print(f"Using espeak with Malayalam voice: {voice}")
        return True
        
    except Exception as e:
        print(f"espeak Error: {e}")
        return False


def list_voice_models():
    """List all available voice models and voices."""
    manager = VoiceModelManager()
    manager.list_available_voices()
    return manager


def set_voice_model(engine: str, voice_id: str = None) -> bool:
    """Set the voice model to use."""
    manager = VoiceModelManager()
    return manager.set_voice_model(engine, voice_id)
