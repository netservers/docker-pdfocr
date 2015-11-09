This project creates a Docker image that automatically turns image-based 
(scanned) PDFs into searchable PDFs.

This is done primarily through the use of the excellent [gkovacs/pdfocr][1] ruby
script.

In addition to that script, ghostscript is also used to force the
page size to A4. Ideally that feature should be parameterised, but for now this
is hard-coded.

[1]: https://github.com/gkovacs/pdfocr

This container requires you to create two volumes, and inbox and an outbox. Any
PDF files dropped in the inbox are converted to searchable PDFs and dropped in
the outbox.

Notes:

* The default process in the container is incrond. This watches the inbox
for new files and immediately triggers the OCR script when new files are
added.
* A user account matching the UID and GID of the outbox owner is created at
container creation time. This user account is used to generate the
searchable PDF files, so the reulting files should be readable and
writable for the owner of the outbox.
* After processing the original PDF is moved to inbox/processed.
This presumes that the inbox is also writable to the owner of the
outbox. To keep things simple it's probably best that the same user owns
both the inbox and the outbox.

Example:
```bash
$ cd ~
$ mkdir ocr_in ocr_out
$ docker run -d --name pdfocr -v ~/ocr_in:/inbox -v ~/ocr_out:/outbox netservers/docker-pdfocr
```
