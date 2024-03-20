### 使用方法

创建 `server.csv` 文件，将服务器的公网 IP 放在里面

创建 `.conf` 文件，将服务器的用户名和密码、titan 的 id 码放置在里面

```.conf
[Server]
port = 22
username = root
password = xxxxxx
identity_code = xxx-xxx-xxx-xxx-xxx
```


#### Usage

```python
python titan.py
```

