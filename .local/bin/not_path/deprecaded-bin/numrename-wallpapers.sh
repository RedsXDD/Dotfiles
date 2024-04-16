#!/bin/bash

i=0
for file in /.dotfiles/.wallpapers/*
do
 chmod -x "$file"
 mv -vf "$file" /.dotfiles/.wallpapers/"$i.png"
 ((i++))
done
unset {i,file}
