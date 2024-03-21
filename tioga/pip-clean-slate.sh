pip freeze | cut -d "@" -f1 | xargs pip uninstall -y
