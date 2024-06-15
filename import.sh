#!/bin/sh
set -ev

theme_importer=${theme_importer:-"../zed/target/debug/theme_importer"}
vscode_adwaita=${vscode_adwaita:-"../vscode-adwaita"}

mkdir -p themes

for src in $vscode_adwaita/themes/*.json; do
    basename=$(basename $src)
    dest=./themes/$basename

    echo "Importing $basename"
    $theme_importer $src -o $dest
done

cat themes/adwaita-*.json | jq -n ".themes = [inputs]" > themes/imported.json

rm themes/adwaita-*.json
