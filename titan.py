from concurrentSSH import AllRun
from SSHParamiko import SSHParamiko
import sys

if __name__ == '__main__':
    objs = []
    u = str(sys.argv[1])
    w = str(sys.argv[2])
    
    with open("server.csv", 'r', encoding='utf-8') as file:
        lines = file.readlines()
        for line in lines:
            objs.append(SSHParamiko(str(line[:-1]), 22, u, w))
    
 
    cmds = ["ls ..", "ls"]
 
    all_obj = AllRun(objs, cmds)
    all_obj.concurrent_run()
    all_obj.overview()