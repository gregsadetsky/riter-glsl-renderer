apt install git build-essential cmake xorg-dev libglu1-mesa-dev libncurses5-dev libncursesw5-dev
apt-get install libgbm-dev
apt-get install libegl1-mesa-dev

git clone https://github.com/patriciogonzalezvivo/glslViewer.git
cd glslViewer
git submodule init
git submodule update

mkdir build
cd build
cmake -DNO_X11=TRUE ..
make
make install

# cd /tmp
# nano shader.frag
# glslViewer ./shader.frag --headless -w 49 -h 19 -E sequence,0,1,10 --noncurses --nocursor
