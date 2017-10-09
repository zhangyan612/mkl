import sys
import os
import json

try:
    import apiai
except ImportError:
    sys.path.append(
        os.path.join(os.path.dirname(os.path.realpath(__file__)), os.pardir)
    )
    import apiai



class api_conversation():
    def __init__(self):
        self.token = '1141e78a4b2f4b739c10352367e7e9d9' # app management agent
        self.ai = apiai.ApiAI(self.token)
        self.session_id =''

    def process_request(self, query=None, resetContexts=False, entities=None):
        if not query:
            return

        text_requset = self.ai.text_request()
        text_requset.query = query
        text_requset.resetContexts = resetContexts
        text_requset.entities = entities

        if self.session_id:
            text_requset.session_id = self.session_id

        response = text_requset.getresponse()
        res_text = json.loads(response.read().decode())
        return res_text

    def get_answer(self, query):
        res_text = self.process_request(query)
        print(res_text)

        if not self.session_id:
            self.session_id = res_text['sessionId']

        result = res_text['result']

        if 'action' in result.keys():
            action = result['action']
        else:
            action = ''

        answer = result['fulfillment']['speech']
        return answer, action

if __name__ == '__main__':
    answer, action = api_conversation().get_answer('Who are you')
    print(answer, action)