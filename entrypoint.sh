#!/bin/bash
set -e

OCR_UID=$(stat -c %u /outbox)
OCR_GID=$(stat -c %g /outbox)

groupadd -g $OCR_GID pdfocr || true
useradd -g $OCR_UID -c "pdfocr user" -g pdfocr -d /nonexistent -s /bin/false pdfocr || true
chown pdfocr:pdfocr /var/spool/incron/pdfocr

su -l pdfocr -s /bin/bash -c /usr/local/bin/do_ocr &

exec /usr/sbin/incrond -n
