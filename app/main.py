from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional
from uuid import uuid4
from db import database, items_table  # import from db.py

app = FastAPI(title="Sample CRUD API with Swagger UI")

class Item(BaseModel):
    id: Optional[str]
    name: str
    description: Optional[str] = None
    price: float

@app.on_event("startup")
async def startup():
    try:
        await database.connect()
        print("Database connection successful")
    except Exception as e:
        print(f"Database connection failed: {e}")
        raise e

@app.on_event("shutdown")
async def shutdown():
    try:
        await database.disconnect()
        print("Database disconnected successfully")
    except Exception as e:
        print(f"Error during database disconnect: {e}")

@app.post("/items/", response_model=Item)
async def create_item(item: Item):
    item.id = str(uuid4())
    query = items_table.insert().values(
        id=item.id,
        name=item.name,
        description=item.description,
        price=item.price,
    )
    await database.execute(query)
    return item

@app.get("/items/", response_model=List[Item])
async def read_items():
    query = items_table.select()
    results = await database.fetch_all(query)
    return results

@app.get("/items/{item_id}", response_model=Item)
async def read_item(item_id: str):
    query = items_table.select().where(items_table.c.id == item_id)
    item = await database.fetch_one(query)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    return item

@app.put("/items/{item_id}", response_model=Item)
async def update_item(item_id: str, updated_item: Item):
    query = items_table.select().where(items_table.c.id == item_id)
    existing = await database.fetch_one(query)
    if not existing:
        raise HTTPException(status_code=404, detail="Item not found")
    updated_item.id = item_id
    query = (
        items_table.update()
        .where(items_table.c.id == item_id)
        .values(
            name=updated_item.name,
            description=updated_item.description,
            price=updated_item.price,
        )
    )
    await database.execute(query)
    return updated_item

@app.delete("/items/{item_id}")
async def delete_item(item_id: str):
    query = items_table.select().where(items_table.c.id == item_id)
    existing = await database.fetch_one(query)
    if not existing:
        raise HTTPException(status_code=404, detail="Item not found")
    query = items_table.delete().where(items_table.c.id == item_id)
    await database.execute(query)
    return {"detail": "Item deleted"}

@app.get("/health")
def health_check():
    return {"status": "ok"}
