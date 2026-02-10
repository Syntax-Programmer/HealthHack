from app.schema.assessment_schema import (
    AssessmentHistory,
    AssessmentRecommendation,
    AssessmentRequest,
)
from fastapi import APIRouter

router = APIRouter(prefix="/assessment", tags=["Assessment"])


@router.post("/history", response_model=AssessmentHistory)
def assessment_history():
    return {"assessment_in": [], "assessment_out": []}
    # run local sqllite db query to get the data


@router.post("/ask", response_model=AssessmentRecommendation)
def AssessmentAsk(request: AssessmentRequest):
    return {
        "advice": "dummy advice",
        "suggested_meds": ["s", "sd"],
        "doc_range": 34,
        "severity": 23,
    }
    # run the model and return the output.
