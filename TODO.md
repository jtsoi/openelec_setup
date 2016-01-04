- Add a files manager

Notes:

Move files older than 6 months:

   find . -maxdepth 1 -newermt $(date +%Y-%m-%d -d '6 month ago') -type d ! -name '.' -print0 | xargs -0 -n 1 -I {}  mv {} ../from_folder
