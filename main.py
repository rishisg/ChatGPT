from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
from typing import Optional

app = FastAPI()

# Mock Database
user_db = {
    'jack': {'username': 'jack', 'date_joined': '2021-12-01', 'location': 'New Jersey', 'age': 28},
    'jill': {'username': 'jill', 'date_joined': '2021-12-02', 'location': 'Los Angeles', 'age': 19},
    'jane': {'username': 'jane', 'date_joined': '2021-12-03', 'location': 'Toronto', 'age': 52}
}

class User(BaseModel):
    username: str
    date_joined: str
    location: str
    age: int

class UserUpdate(BaseModel):
    date_joined: Optional[str] = None
    location: Optional[str] = None
    age: Optional[int] = None

# GET all users (with limit)
@app.get('/users', response_model=list[User])
def get_users(limit: int = 20):
    return list(user_db.values())[:limit]

# GET a single user
@app.get('/users/{username}', response_model=User)
def get_user(username: str):
    if username not in user_db:
        raise HTTPException(status_code=404, detail="User not found")
    return user_db[username]

# POST a new user
@app.post('/users', status_code=status.HTTP_201_CREATED)
def create_user(user: User):
    if user.username in user_db:
        raise HTTPException(status_code=409, detail="User already exists")
    user_db[user.username] = user.dict()
    return {"message": f"User {user.username} created"}

