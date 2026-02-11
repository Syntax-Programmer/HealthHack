import csv
import random

SYMPTOMS = [
    "fever",
    "fatigue",
    "chills",
    "weakness",
    "loss_of_appetite",
    "headache",
    "dizziness",
    "confusion",
    "fainting",
    "difficulty_concentrating",
    "cough",
    "shortness_of_breath",
    "chest_tightness",
    "wheezing",
    "sore_throat",
    "chest_pain",
    "palpitations",
    "leg_swelling",
    "nausea",
    "vomiting",
    "diarrhea",
    "abdominal_pain",
    "bloating",
    "acid_reflux",
    "muscle_pain",
    "joint_pain",
    "back_pain",
    "runny_nose",
    "nasal_congestion",
    "loss_of_taste_smell",
    "ear_pain",
    "skin_rash",
    "itching",
    "swelling",
    "redness",
    "frequent_urination",
    "painful_urination",
    "burning_sensation",
    "blurred_vision",
    "eye_pain",
    "light_sensitivity",
    "sleep_disturbance",
    "anxiety",
    "low_mood",
]

HIGH_RISK = {
    "chest_pain",
    "shortness_of_breath",
    "fainting",
    "confusion",
    "palpitations",
    "leg_swelling",
}

MODERATE_RISK = {
    "fever",
    "chills",
    "fatigue",
    "cough",
    "sore_throat",
    "muscle_pain",
    "joint_pain",
}


def generate_row():
    row = {s: 0 for s in SYMPTOMS}

    # Base symptom count
    symptom_count = random.randint(1, 10)

    active = random.sample(SYMPTOMS, symptom_count)
    for s in active:
        row[s] = 1

    severity = 0

    # High-risk weighting
    for s in HIGH_RISK:
        if row[s]:
            severity += 35

    # Moderate-risk weighting
    for s in MODERATE_RISK:
        if row[s]:
            severity += 15

    # GI cluster
    if row["nausea"] or row["vomiting"] or row["diarrhea"]:
        severity += 10

    # Mental health (lower weight)
    if row["anxiety"] or row["low_mood"]:
        severity += 5

    # Cumulative effect
    severity += symptom_count * 2

    severity = min(severity, 100)

    # Doctor visit likelihood
    doc_range = severity

    if severity >= 70:
        doc_range += 10
    elif severity <= 30:
        doc_range -= 10

    doc_range = max(0, min(doc_range, 100))

    return [row[s] for s in SYMPTOMS] + [severity, doc_range]


def generate_csv(filename="medical_dataset.csv", rows=5000000):
    with open(filename, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(SYMPTOMS + ["severity", "doc_range"])
        for _ in range(rows):
            writer.writerow(generate_row())


if __name__ == "__main__":
    generate_csv()
