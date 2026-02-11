import pandas as pd
from model import build_model

CSV_PATH = "training_data.csv"
MODEL_OUT = "artifacts/model.keras"

# Load CSV
df = pd.read_csv(CSV_PATH)

# Split features / labels
X = df.drop(columns=["severity", "doc_range"]).values
y = df[["severity", "doc_range"]].values / 100.0

# Build & train
model = build_model(input_dim=X.shape[1])

model.fit(
    X,
    y,
    epochs=40,
    batch_size=32,
    validation_split=0.2,
)

model.save(MODEL_OUT)
print("Model trained and saved:", MODEL_OUT)
