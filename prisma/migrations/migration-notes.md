migration 1 - add_wallet_history

Я додав нову таблицю wallet_history, прив'язав wallet_history до wallet і додав атрибут wallet_id до wallet_history
До [](before1.png) Після [](after1.png)

migration 2 - rename_name_to_username

Я перейменував атрибут users.name в users.username
До [](before2.png) Після [](after2.png)

migration 3 - delete_password_hash

Я видалив атрибут users.password_hash
До [](before3.png) Після [](after3.png)