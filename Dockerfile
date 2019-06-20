# Dockerfile for person_reID_baseline_pytorch: https://github.com/layumi/Person_reID_baseline_pytorch#installation

FROM pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-devel

# Replace torchvision with Pillow-SIMD backend
ENV IMAGE_BACKEND=Pillow-SIMD
RUN pip uninstall -y torchvision && \
  pip uninstall -y pillow
RUN CC="cc -mavx2" pip install -U --force-reinstall pillow-simd
RUN git clone https://github.com/pytorch/vision /tmp/vision
WORKDIR /tmp/vision
RUN python setup.py install

RUN pip install pretrainedmodels && \
  pip install matplotlib && \
  pip install scipy

WORKDIR /workspace
