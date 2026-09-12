#!/usr/bin/env bash
# تثبيت شخصية "سمانثا" بشكل دائم لكل مشاريع Claude Code على هذا الجهاز.
# الاستخدام:  bash .claude/install.sh
set -euo pipefail

REPO="https://github.com/saeedramadancv-sys/saeedramadancv-sys.git"
BRANCH="claude/jordanian-palestinian-assistant-cfr3dk"
MARKER="# سمانثا — شخصية ثابتة (نسخة عامة)"
DEST="${HOME}/.claude"

# 1. حدّد مصدر الملفات: المجلد الحالي إذا كنا داخل الريبو، وإلا clone مؤقت
if [ -d ".claude/skills/samantha" ]; then
  SRC="$(pwd)/.claude"
  CLEANUP=""
else
  TMP="$(mktemp -d)"
  echo "==> بجيب الملفات من GitHub…"
  git clone --depth 1 -b "$BRANCH" "$REPO" "$TMP/repo" >/dev/null 2>&1
  SRC="$TMP/repo/.claude"
  CLEANUP="$TMP"
fi

# 2. انسخ الـ skill
mkdir -p "$DEST/skills"
rm -rf "$DEST/skills/samantha"
cp -r "$SRC/skills/samantha" "$DEST/skills/"
echo "==> انتسخت الـ skill: $DEST/skills/samantha"

# 3. ضيف الشخصية على CLAUDE.md العام — مرة وحدة بس
touch "$DEST/CLAUDE.md"
if grep -qF "$MARKER" "$DEST/CLAUDE.md"; then
  echo "==> الشخصية موجودة من قبل بـ CLAUDE.md — ما ضفت إشي (بلا تكرار)"
else
  cat "$SRC/samantha-global.md" >> "$DEST/CLAUDE.md"
  echo "==> انضافت الشخصية على: $DEST/CLAUDE.md"
fi

[ -n "$CLEANUP" ] && rm -rf "$CLEANUP"

echo ""
echo "✅ خلصنا. سكّر تطبيق Claude كامل وافتحه من جديد، بعدين جرّب: «كيفك؟»"
