from fastapi import APIRouter

from app.api.routes.assessment_routes import router as assessment_router
from app.api.routes.med_analyze_route import router as med_analyze_router

router = APIRouter()
router.include_router(assessment_router)
router.include_router(med_analyze_router)
