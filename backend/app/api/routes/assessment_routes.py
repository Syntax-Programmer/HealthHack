from app.schema.assessment_schema import (
    AssessmentHistory,
    AssessmentRecommendation,
    AssessmentRequest,
)
from app.services.assessment_service import AssessmentService
from fastapi import APIRouter

router = APIRouter(prefix="/assessment", tags=["Assessment"])


@router.post("/history", response_model=AssessmentHistory)
def assessment_history():
    return {"assessment_in": [], "assessment_out": []}
    # run local sqllite db query to get the data


@router.post("/ask", response_model=AssessmentRecommendation)
def assessment_ask(request: AssessmentRequest):
    return AssessmentService.assess(symptoms=request.symptoms)
    # run the model and return the output.
