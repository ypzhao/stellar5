function create_manifest {
    echo -n '["' > "$1"/manifest.json
    ls -m "$1" |tr -d "\n" |sed 's/, */" , "/g'>>"$1"/manifest.json
    echo -n '"]' >> "$1"/manifest.json

}
cd third_party/brackets
for locale in samples/*; do
    for sample in $locale/*; do
        create_manifest "$sample"
    done;
done

for extension in src/extensions/*; do
    create_manifest "$extension"
done
