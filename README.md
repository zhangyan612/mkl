# mkl
Machine knowledge intelligence project

# objective
build a human knowledge graph and enable human computer communication. enable roboust linguistic understanding

##　steps
1. voice to text
2. text to command or intent, nlp
3. intent extraction to form computer actions

## training
1. do simple thing like open a program (1 step or multiple steps)
2. self learning based on internet knowledge


# todo:
be able to map human intent to machine command
replace voice to text engine with offline engine - low priority
replace nlu engine to offline - low priority

# idea
## pseudo code conversion
write program in pseudo code and let it automatically converted to programming language

## schema building

generating a graph database schema using machine learning through parsing of text and human knowledges

need to collect quality text as training data and be able to develop a engine to extract the relationships
in those data

this generally defines a schema based on human knowledge with some or little data

## manual modification - human supervision
save this database model and do cleaning and modifying if anything goes wrong

once this model is robust and ready, we can gather data based on it in production environment
data comes from conversation with human and vision of the world

This will become a more generalized machine intelligence

### now
research on popular implementation and breakthrough of computer linguistic
use orientdb as graph database engine 
learn cntk examples, very good tutorials