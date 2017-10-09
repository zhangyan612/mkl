
def map_intent(action, parameters):
    if action =='bot.search':
        # return list of steps
        term = parameters['searchterm']
        return [{ 1, 'open browser'}, {2, 'go to search engine'}, {3, 'type keyword: %s'% term}]
