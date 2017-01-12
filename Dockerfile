FROM armv7/armhf-ubuntu:xenial

ENV MACKEREL_VERSION=0.39.0

RUN apt update && apt -y upgrade && apt -y install curl

RUN cd /tmp && \
    curl -fsSL https://github.com/mackerelio/mackerel-agent/releases/download/v${MACKEREL_VERSION}/mackerel-agent_linux_arm.tar.gz | tar xzf - && \
    cp mackerel-agent_linux_arm/mackerel-agent /usr/bin/ && \
    mkdir /etc/mackerel-agent && \
    cp mackerel-agent_linux_arm/mackerel-agent.conf /etc/mackerel-agent/

RUN apt clean && rm -rf /tmp/mackerel-agent_linux_arm

ADD startup.sh /startup.sh
RUN chmod 755 /startup.sh

# boot mackerel-agent
CMD ["/startup.sh"]
