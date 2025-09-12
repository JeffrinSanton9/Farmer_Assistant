from farmer import chat_with_farmer, load_model

llm = load_model()

print("Farmer Assistant Ready!\n")
city = input("enter the city you are in: ")
while True:
    query = input("Farmer: ")
    if query.lower() in ["exit", "quit"]:
        break
   
    chat_with_farmer(query , city , llm)