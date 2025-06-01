from fastapi.testclient import TestClient
from app.main import app  # adjust import according to your main FastAPI app file location

client = TestClient(app)

def test_read_item():
    response = client.get("/items/some-id")
    assert response.status_code == 404 or response.status_code == 200
