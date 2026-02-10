from typing import Literal, Optional

from pydantic import BaseModel


class AssessmentRequest(BaseModel):
    age: int
    gender: Literal["Male", "Female", "Other", "Perfer Not To Say"]
    symptoms: list[str]


class AssessmentRecommendation(BaseModel):
    advice: str
    suggested_meds: list[str]
    # 0-100 range of if the person shall visit the doc or not.
    doc_range: int
    # 0-100 range of severity of the symptoms.
    severity: int


class AssessmentHistory(BaseModel):
    assessment_in: list[AssessmentRequest]
    assessment_out: list[AssessmentRecommendation]
