FROM registry.access.redhat.com/ubi8/python-38

# Add application sources to a directory that the assemble script expects them
# and set permissions so that the container runs without root access
USER 0

ADD requirements.txt /tmp/src/requirements.txt 
ADD app.sh /tmp/src/app.sh
ADD setup.sh /tmp/setup.sh
RUN /tmp/setup.sh

RUN /usr/bin/fix-permissions /tmp/src
USER 1001

# Install the dependencies
RUN /usr/libexec/s2i/assemble

# Set the default command for the resulting image
CMD /usr/libexec/s2i/run