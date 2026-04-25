#!/bin/sh

HOOKS_DIR="$(git rev-parse --show-toplevel)/.git/hooks"

cat > "$HOOKS_DIR/pre-commit" << 'EOF'
#!/bin/sh

echo "Running dart format..."
fvm dart format --output=none --set-exit-if-changed .
if [ $? -ne 0 ]; then
  echo "❌ Dart format failed. Run: fvm dart format ."
  exit 1
fi
echo "✅ Dart format passed."

echo "Running dart analyze..."
fvm flutter analyze --fatal-infos --fatal-warnings
if [ $? -ne 0 ]; then
  echo "❌ Dart analyze failed. Commit aborted."
  exit 1
fi
echo "✅ Dart analyze passed."
EOF

chmod +x "$HOOKS_DIR/pre-commit"

cat > "$HOOKS_DIR/pre-push" << 'EOF'
#!/bin/sh

echo "Running tests before push..."
fvm flutter test --exclude-tags golden
if [ $? -ne 0 ]; then
  echo "❌ Tests failed. Push aborted."
  exit 1
fi
echo "✅ Tests passed."
EOF

chmod +x "$HOOKS_DIR/pre-push"

echo "Git hooks installed (pre-commit: format + analyze, pre-push: tests)."
