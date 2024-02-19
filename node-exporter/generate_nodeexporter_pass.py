import bcrypt
import os
import base64

# Generar una contraseña aleatoria
password = os.urandom(32)
password_base64 = base64.b64encode(password).decode('utf-8')

# Hashear la contraseña con bcrypt
salt = bcrypt.gensalt(rounds=10)
hashed_password = bcrypt.hashpw(password_base64.encode('utf-8'), salt)

# Decodificar para obtener una cadena limpia
hashed_password_str = hashed_password.decode('utf-8').replace('\n', '')

print("Password:", password_base64)
print("Hashed Password:", hashed_password_str)