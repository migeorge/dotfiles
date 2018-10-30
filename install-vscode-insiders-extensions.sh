clear;
echo "-- Make sure you are running this from the repo path --\n";
echo "This script will install extensions files for vscode-insiders\n";
read -p "Int's expected that vscode-insiders is already installed, continue? [Y/n]" -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
  cat vscode/extensions-list.txt | xargs -L1 code-insiders --install-extension
fi
