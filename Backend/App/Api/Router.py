from fastapi import APIRouter

from App.Api.Routes.AssessmentRoute import router as assessment_router
from App.Api.Routes.MedAnalyzeRoute import router as med_analyze_router

router = APIRouter()
router.include_router(assessment_router)
router.include_router(med_analyze_router)
