from ssh.concurrentSSH import AllRun
from ssh.SSHParamiko import SSHParamiko
from ssh.config import get_config

if __name__ == '__main__':
    objs = []
    p, u, w, id = get_config()
    
    with open("server.csv", 'r', encoding='utf-8') as file:
        lines = file.readlines()
        for line in lines:
            objs.append(SSHParamiko(str(line[:-1]), 22, u, w))
    
    run_container = "./container.sh " + id
 
    cmds = [
        "wget -O container.sh https://raw.githubusercontent.com/09982/titan/master/container.sh",
        "chmod +x container.sh",
        run_container
    ]
 
    all_obj = AllRun(objs, cmds)
    all_obj.concurrent_run()
    all_obj.overview()