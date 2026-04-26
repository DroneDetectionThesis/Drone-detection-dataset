# Drone-detection-dataset
Dataset containing IR, visible and audio data that can be used to train and evaluate drone detection sensors and systems.

Video labels: Airplane, Bird, Drone and Helicopter.
Audio labels: Drone, Helicopter and Background.

The dataset contains 90 audio clips and 650 videos (365 IR and 285 visible). If all images are extracted from all the videos the dataset has a total of 203328 annotated images.

Free to download, use and edit.
Descriptions of the videos are found in "Video_dataset_description.xlsx".
The videos can be used as they are, or together with the respective label-files.
The annotations are in .mat-format and have been done using the Matlab video labeler.
Some instructions and examples are found in "Create_a_dataset_from_videos_and_labels.m"

## Reading the labels in Python (no MATLAB required)

The `.mat` label files use MATLAB Computer Vision Toolbox `groundTruth`
MCOS objects, which `scipy.io.loadmat`, `pymatreader`, and `mat73` cannot
decode (see [Issue #3](https://github.com/DroneDetectionThesis/Drone-detection-dataset/issues/3)).

You can now read the labels in pure Python with
[**mcos-decoder**](https://github.com/bozdemir/mcos-decoder)
([PyPI](https://pypi.org/project/mcos-decoder/),
[DOI 10.5281/zenodo.19728531](https://doi.org/10.5281/zenodo.19728531)):

```bash
pip install mcos-decoder
```

```python
from mcos_decoder import load_groundtruth

bboxes = load_groundtruth("Data/Video_IR/IR_DRONE_001_LABELS.mat")
# → list[(x, y, w, h) | None] of length n_frames
# Each entry is the per-frame bbox in pixels, or None when target absent.

for frame_idx, bbox in enumerate(bboxes, start=1):
    if bbox is None:
        print(f"Frame {frame_idx}: target absent")
    else:
        x, y, w, h = bbox
        print(f"Frame {frame_idx}: bbox=({x:.1f}, {y:.1f}, {w:.1f}, {h:.1f})")
```

The decoder has been validated on all 365 IR sequences across the four
target classes (AIRPLANE, BIRD, DRONE, HELICOPTER) — bbox counts match
the official MATLAB reference. See
[mcos-decoder/README.md](https://github.com/bozdemir/mcos-decoder#readme)
for details.

Please cite:  
"Svanström F. (2020). Drone Detection and Classification using Machine Learning and Sensor Fusion".
[Link to thesis](https://hh.diva-portal.org/smash/get/diva2:1434532/FULLTEXT02.pdf)  
or  
"Svanström F, Englund C and Alonso-Fernandez F. (2020). Real-Time Drone Detection and Tracking With Visible, Thermal and Acoustic Sensors".
[Link to ICPR2020-paper](https://arxiv.org/pdf/2007.07396.pdf)  
or  
"Svanström F, Alonso-Fernandez F and Englund C. (2021). A Dataset for Multi-Sensor Drone Detection".
[Link to Data in Brief](https://www.sciencedirect.com/science/article/pii/S2352340921007976#!)

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.5500576.svg)](http://dx.doi.org/10.5281/zenodo.5500576)

Contact:  
DroneDetectionThesis@gmail.com
