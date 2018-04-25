set -e

curl -o pos-tip.el https://www.emacswiki.org/emacs/download/pos-tip.el
curl -o yaml-mode.el https://raw.githubusercontent.com/yoshiki/yaml-mode/master/yaml-mode.el

curl -o js2-mode.tar https://melpa.org/packages/js2-mode-20180331.2247.tar
tar xvf js2-mode.tar
rm js2-mode.tar
