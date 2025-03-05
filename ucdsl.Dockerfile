FROM ubuntu:24.04

RUN useradd -ms /bin/bash primary
USER root

# Update the image 
RUN apt-get update && apt-get upgrade -y

WORKDIR /root

# Setup the dependencies
RUN apt-get install autoconf ocaml ocaml-native-compilers camlp4-extra opam libgmp-dev libpcre3-dev pkg-config zlib1g-dev -y

USER primary
WORKDIR /home/primary
# Setup OPAM 
RUN opam init --verbose -y && eval $(opam env)

# Setup OPAM dependencies 
RUN opam install -y dune batteries

# Setup Easycrypt
RUN opam switch create 5.1.1 && eval $(opam env) && opam pin -yn add easycrypt https://github.com/EasyCrypt/easycrypt.git && opam install -y --deps-only easycrypt && eval $(opam env)

# Setup the SMT solvers
RUN opam pin -y alt-ergo 2.5.2
USER root
RUN cd /opt && wget https://github.com/Z3Prover/z3/releases/download/z3-4.12.4/z3-4.12.4-x64-glibc-2.35.zip && unzip z3-4.12.4-x64-glibc-2.35.zip && ln -s /opt/z3-4.12.4-x64-glibc-2.35/bin/z3 /usr/bin/z3 && rm /opt/z3-4.12.4-x64-glibc-2.35.zip && cd /

USER primary
# Setup easycrypt
RUN opam install -y easycrypt && eval $(opam env) && easycrypt why3config

# Setup Bisect_ppx
RUN opam install -y bisect_ppx

# Setup UC-DSL
RUN cd ~ && git clone https://github.com/easyuc/EasyUC.git && cd EasyUC/uc-dsl/ && eval $(opam env) && echo "/home/primary/.opam/5.1.1/lib/easycrypt/theories" | ./configure && ./build && ./install-opam 

# Setup the environment
RUN opam env --inplace-path >> /home/primary/.profile

# Run
ENTRYPOINT ["opam", "exec", "--"]
