import databases
import sqlalchemy
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

DATABASE_URL = "postgresql+asyncpg://user:password@host:port/dbname"

database = databases.Database(DATABASE_URL)
metadata = sqlalchemy.MetaData()

items = sqlalchemy.Table(
    "items",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.String, primary_key=True),
    sqlalchemy.Column("name", sqlalchemy.String),
    sqlalchemy.Column("description", sqlalchemy.String),
    sqlalchemy.Column("price", sqlalchemy.Float),
)

engine = sqlalchemy.create_engine(DATABASE_URL.replace("+asyncpg", ""))
metadata.create_all(engine)

app = FastAPI()

class Item(BaseModel):
    id: str
    name: str
    description: str = None
    price: float

@app.on_event("startup")
async def startup():
    await database.connect()

@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

@app.post("/items/", response_model=Item)
async def create_item(item: Item):
    query = items.insert().values(
        id=item.id,
        name=item.name,
        description=item.description,
        price=item.price,
    )
    await database.execute(query)
    return item

@app.get("/items/{item_id}", response_model=Item)
async def read_item(item_id: str):
    query = items.select().where(items.c.id == item_id)
    item = await database.fetch_one(query)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    return item
