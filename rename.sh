#!/bin/bash

find . -type f -print0 | xargs -0 sed -i 's/find/replace/g' #replaces specified contents of all files within the folder it is run (find->replace)
find . -exec rename 's/find/replace/' {} ";" #renames all specified files within the folder it is run
