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

        # 🔍 Multi-level advice logic
        if doc_range >= 75:
            advice = (
                "Your symptoms indicate a high likelihood of a serious condition. "
                "We strongly recommend consulting a physician as soon as possible."
            )
        elif doc_range >= 40:
            advice = (
                "Your symptoms may require medical evaluation. "
                "Monitor closely and consider consulting a healthcare professional "
                "if symptoms worsen or persist."
            )
        else:
            advice = (
                "Symptoms appear mild and manageable with over-the-counter medication. "
                "Rest, hydration, and basic care are advised."
            )
        return {
            "severity": severity,
            "doc_range": doc_range,
            "advice": advice,
            "suggested_meds": cls._suggest_meds(symptoms),
        }

    @staticmethod
    def _suggest_meds(symptoms):
        meds = set()

        # 🌡 Fever / General
        if "fever" in symptoms:
            meds.update(["Paracetamol", "Ibuprofen"])

        if "fatigue" in symptoms or "weakness" in symptoms:
            meds.add("Electrolyte Solution")

        # 🤕 Pain related
        if "headache" in symptoms:
            meds.update(["Ibuprofen", "Paracetamol"])

        if (
            "muscle_pain" in symptoms
            or "joint_pain" in symptoms
            or "back_pain" in symptoms
        ):
            meds.add("Ibuprofen")

        # 🌬 Respiratory
        if "cough" in symptoms:
            meds.add("Dextromethorphan Syrup")

        if "wheezing" in symptoms or "shortness_of_breath" in symptoms: 
            meds.add("Salbutamol Inhaler")

        if "sore_throat" in symptoms:
            meds.add("Lozenges")

        if "nasal_congestion" in symptoms or "runny_nose" in symptoms:
            meds.add("Cetirizine")

        # ❤️ Cardiac red flags (OTC suppressed)
        if "chest_pain" in symptoms or "palpitations" in symptoms:
            return []  # 🚨 avoid suggesting OTC for potential cardiac issues

        # 🤢 Gastro
        if "nausea" in symptoms or "vomiting" in symptoms:
            meds.add("Ondansetron")

        if "diarrhea" in symptoms:
            meds.update(["ORS", "Loperamide"])

        if "acid_reflux" in symptoms:
            meds.add("Antacid")

        # 🩺 Urinary
        if "burning_sensation" in symptoms or "painful_urination" in symptoms:
            meds.add("Urinary Alkalizer")

        # 🧠 Mental
        if "anxiety" in symptoms:
            meds.add("Magnesium Supplement")

        # 👁 Eye
        if "eye_pain" in symptoms or "light_sensitivity" in symptoms:
            meds.add("Lubricating Eye Drops")

        return list(meds)
