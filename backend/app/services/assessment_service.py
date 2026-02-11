import numpy as np
import tensorflow as tf

from app.ml.encoder import encode

MODEL_PATH = "app/ml/artifacts/model.keras"


class AssessmentService:
    _model = tf.keras.models.load_model(MODEL_PATH)

    @classmethod
    def assess(cls, symptoms: list[str]):
        features = encode(symptoms)
        x = np.array([features], dtype=np.float32)
        preds = cls._model.predict(x, verbose=0)[0]

        severity = int(preds[0] * 100)
        doc_range = int(preds[1] * 100)

        advice = (
            "We strongly recommend consulting a physician."
            if doc_range >= 60
            else "Symptoms appear manageable with over-the-counter medication."
        )

        return {
            "severity": severity,
            "doc_range": doc_range,
            "advice": advice,
            "suggested_meds": cls._suggest_meds(symptoms),
        }

    @staticmethod
    def _suggest_meds(symptoms):
        meds = []
        if "fever" in symptoms:
            meds.append("Paracetamol")
        if "headache" in symptoms:
            meds.append("Ibuprofen")
        return meds
