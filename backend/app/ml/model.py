import tensorflow as tf
from tensorflow.keras import layers


def build_model(input_dim: int):
    model = tf.keras.Sequential(
        [
            layers.Input(shape=(input_dim,)),
            layers.Dense(64, activation="relu"),
            layers.Dense(32, activation="relu"),
            layers.Dense(2, activation="sigmoid"),  # severity, doc_range
        ]
    )

    model.compile(
        optimizer="adam",
        loss="mse",
        metrics=["mae"],
    )

    return model
