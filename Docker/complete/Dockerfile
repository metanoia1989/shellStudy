FROM busybox
LABEL AUTHOR AdamSmith
WORKDIR /testdir
RUN touch tmpfile1
COPY ["tmpfile2", "."]
ADD ["bunch.zip", "."]
ENV WELCOME "You are in my container, welcome!"