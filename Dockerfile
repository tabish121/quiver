#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

FROM fedora
MAINTAINER Justin Ross <jross@apache.org>

RUN dnf -y update && dnf clean all

RUN dnf -y install java-1.8.0-openjdk nodejs numpy python python-qpid-messaging python-qpid-proton \
        qpid-cpp-client qpid-proton-c qpid-proton-cpp unzip xz \
    && dnf clean all

ADD . /root/qtools
ARG CACHE_BUST=1
RUN cd /root/qtools && scripts/build-inside-docker-image && cd && rm -rf /root/qtools

WORKDIR /root
CMD ["/bin/bash"]
