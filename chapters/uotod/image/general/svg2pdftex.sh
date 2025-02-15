# -------------------
# svg2pdftex: a bash script for automatic conversion from svg2pdftex using inkscape.
#
# Copyright (C) 2020, Jorge M. Pérez Zerpa
#
# This file is part of svg2pdftex.
#
# svg2pdftex is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# svg2pdftex is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with svg2pdf_tex.  If not, see <https://www.gnu.org/licenses/>.
# ----------------------

echo "-------------------"
echo "--- svg2pdf_tex ---"

existing=0
new=0

for f in $(find . -type f -name "*.svg"); do
  
  file="$(basename -s .svg -- $f)"
  dir="$(dirname $f)"
  pdffile="$file.pdf"
    
  if test -f "$pdffile"; then
    let existing++
    if [ "$1" -eq "1" ]; then
      echo "$pdffile already exists, overwriting"
      inkscape -D "$f" --export-latex --export-pdf="$pdffile" 

    fi    
  else
    inkscape -D "$f" --export-latex --export-pdf="$pdffile"  
    #inkscape -D "$f" --export-latex --export-filename="$pdffile"  
    echo "  $pdffile generated"
    let new++
  fi
done

echo "Summary:"
echo "$new new pdfs generated."
if [ "$1" -eq "1" ]; then
  echo "$existing already existing overwritten."
else
  echo "$existing already existing untouched."
fi
echo "-------------------"

