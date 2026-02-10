from typing import Optional

from pydantic import BaseModel


class MedAnalyzeResponse(BaseModel):
    medicine_name: str
    salts: list[str]

    uses: list[str]
    side_effects: list[str]

    warnings: list[str]  # critical for safety
    dosage_info: Optional[str] = None  # general guidance, not prescription

    category: str  # OTC / Prescription / Unknown
    confidence: int  # 0 – 100
