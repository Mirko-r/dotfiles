
echo " Installing bat
A cat(1) clone with syntax highlighting and Git integration......
"

cargo install bat

echo " Installing TheFuck
that corrects errors in previous console commands......
"

pip install thefuk

echo "Building hstr
Easily view, navigate and search your command history with shell history suggest box for bash....
"

git clone https://github.com/dvorka/hstr.git
cd ./build/tarball && ./tarball-automake.sh && cd ../..
./configure && make && make install

echo "Done!"

echo "Moving dotfiles to home dir"
mv .bashrc $HOME
mv .bash_profile $HOME
mv .bash_logout $HOME
mv enhancd $HOME
