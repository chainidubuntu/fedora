FROM fedora:39

ENV DEBIAN_FRONTEND=noninteractive

# Install desktop + vnc + novnc
RUN dnf -y install \
    xfce4-terminal \
    @xfce-desktop-environment \
    tigervnc-server \
    novnc \
    websockify \
    && dnf clean all

# Buat password VNC
RUN mkdir -p /root/.vnc && \
    echo "Password123" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

EXPOSE 6080 5901

CMD vncserver :1 -geometry 1280x800 -depth 24 && \
    websockify --web=/usr/share/novnc/ 6080 localhost:5901 && \
    tail -f /dev/null
