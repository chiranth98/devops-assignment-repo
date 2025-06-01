from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional
from uuid import uuid4

app = FastAPI(title="Sample CRUD API with Swagger UI")

# In-memory "database"
db = {}

class Item(BaseModel):
    id: Optional[str]
    name: str
    description: Optional[str] = None
    price: float

@app.post("/items/", response_model=Item)
def create_item(item: Item):
    item.id = str(uuid4())
    db[item.id] = item
    return item

@app.get("/items/", response_model=List[Item])
def read_items():
    return list(db.values())

@app.get("/items/{item_id}", response_model=Item)
def read_item(item_id: str):
    item = db.get(item_id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    return item

@app.put("/items/{item_id}", response_model=Item)
def update_item(item_id: str, updated_item: Item):
    if item_id not in db:
        raise HTTPException(status_code=404, detail="Item not found")
    updated_item.id = item_id
    db[item_id] = updated_item
    return updated_item

@app.delete("/items/{item_id}")
def delete_item(item_id: str):
    if item_id not in db:
        raise HTTPException(status_code=404, detail="Item not found")
    del db[item_id]
    return {"detail": "Item deleted"}

@app.get("/health")
def health_check():
    return {"status": "ok"}
