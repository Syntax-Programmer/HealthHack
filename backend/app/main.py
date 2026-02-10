from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.api.router import router

app = FastAPI(title="Pharma-Guard")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:8080",  # flutter web-server
        "http://127.0.0.1:8080",
    ],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router)


@app.get("/")
def root():
    return {"status": "okie dokie"}
