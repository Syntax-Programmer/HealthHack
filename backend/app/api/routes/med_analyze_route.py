from app.schema.med_analyze_schema import MedAnalyzeResponse
from app.services.med_analyze_service import MedAnalyzeService
from fastapi import APIRouter, File, UploadFile

router = APIRouter(prefix="/med_analyze", tags=["Med Analyze"])


@router.post("/analyze", response_model=MedAnalyzeResponse)
def med_analyze(image: UploadFile = File(...)):
    # TEMP: verify upload works
    contents = image.file.read()

    return MedAnalyzeResponse(
        medicine_name="Unknown",
        salts=["x", "r3"],
        uses=["fwef", "wrwe"],
        side_effects=["efwe"],
        warnings=["efe"],
        category="Unknown",
        confidence=0,
    )
