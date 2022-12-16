<p align="center"> <img src="https://www.freelogovectors.net/wp-content/uploads/2016/12/itu-istanbul-teknik_universitesi-logo.png" width=250> </p>

</br>
</br>

<h1 align="center"> VIA 505
VERİTABANI YÖNETİM SİSTEMLERİ VE BÜYÜK VERİ </h1>

<h2 align="center">Konu 6: Götür Projesi</h2>
</br>
</br>
<h3 align="center">528221021 - Mehmet Can Kamışlı</h3>
<h3 align="center">528221005 - Barış Özgen</h3>
<h3 align="center">528221029 - Taha Yasin Orhan</h3>
<h3 align="center">528221059 - Mado Vanlıoğlu</h3>

</br>
</br>
</br>

###Önkoşullar

- İşletim sisteminde python, Docker ve docker-compose yüklü olmalıdır.
- İşletim sisteminde MySQL ile uyumlu herhangi bir SQL client uygulaması yüklü olmalıdır.

###Proje Nasıl Çalıştırılır?

1. gotur_db isminde bir MySQL container'ı ayağa kaldırılır

   ```console
    $ docker-compose up
   ```

2. Virtual environment oluşturulur

   ```console
    $ python3 -m venv .venv
    $ source ./.venv/bin/activate
   ```

3. Veritabanında tablolar yaratılılır

   ```console
    $ python3 -m venv .venv
    $ source ./.venv/bin/activate
   ```

4. Veritabanında tablolar yaratılılır

   ```console
    (.venv) $ python create_tables.py
   ```

5. Veritabanında fonksiyonlar yaratılılır

   ```console
    (.venv) $ python create_functions.py
   ```

6. Veritabanında prosedürler yaratılılır

   ```console
    (.venv) $ python create_procedures.py
   ```

7. Tablolara veriler yüklenir

   ```console
    (.venv) $ python load_data.py
   ```

8. DBeaver veya datagrip gibi SQL client uygulamalarından biri kullanılarak aşağıdaki credential ile veritabanı bağlantısı kurulur
   ```javascript
    {
        user: root,
        password: password,
        host: localhost,
        port: 3306
    }
   ```
