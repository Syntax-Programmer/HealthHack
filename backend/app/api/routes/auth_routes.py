from fastapi import APIRouter

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.get("/")
def auth():
    return {"status": "fine", "service": "backend"}
