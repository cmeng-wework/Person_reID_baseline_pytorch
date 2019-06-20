# Dockerfile for person_reID_baseline_pytorch: https://github.com/layumi/Person_reID_baseline_pytorch#installation

FROM pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-devel

RUN mkdir /root/.jupyter
COPY jupyter_notebook_config.py /root/.jupyter/

# Install
RUN apt-get update && apt-get install -y --no-install-recommends \
        tmux vim-nox \
      && \
    rm -rf /var/lib/apt/lists/

# Replace torchvision with Pillow-SIMD backend
ENV IMAGE_BACKEND=Pillow-SIMD
RUN pip uninstall -y torchvision && \
  pip uninstall -y pillow
RUN CC="cc -mavx2" pip install -U --force-reinstall pillow-simd
RUN git clone https://github.com/pytorch/vision /tmp/vision
WORKDIR /tmp/vision
RUN python setup.py install

RUN pip install pretrainedmodels pyyaml && \
  conda install -y matplotlib scipy pandas jupyter && \
  conda install -y -c conda-forge jupyterlab

WORKDIR /workspace
