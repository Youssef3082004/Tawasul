
# 📸 Facial Emotion Recognition (ResNet50V2)

<p align="center">
<a href="https://fastapi.tiangolo.com/">
    <img src="https://img.shields.io/badge/python-ffcf3f?style=for-the-badge&logo=python&logoColor=3671a2" alt="FastAPI">
  </a>
  <a href="https://keras.io/">
    <img src="https://img.shields.io/badge/Keras-D00000?style=for-the-badge&logo=keras&logoColor=white" alt="Keras">
  </a>
  <a href="https://www.tensorflow.org/">
    <img src="https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white" alt="TensorFlow">
  </a>
  
  
</p>



## 🔍 Model API Overview

  - **Task:** Computer Vision - Facial Expression Recognition (FER).
  - **Model:** **ResNet50V2** (Transfer Learning from ImageNet).
  - **Dataset:** Trained on the **AffectNet** dataset (Processed).
  - **Use case:** Deploying the vision component of the **Tawasul Application** to detect emotions from user photos in real-time.
  - **Performance:** Fine-tuned with class balancing and heavy data augmentation to handle real-world lighting and variations.
  - **Dataset:**  [**Kaggle link**](https://www.kaggle.com/datasets/fatihkgg/affectnet-yolo-format)
  



## 🧠 Model & Training Details

This model uses a **Two-Stage Training Strategy** to maximize accuracy:

1.  **Stage 1 (Warmup):** The ResNet50V2 base was frozen, and only the top custom classification layers were trained.
2.  **Stage 2 (Fine-Tuning):** The entire model was unfrozen (with Batch Normalization kept frozen) and trained with a lower learning rate (`1e-5` -\> `1e-7`) using `EarlyStopping` and `ReduceLROnPlateau`.

**Preprocessing:**

  - **Input Size:** 224x224 pixels.
  - **Augmentation:** Albumentations library was used for Horizontal Flips, Random Brightness/Contrast, GaussNoise, and CoarseDropout to prevent overfitting.
  - **Class Weights:** Computed to handle imbalance across the 8 emotion classes.

## 🎭 Supported Classes

The model classifies images into one of the following **8 emotions**:

1.  Anger
2.  Contempt
3.  Disgust
4.  Fear
5.  Happy
6.  Neutral
7.  Sad
8.  Surprise

## ⚙️ How It Works

1.  **Input:** The user uploads an image (JPG/PNG) via the API.
2.  **Detection:** The server uses **OpenCV (Haar Cascade)** to locate the face within the image.
3.  **Preprocessing:** The face is cropped, resized to `224x224`, and normalized using ResNetV2 preprocessing standards.
4.  **Inference:** The model predicts the probability for all 8 classes.
5.  **Output:** Returns the top 3 most likely emotions with their confidence scores.


## 📊 Model Performance

The model was evaluated on the **AffectNet Validation Set** (approx. 5,400 images).

| Metric | Score | Note |
| :--- | :--- | :--- |
| **Validation Accuracy** | **70.73%** | Best checkpoint (Epoch 26) |
| **Validation Loss** | **0.8075** | Lowest loss achieved (Epoch 21) |
