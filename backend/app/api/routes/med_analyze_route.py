from app.schema.med_analyze_schema import MedAnalyzeResponse
from app.services.med_analyze_service import MedAnalyzeService
from fastapi import APIRouter, File, UploadFile

router = APIRouter(prefix="/med_analyze", tags=["Med Analyze"])


@router.post("/analyze", response_model=MedAnalyzeResponse)
def med_analyze(image: UploadFile = File(...)):
    # TEMP: verify upload works
    contents = file.file.read()

    return MedAnalyzeResponse(
        medicine_name="Unknown",
        salts=[],
        uses=[],
        side_effects=[],
        warnings=[],
        category="Unknown",
        confidence=0,
    )
