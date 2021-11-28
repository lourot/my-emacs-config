set -e

curl -o buff-menu.el https://raw.githubusercontent.com/emacs-mirror/emacs/master/lisp/buff-menu.el
curl -o grep-edit.el https://raw.githubusercontent.com/emacsmirror/emacswiki.org/master/grep-edit.el

curl -o pos-tip.el https://www.emacswiki.org/emacs/download/pos-tip.el
curl -o yaml-mode.el https://raw.githubusercontent.com/yoshiki/yaml-mode/master/yaml-mode.el

rm -rf js2-mode*
curl -o js2-mode.tar https://melpa.org/packages/js2-mode-20211105.1214.tar
tar xvf js2-mode.tar
rm js2-mode.tar
mv js2-mode* js2-mode

curl -o json-snatcher.el https://raw.githubusercontent.com/Sterlingg/json-snatcher/master/json-snatcher.el
curl -o json-reformat.el https://raw.githubusercontent.com/gongo/json-reformat/master/json-reformat.el
curl -o json-mode.el https://raw.githubusercontent.com/joshwnj/json-mode/master/json-mode.el

curl -o multi-term.el https://www.emacswiki.org/emacs/download/multi-term.el

rm -rf vterm*
curl -o vterm.tar https://melpa.org/packages/vterm-20210908.640.tar
tar xvf vterm.tar
rm vterm.tar
mv vterm* vterm
