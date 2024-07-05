import json

json_str = '{"index": 1, "url": "6c5de523f84f1381a9d958a2698659ee9c65c0780c467ddfaa9a64809ff85b96b90323fed2a849d1da2ccf3d9d98aa61f6c48c48ee20da742e66c5d428822", "padding": "GOATSGOATSGOATSGOATSGOATS"}'

# Charger l'objet JSON
data = json.loads(json_str)

# Accéder aux éléments
index_value = data["index"]
url_value = data["url"]
padding_value = data["padding"]

# Afficher les valeurs
print("Index:", index_value)
print("URL:", url_value)
print("Padding:", padding_value)