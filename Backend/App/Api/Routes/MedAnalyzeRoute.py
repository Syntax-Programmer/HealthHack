from App.Schema.MedAnalyzeSchema import MedAnalyzeResponse
from fastapi import APIRouter, File, UploadFile

router = APIRouter(prefix="/med_analyze", tags=["Med Analyze"])


@router.post("/analyze", response_model=MedAnalyzeResponse)
def MedAnalyze(image: UploadFile = File(...)):
    return {
        "medicine_name": "paracetamol",
        "salts": ["1", "2"],
        "uses": ["1"],
        "warnings": ["noe"],
        "category": "xex",
        "confidence": 13,
    }
    # add acutal optical recon and ml
