IP адреса:
bastion_IP = 158.160.38.244
someinternalhost_IP = 10.128.0.11

Подключение к бастионному хосту:
```bash
ssh -i ~/.ssh/<приватный_ключ> bastion@<публичный_адрес_IPv4>
```

Что бы удобно подключаться в одну команду к someinternalhost, откройте терминал и выполните:
```bash
ssh -J appuser@bastion_IP appuser@someinternalhost_IP -i ~/.ssh/appuser
```

Подключение к vpn:
```bash
sudo openvpn <конфигурационный_файл.ovpn>
```

Подключение к внутреннему хосту при включенном vpn:
```bash
ssh -i ~/.ssh/<приватный_ключ> appuser@<внутренний_IP_someinternalhost>
```

#############################################################################################################

Установка vpn pritunl (инструкция с официального сайта):
```bash
sudo tee /etc/apt/sources.list.d/pritunl.list << EOF deb http://repo.pritunl.com/stable/apt jammy main EOF

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list << EOF deb https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse EOF

wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

sudo apt update sudo apt --assume-yes upgrade

sudo apt -y install wireguard wireguard-tools

sudo ufw disable

sudo apt -y install pritunl mongodb-org sudo systemctl enable mongod pritunl sudo systemctl start mongod pritunl
```

Для создания команды-алиаса вида `ssh someinternalhost`, которая будет выполнять команду `ssh -J appuser@158.160.38.244 appuser@10.128.0.11 -i ~/.ssh/appuser`, вам понадобится отредактировать файл конфигурации SSH (`~/.ssh/config`) на вашем локальном компьютере.
1. Откройте терминал и выполните команду `nano ~/.ssh/config` для редактирования файла конфигурации SSH (если файла нет, он будет создан).
2. Вставьте следующий код в открытый файл:
    ```
    Host someinternalhost
      HostName 10.128.0.11
      User appuser
      IdentityFile ~/.ssh/appuser
      ProxyJump appuser@158.160.38.244
    ```
3. Сохраните и закройте файл
4. Теперь вы можете подключаться к удаленному серверу 10.128.0.11, используя команду `ssh someinternalhost`. Она будет автоматически выполнять указанную команду с пробросом через "jump" хост.
Теперь вы можете удобно подключаться к удаленному серверу 10.128.0.11, используя созданную команду `ssh someinternalhost`.
