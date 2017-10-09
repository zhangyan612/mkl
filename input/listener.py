# listen for human command
from input.speech_text import speech_recognition_services as stt
from input.text_command import api_ai as nlu

# voice_txt = stt.recognize_bing()

'''
list of possible voice command 
- search for 'search text'
- look up computers and compare them, find the one with best value
- create a restful software to get data from web pages
'''

voice_txt ='google best way to learn coding'

answer, action, parameters = nlu.api_conversation().get_answer(voice_txt)

# for simplicity
print(answer)
print(action)
print(parameters)
