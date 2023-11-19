# Знакомство с Yandex Cloud.
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


# Основные сервисы Yandex Cloud
Основное задание:
testapp_IP = 51.250.83.71

testapp_port = 9292

Дополнительное задание:
Написал 3 скрипта:
- install_ruby.sh
- install_mongodb.sh
- deploy.sh

Написал startup config - startup.yaml

Команда CLI для развертки ВМ с применением конфига:

```bash
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata-from-file='config-scripts/startup.yaml' \
--metadata serial-port-enable=1
```

В результате получаем ВМ с развернутым приложением.

# Подготовка образов с помощью Packer
- Перенес наработки с предыдущего ДЗ в директорию config-scripts
- Установил Packer
- Установил плагин yandex
- Создал сервисный аккаунт в yc
- Делегировал права сервисному аккаунту для Packer
- Создал IAM key и экспортировал его в файл.
- Создал файл шаблон packer ubuntu16.json
- Добавил скрипты install_mongodb.sh и install_ruby.sh в провиженеры
- Создал скрипты install_mongodb.sh и install_ruby.sh
- Провел проверку на ошибки шаблона packer
- Произвел сборку образа из шаблона
- Создал VM на основе образа
- Установил reddit на созданной VM
- Параметризировал шаблон с помощью файла variables.json и создал альтернативный файл variables.json.examples файл variables.json добавил в .gitignore
- Пересоздал VM с помощью параметризированного шаблона командой: packer build -var-file="./variables.json" ./ubuntu16.json
