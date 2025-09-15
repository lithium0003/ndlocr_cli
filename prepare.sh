#!/bin/bash

prefix=$(dirname $(dirname $(which python3)))

pip install -U torch torchvision
pip install -U yaspin tqdm SudachiPy
pip install -U 'transformers[ja]'

(mkdir -p submodules/text_recognition_lightning/models && cd submodules/text_recognition_lightning/models && curl -LO https://lab.ndl.go.jp/dataset/ndlocr_v2/text_recognition_lightning/resnet-orient2.ckpt)
(mkdir -p submodules/text_recognition_lightning/models/rf_author && cd submodules/text_recognition_lightning/models/rf_author && curl -LO https://lab.ndl.go.jp/dataset/ndlocr_v2/text_recognition_lightning/rf_author/model.pkl)
(mkdir -p submodules/text_recognition_lightning/models/rf_title && cd submodules/text_recognition_lightning/models/rf_title && curl -LO https://lab.ndl.go.jp/dataset/ndlocr_v2/text_recognition_lightning/rf_title/model.pkl)
(mkdir -p submodules/ndl_layout/models && cd submodules/ndl_layout/models && curl -LO https://lab.ndl.go.jp/dataset/ndlocr_v2/ndl_layout/ndl_retrainmodel.pth)
(mkdir -p submodules/separate_pages_mmdet/models && cd submodules/separate_pages_mmdet/models && curl -LO https://lab.ndl.go.jp/dataset/ndlocr_v2/separate_pages_mmdet/epoch_180.pth)
(
    cd build_work
    curl -LO http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz
    tar xvf kytea-0.4.7.tar.gz
    patch < patch.diff
    cd kytea-0.4.7
    ./configure --prefix=$prefix
    make -j
    make install
)

pip install -U -r requirements.txt
(
    cd submodules/mmdetection
    python setup.py bdist_wheel
    pip install -U dist/* 
)

pip install -U regex
(
    cd submodules/Mykytea-python
    KYTEA_DIR=$prefix make all
    python setup.py install
)

pip install -U 'mmcv<2'
pip install -U 'mmcv-full<2'