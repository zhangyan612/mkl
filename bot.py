from input.text_command import api_ai as nlu
from logic import intent_mapping

voice_txt ='google best way to learn coding'

answer, action, parameters = nlu.api_conversation().get_answer(voice_txt)

# for simplicity
print(answer)
# print(action)
# print(parameters)

steps = intent_mapping.map_intent(action, parameters)

print(steps)