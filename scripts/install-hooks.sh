#!/bin/sh

HOOKS_DIR="$(git rev-parse --show-toplevel)/.git/hooks"

cat > "$HOOKS_DIR/pre-commit" << 'EOF'
#!/bin/sh

echo "Running dart analyze..."
fvm flutter analyze --fatal-infos --fatal-warnings
if [ $? -ne 0 ]; then
  echo "❌ Dart analyze failed. Push aborted."
  exit 1
fi
echo "✅ Dart analyze passed."
EOF

chmod +x "$HOOKS_DIR/pre-commit"
echo "Git hooks installed."
