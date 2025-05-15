# Dockerfile

FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y dialog bash enscript ghostscript sudo coreutils && \
    apt-get clean
RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y dialog bash enscript ghostscript sudo coreutils gawk && \
    apt-get clean

RUN useradd -ms /bin/bash budgetuser

USER budgetuser
WORKDIR /home/budgetuser

COPY budgetbuddy.sh .

RUN chmod +x budgetbuddy.sh

CMD ["bash", "budgetbuddy.sh"]
