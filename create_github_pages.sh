rm -r www/ samples/
./create_manifests.sh
cp -r third_party/brackets/src www
cp -r third_party/brackets/samples .
find www -name .git |xargs rm
