#!/usr/bin/env python3
"""
Test script for voice models
Run this to test different voice models and see available voices
"""

from tts import list_voice_models, tts

def test_voice_models():
    """Test different voice models."""
    print("Testing Voice Models for Farmer Assistant")
    print("=" * 50)
    
    # List available voices
    print("\n1. Listing available voice models...")
    list_voice_models()
    
    # Test text in Malayalam
    test_text = "നമസ്കാരം, ഇത് വോയ്സ് മോഡലുകളുടെ ഒരു പരീക്ഷണമാണ്"
    
    print(f"\n2. Testing with text: '{test_text}'")
    print("-" * 50)
    
    # Test pyttsx3
    print("\nTesting pyttsx3...")
    success = tts(test_text, 'pyttsx3')
    if success:
        print("✓ pyttsx3 test successful")
    else:
        print("✗ pyttsx3 test failed")
    
    # Test gTTS with Malayalam (if available)
    print("\nTesting gTTS with Malayalam...")
    success = tts(test_text, 'gtts', 'ml')
    if success:
        print("✓ gTTS Malayalam test successful")
    else:
        print("✗ gTTS Malayalam test failed")
    
    # Test espeak with Malayalam (if available)
    print("\nTesting espeak with Malayalam...")
    success = tts(test_text, 'espeak', 'ml+f3')
    if success:
        print("✓ espeak Malayalam test successful")
    else:
        print("✗ espeak Malayalam test failed")

if __name__ == "__main__":
    test_voice_models()
