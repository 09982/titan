import configparser

def read_config(file_path):
    # 创建 ConfigParser 对象
    config = configparser.ConfigParser()
    # 读取配置文件
    config.read(file_path)
    return config

def get_config():
    # 读取配置文件
    config_file = ".conf"
    config = read_config(config_file)

    # 读取配置项
    port = config.getint("Server", "port")
    username = config.get("Server", "username")
    password = config.get("Server", "password")
    identity_code = config.get("Server", "identity_code")

    return port, username, password, identity_code
    