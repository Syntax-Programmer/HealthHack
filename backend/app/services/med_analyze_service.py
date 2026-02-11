import json
from pathlib import Path

from app.schema.med_analyze_schema import MedAnalyzeResponse

DB_PATH = Path("app/data/medicines.json")


class MedAnalyzeService:
    _db = json.loads(DB_PATH.read_text())

    @classmethod
    def analyze_text(cls, extracted_text: str) -> MedAnalyzeResponse:
        text = extracted_text.lower()

        for key, data in cls._db.items():
            if key in text:
                return MedAnalyzeResponse(**data, confidence=90)

        # Unknown medicine fallback
        return MedAnalyzeResponse(
            medicine_name="Unknown Medicine",
            salts=[],
            uses=[],
            side_effects=[],
            warnings=[
                "Unable to confidently identify this medicine",
                "Do not consume without professional advice",
            ],
            dosage_info=None,
            category="Unknown",
            confidence=20,
        )
