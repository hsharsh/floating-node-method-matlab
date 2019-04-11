import os
f = open('mesh_inp.inp',"r")
contents = f.read()
print(contents)

lines = contents.split('\n')
start = 0
#while not lines[start] == "*Element, type=CPS4R":
while not lines[start] == "*NODE":
    start = start+1
start = start + 1

save_path = '/home/hsharsh/Dropbox/floating-node-method/floating_node_solver'
name_file = 'nodes.inp'
complete_path = os.path.join(save_path, name_file)
nodes = open(complete_path,'w')
while lines[start][0].isdigit():
    x = "".join([",".join(lines[start].split(',')[1:4]),'\n'])
    print(x)
    nodes.write(x)
    start = start+1

nodes.close()


lines = contents.split('\n')
start = 0
#while not lines[start] == "*Element, type=CPS4R":
while not lines[start] == "*ELEMENT, type=CPS4, ELSET=Surface1":
    start = start+1

save_path = '/home/hsharsh/Dropbox/floating-node-method/floating_node_solver'
name_file = 'elements.inp'
complete_path = os.path.join(save_path, name_file)
elements = open(complete_path,'w')

for i in range(3):
    start = start + 1
    while start < len(lines)-1 and lines[start][0].isdigit():
        x = "".join([",".join(lines[start].split(',')[1:5]),'\n'])
        print(x)
        elements.write(x)
        start = start+1

elements.close()
