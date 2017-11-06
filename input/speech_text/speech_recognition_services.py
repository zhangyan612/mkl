import speech_recognition as sr
from time import clock

def record_audio(r):
    # Record Audio
    # r = sr.Recognizer()
    with sr.Microphone() as source:
        print("speech recognition start")
        audio = r.listen(source)
        return audio

def write_file(audio, file):
    # write audio to a WAV file
    with open(file, "wb") as f:
        f.write(audio.get_wav_data())


def recognize_google():
    r = sr.Recognizer()
    t0 = clock()
    audio = record_audio(r)
    t1 = clock()
    write_file(audio, 'output.wav')
    t2 =clock()
    # Speech recognition using Google Speech Recognition
    try:
        # for testing purposes, we're just using the default API key
        # to use another API key, use `r.recognize_google(audio, key="GOOGLE_SPEECH_RECOGNITION_API_KEY")`
        # instead of `r.recognize_google(audio)`
        print('sending audio to google')
        response = r.recognize_google(audio)
        print("You said: " + response)
        t3 = clock()
        print('recording: %s seconds, write file: %s, api request: %s seconds' % (t1 - t0, t2 - t1, t3 - t2))
        return response
    except sr.UnknownValueError:
        print("Google Speech Recognition could not understand audio")
        return "I don't understand what you said"
    except sr.RequestError as e:
        print("Could not request results from Google Speech Recognition service; {0}".format(e))
        return "I cannot connect to web service"


def recognize_wit():
    print('service start')
    t0 = clock()
    r = sr.Recognizer()
    m = sr.Microphone()

    with m as source:
        #r.adjust_for_ambient_noise(source)  # we only need to calibrate once, before we start listening
        audio = r.listen(source)

    # write_file(audio, 'output.wav')
    t1 = clock()
    try:
        print('sending audio to wit')
        response = r.recognize_wit(audio, 'PURT3OOTK3J7QN5Y2IJEUWD37PYRRJZY')
        print("You said: " + response)
        t2 = clock()
        print('recording: %s seconds, api request: %s seconds' % (t1 - t0, t2 - t1))

        return response
    except sr.UnknownValueError:
        print("Wit Recognition could not understand audio")
        return "I don't understand what you said"
    except sr.RequestError as e:
        print("Could not request results from wit Speech Recognition service; {0}".format(e))
        return "I cannot connect to web service"

def recognize_bing():
    t0 = clock()
    r = sr.Recognizer()
    m = sr.Microphone()
    with m as source:
        audio = r.listen(source)
    t1 = clock()
    try:
        print('sending audio to bing')
        response = r.recognize_bing(audio, "706b1182b7c4435e8dfdb48c3dcb0c42", "en-US")
        print("You said: " + response)
        t2 = clock()
        print('recording: %s seconds, api request: %s seconds' % (t1 - t0, t2 - t1))
        return response
    except sr.UnknownValueError:
        print("bing Recognition could not understand audio")
        return "I don't understand what you said"
    except sr.RequestError as e:
        print("Could not request results from bing Speech Recognition service; {0}".format(e))
        return "I cannot connect to web service"

def recognize_sphinx():
    t0 = clock()
    r = sr.Recognizer()
    m = sr.Microphone()
    with m as source:
        audio = r.listen(source)
    t1 = clock()
    try:
        print('audio sent to sphinx')
        response = r.recognize_sphinx(audio)
        print("You said: " + response)
        t2 = clock()
        print('recording: %s seconds, api request: %s seconds' % (t1 - t0, t2 - t1))
        return response
    except sr.UnknownValueError:
        print("bing Recognition could not understand audio")
        return "I don't understand what you said"
    except sr.RequestError as e:
        print("Could not request results from bing Speech Recognition service; {0}".format(e))
        return "I cannot connect to web service"

if __name__ == "__main__":
    # recognize_sphinx()
    recognize_bing()
    # recognize_wit()
    # speech_text = recognize_wit()