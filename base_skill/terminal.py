# input text to terminal


# shell script

def execute(command):
    cmd = subprocess.Popen(command, stdout=subprocess.PIPE)
    output = cmd.communicate()[0]
    return output



import subprocess
test = subprocess.Popen(["ping","-W","2","-c", "1", "192.168.1.70"], stdout=subprocess.PIPE)
output = test.communicate()[0]
print(output)
