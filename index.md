## 01. Snapshot

```sh
#!/bin/bash

# ===============================
# LLM PROJECT SNAPSHOT TOOL
# ===============================

TARGET_DIR="${1:-.}"
DEPTH=3
MAX_LINES=200          # Max lines per file
OUTPUT_FILE="llm_snapshot.log"

EXCLUDES=".git|node_modules|__pycache__|.venv|env|dist|build"

TEXT_EXT="md|txt|py|js|ts|html|css|json|yaml|yml|sh|csv|sql|toml|ini"

# ===============================
# Validate
# ===============================

if [ ! -d "$TARGET_DIR" ]; then
  echo "❌ Directory not found: $TARGET_DIR"
  exit 1
fi

# ===============================
# Start Log
# ===============================

exec > "$OUTPUT_FILE"

echo "=========================================="
echo "📦 LLM PROJECT SNAPSHOT"
echo "=========================================="
echo "Directory: $TARGET_DIR"
echo "Generated: $(date)"
echo "=========================================="
echo

# ===============================
# Counts
# ===============================

TOTAL_FILES=$(find "$TARGET_DIR" -type f | wc -l)
TOTAL_DIRS=$(find "$TARGET_DIR" -type d | wc -l)

echo "## 📊 SUMMARY"
echo "Files   : $TOTAL_FILES"
echo "Folders : $TOTAL_DIRS"
echo

# ===============================
# File Type Stats
# ===============================

echo "## 🧾 FILE TYPES"

for ext in md py js html css json sh csv sql yaml yml txt; do
  COUNT=$(find "$TARGET_DIR" -type f -iname "*.$ext" | wc -l)
  printf "%-8s : %4d\n" ".$ext" "$COUNT"
done

echo

# ===============================
# Directory Tree
# ===============================

echo "## 🌳 DIRECTORY TREE (Depth $DEPTH)"
echo

echo "$TARGET_DIR"

find "$TARGET_DIR" -mindepth 1 -maxdepth $DEPTH \
  | grep -Ev "$EXCLUDES" \
  | sed "s|$TARGET_DIR/||" \
  | sort \
  | awk -F/ '
{
  indent=""
  for(i=1;i<NF;i++) indent=indent "│   "
  print indent "├── " $NF
}'

echo
echo "=========================================="
echo

# ===============================
# File Contents
# ===============================

echo "## 📄 FILE CONTENTS"
echo

find "$TARGET_DIR" -type f \
  | grep -Ev "$EXCLUDES" \
  | grep -Ei "\.($TEXT_EXT)$" \
  | sort \
  | while read -r file; do

    echo "------------------------------------------"
    echo "📄 FILE: $file"
    echo "------------------------------------------"

    LINES=$(wc -l < "$file")

    echo "Lines: $LINES"
    echo

    if [ "$LINES" -le "$MAX_LINES" ]; then
        cat "$file"
    else
        echo "⚠️ Truncated (showing first $MAX_LINES lines)"
        echo
        head -n "$MAX_LINES" "$file"
        echo
        echo "... [TRUNCATED] ..."
    fi

    echo
    echo
done

# ===============================
# Footer
# ===============================

echo "=========================================="
echo "✅ SNAPSHOT COMPLETE"
echo "=========================================="
echo "Paste this file into your LLM:"
echo "👉 $OUTPUT_FILE"

```

## 02. Image

```html
<!-- Solo figure (responsive width) -->
<div style="max-width: 70%; margin: 2rem auto; padding: 1.5rem; background: linear-gradient(145deg, #f8f9fa, #ffffff); border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);">
  <figure style="margin: 0;">
    <div style="overflow: hidden; border-radius: 8px; background: #fff;">
      <img 
        src="ukhona/img/your-image.jpg" 
        alt="Single figure description"
        style="width: 100%; height: auto; display: block;"
      >
    </div>
    <figcaption style="margin-top: 1rem; text-align: center; color: #555; font-style: italic; font-size: 0.95rem; line-height: 1.5;">
      Caption: Gradient descent in the loss landscape of Ibirunga
    </figcaption>
  </figure>
</div>

<!-- Two adjacent figures (stacks on mobile) -->
<div style="margin: 2rem auto; padding: 1.5rem; background: linear-gradient(145deg, #f8f9fa, #ffffff); border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);">
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(min(100%, 280px), 1fr)); gap: 1.5rem;">
    <figure style="margin: 0;">
      <div style="overflow: hidden; border-radius: 8px; background: #fff;">
        <img 
          src="ukhona/img/ant-scout.jpg" 
          alt="Stochastic ant scout foraging"
          style="width: 100%; height: auto; display: block;"
        >
      </div>
      <figcaption style="margin-top: 0.75rem; text-align: center; color: #555; font-style: italic; font-size: 0.9rem; line-height: 1.4;">
        Dionysian scout: high variance, most do not return
      </figcaption>
    </figure>
    <figure style="margin: 0;">
      <div style="overflow: hidden; border-radius: 8px; background: #fff;">
        <img 
          src="ukhona/img/pheromone-trail.jpg" 
          alt="Pheromone trail convergence"
          style="width: 100%; height: auto; display: block;"
        >
      </div>
      <figcaption style="margin-top: 0.75rem; text-align: center; color: #555; font-style: italic; font-size: 0.9rem; line-height: 1.4;">
        Apollonian convergence: gradient descent to the basin
      </figcaption>
    </figure>
  </div>
</div>

<!-- Three adjacent figures (stacks on mobile) -->
<div style="margin: 2rem auto; padding: 1.5rem; background: linear-gradient(145deg, #f8f9fa, #ffffff); border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);">
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(min(100%, 200px), 1fr)); gap: 1.25rem;">
    <figure style="margin: 0;">
      <div style="overflow: hidden; border-radius: 8px; background: #fff;">
        <img 
          src="ukhona/img/raindrop-impact.jpg" 
          alt="Raindrops terraforming flat surface"
          style="width: 100%; height: auto; display: block;"
        >
      </div>
      <figcaption style="margin-top: 0.75rem; text-align: center; color: #555; font-style: italic; font-size: 0.85rem; line-height: 1.4;">
        Stochastic impacts on flat ground → vaporize
      </figcaption>
    </figure>
    <figure style="margin: 0;">
      <div style="overflow: hidden; border-radius: 8px; background: #fff;">
        <img 
          src="ukhona/img/channel-erosion.jpg" 
          alt="Raindrops carving gradient channels"
          style="width: 100%; height: auto; display: block;"
        >
      </div>
      <figcaption style="margin-top: 0.75rem; text-align: center; color: #555; font-style: italic; font-size: 0.85rem; line-height: 1.4;">
        Gradient flow → erosion and basin formation
      </figcaption>
    </figure>
    <figure style="margin: 0;">
      <div style="overflow: hidden; border-radius: 8px; background: #fff;">
        <img 
          src="ukhona/img/deep-basin.jpg" 
          alt="Deep attractor basin after repeated descent"
          style="width: 100%; height: auto; display: block;"
        >
      </div>
      <figcaption style="margin-top: 0.75rem; text-align: center; color: #555; font-style: italic; font-size: 0.85rem; line-height: 1.4;">
        Lowered loss: new stable basin (UX)
      </figcaption>
    </figure>
  </div>
</div>
```


## 03. Image (for html)

```html

  <!-- Large image of The Dude at the very top -->
<section class="card hero-image-card">
  <div class="hero">
    <div class="hero-content">
      <h1 class="hero-title">2 Yohana 1:3</h1>
      <div class="hero-subtitle-group">
        <h2 class="hero-subtitle">Data → <a href="https://jhurepos.github.io/sgd-theology/">Signal</a> → Meaning</h2>
        <h3 class="hero-meta">Altitude · Gradient · Basin</h3>
      </div>
    </div>
    <figure class="hero-figure">
      <div class="image-wrapper">
        <img 
          src="ukhona/img/rx.jpg" 
          alt="The Dude with his Rug" 
          class="hero-image"
        >
      </div>
      <figcaption class="hero-caption">Ibirunga, Mifumbiro</figcaption>
    </figure>
  </div>   
</section>

<style>
.hero {
  position: relative;
  overflow: hidden;
}

.hero-content {
  padding: 2.5rem 1.5rem;
  background: linear-gradient(135deg, rgba(15, 23, 42, 0.95) 0%, rgba(30, 41, 59, 0.9) 100%);
  color: white;
  text-align: center;
}

.hero-title {
  font-size: clamp(1.75rem, 4vw, 3rem);
  font-weight: 700;
  letter-spacing: -0.02em;
  margin: 0 0 1.5rem 0;
  line-height: 1.2;
  background: linear-gradient(to right, #ffffff, #e2e8f0);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: center;
}

.hero-subtitle {
  font-size: clamp(1rem, 2.5vw, 1.5rem);
  font-weight: 500;
  margin: 0;
  color: #94a3b8;
  letter-spacing: 0.05em;
  font-family: 'Courier New', monospace;
}

.hero-meta {
  font-size: clamp(0.875rem, 2vw, 1.125rem);
  font-weight: 300;
  margin: 0;
  color: #64748b;
  letter-spacing: 0.15em;
}

.hero-figure {
  margin: 0;
  position: relative;
}

.image-wrapper {
  position: relative;
  overflow: hidden;
  background: #0f172a;
}

.hero-image {
  width: 100%;
  height: auto;
  display: block;
  transition: transform 0.6s ease;
}

.hero-image:hover {
  transform: scale(1.02);
}

.hero-caption {
  text-align: center;
  font-style: italic;
  font-size: 0.9rem;
  color: #64748b;
  padding: 1rem;
  background: linear-gradient(to bottom, transparent, rgba(15, 23, 42, 0.05));
  margin: 0;
  letter-spacing: 0.02em;
}

/* Responsive adjustments */
@media (min-width: 768px) {
  .hero-content {
    padding: 3.5rem 2rem;
  }
  
  .hero-caption {
    font-size: 1rem;
    padding: 1.25rem;
  }
}
</style>
```

## 04. YouTube

```html
<figure style="display: flex; flex-direction: column; align-items: center; width: 100%; margin: 2rem 0;">
  <iframe
    width="56%"
    height="315"
    src="https://www.youtube.com/embed/-RPbxvz6sB8?start=240"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen>
  </iframe>
  <figcaption style="margin-top: 0.5rem; font-size: 0.85em; color: #555; text-align: center;">
    Google DeepMind chief warns AI investment looks ‘bubble-like’ (8:49) | FT Interview
  </figcaption>
</figure>
```

## 05. PDF

```html
<figure style="display: flex; flex-direction: column; align-items: center; width: 100%; margin: 2rem 0;">
  <iframe
    src="ukhona/obesity_lkd.pdf"
    width="56%"
    height="600"
    style="border: 1px solid #ddd;"
    title="Obesity LKD Manuscript">
  </iframe>
  <figcaption style="margin-top: 0.5rem; font-size: 0.85em; color: #555; text-align: center;">
    Obesity & Low-Carbohydrate Ketogenic Diet — Working Manuscript (PDF)
  </figcaption>
</figure>

```

## 06. API (private or public)

```sh
#!/usr/bin/env bash
set -e

echo "=== GitHub Pages Hard Bootstrap (Public/Private) ==="

read -p "GitHub username: " GH_USER
read -p "Repository name: " GH_REPO
# Added visibility prompt
read -p "Make repository private? (y/N): " PRIVATE_INPUT
read -s -p "GitHub Personal Access Token: " GH_TOKEN
echo

# Logic to determine boolean string for JSON
if [[ "$PRIVATE_INPUT" =~ ^[Yy]$ ]]; then
  IS_PRIVATE="true"
  echo ">> Setting mode: PRIVATE"
else
  IS_PRIVATE="false"
  echo ">> Setting mode: PUBLIC"
fi

API="https://api.github.com"
REPO_API="$API/repos/$GH_USER/$GH_REPO"

# ---- create repo if missing ----
# We inject $IS_PRIVATE into the JSON payload
curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: token $GH_TOKEN" \
  "$REPO_API" | grep -q 200 || \
curl -s -X POST "$API/user/repos" \
  -H "Authorization: token $GH_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d "{
    \"name\": \"$GH_REPO\",
    \"private\": $IS_PRIVATE,
    \"auto_init\": false
  }" >/dev/null

# ---- local setup ----
mkdir -p "$GH_REPO"
cd "$GH_REPO"

git init
git checkout -B ukhona

# ---- content ----
cat <<EOF > index.md
# GitHub Pages is live

Bootstrap successful.
Repo Visibility: $IS_PRIVATE
EOF

git add index.md
git commit -m "bootstrap gh-pages"

# ---- remote ----
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GH_USER:$GH_TOKEN@github.com/$GH_USER/$GH_REPO.git"

# ---- FORCE ALIGN (intentional) ----
git push -f origin ukhona

# ---- enable Pages ----
# Note: GitHub Pages on Private repos requires a Pro account
curl -s -X POST "$REPO_API/pages" \
  -H "Authorization: token $GH_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d '{
    "source": { "branch": "ukhona", "path": "/" }
  }' >/dev/null || true

echo
echo "======================================"
echo "LIVE (may take ~30s):"
echo "https://$GH_USER.github.io/$GH_REPO/"
echo "======================================"
```

## 07. Tree

```sh
#!/bin/bash

# bash <(curl -s https://raw.githubusercontent.com/abikesa/directory-tree/refs/heads/main/summarize.sh) ./
# === Config === ./summarize.sh ukubona-llc.github.io --raw
TARGET_DIR=""
DEPTH=3
OUTPUT_MD=false
FILTER_EXCLUDES=true
OUTPUT_JSON=false
OUTPUT_XML=false
OUTPUT_HAIKU=false
DEFAULT_EXCLUDES=".git|node_modules|__pycache__|env|.venv|myenv|_build"

# === Parse flags ===
for arg in "$@"; do
    case $arg in
        --deep) DEPTH=10 ;;
        --md) OUTPUT_MD=true ;;
        --raw) FILTER_EXCLUDES=false ;;
        --json) OUTPUT_JSON=true ;;
        --xml) OUTPUT_XML=true ;;
        --haiku) OUTPUT_HAIKU=true ;;
        *) TARGET_DIR=$arg ;;
    esac
done

# === Validate target ===
if [ -z "$TARGET_DIR" ]; then
    echo "❗ Please specify a target directory."
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Directory not found: $TARGET_DIR"
    exit 1
fi

# === Markdown output safe redirect ===
if $OUTPUT_MD; then
    mkdir -p "$TARGET_DIR"
    exec > "${TARGET_DIR}/summary.md"
fi

# === Count stuff ===
TOTAL_FILES=$(find "$TARGET_DIR" -type f | wc -l)
TOTAL_DIRS=$(find "$TARGET_DIR" -type d | wc -l)

HTML_COUNT=$(find "$TARGET_DIR" -type f -iname "*.html" | wc -l)
MD_COUNT=$(find "$TARGET_DIR" -type f -iname "*.md" | wc -l)
PY_COUNT=$(find "$TARGET_DIR" -type f -iname "*.py" | wc -l)
JS_COUNT=$(find "$TARGET_DIR" -type f -iname "*.js" | wc -l)
CSS_COUNT=$(find "$TARGET_DIR" -type f -iname "*.css" | wc -l)
IMG_COUNT=$(find "$TARGET_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.svg" -o -iname "*.gif" \) | wc -l)
CFF_COUNT=$(find "$TARGET_DIR" -type f -iname "*.cff" | wc -l)
ZIP_COUNT=$(find "$TARGET_DIR" -type f \( -iname "*.zip" -o -iname "*.tar" -o -iname "*.gz" -o -iname "*.bz2" -o -iname "*.xz" \) | wc -l)

# === JSON/XML/Haiku output ===
if $OUTPUT_JSON; then
  cat <<EOF
{
  "directory": "$TARGET_DIR",
  "files": $TOTAL_FILES,
  "folders": $TOTAL_DIRS,
  "html": $HTML_COUNT,
  "markdown": $MD_COUNT,
  "python": $PY_COUNT,
  "javascript": $JS_COUNT,
  "css": $CSS_COUNT,
  "images": $IMG_COUNT,
  "citation": $CFF_COUNT,
  "compressed": $ZIP_COUNT
}
EOF
  exit 0
fi

if $OUTPUT_XML; then
  cat <<EOF
<summary>
  <directory>$TARGET_DIR</directory>
  <files>$TOTAL_FILES</files>
  <folders>$TOTAL_DIRS</folders>
  <html>$HTML_COUNT</html>
  <markdown>$MD_COUNT</markdown>
  <python>$PY_COUNT</python>
  <javascript>$JS_COUNT</javascript>
  <css>$CSS_COUNT</css>
  <images>$IMG_COUNT</images>
  <citation>$CFF_COUNT</citation>
  <compressed>$ZIP_COUNT</compressed>
</summary>
EOF
  exit 0
fi

if $OUTPUT_HAIKU; then
  echo "Folders like forests,"
  echo "Code and silence intertwined—"
  echo "$TOTAL_FILES seeds bloom."
  exit 0
fi

# === Header ===
echo "📁 Scanning directory: $TARGET_DIR"
echo
echo "🗂️  Total files:      $TOTAL_FILES"
echo "📂 Total folders:     $TOTAL_DIRS"
echo
echo "🧾 File breakdown:"
printf "  📄 HTML files       : %5d\n" $HTML_COUNT
printf "  📓 Markdown files   : %5d\n" $MD_COUNT
printf "  🐍 Python files     : %5d\n" $PY_COUNT
printf "  📜 JavaScript files : %5d\n" $JS_COUNT
printf "  🎨 CSS files        : %5d\n" $CSS_COUNT
printf "  🖼️  Image files      : %5d\n" $IMG_COUNT
printf "  🧾 Citation (.cff)  : %5d\n" $CFF_COUNT
printf "  📦 Compressed files : %5d\n" $ZIP_COUNT
echo

# === Folder structure ===
echo "📚 Folder structure (first $DEPTH levels):"
echo "$TARGET_DIR"

TREE_OUTPUT=$(find "$TARGET_DIR" -mindepth 1 -maxdepth $DEPTH \
  | { $FILTER_EXCLUDES && grep -Ev "$DEFAULT_EXCLUDES" || cat; } \
  | sed "s|$TARGET_DIR/||" \
  | sort \
  | awk -F/ '
{
    indent = ""
    for (i = 1; i < NF; i++) indent = indent "│   "
    fname = $NF
    emoji = ""

    if (fname ~ /^\./) {
        hidden = " (hidden)"
    } else {
        hidden = ""
    }

    if (fname ~ /\.md$/) {
        emoji = "📓 "
    } else if (fname ~ /\.cff$/) {
        emoji = "🧾 "
    } else if (fname ~ /\.html$/) {
        emoji = "📄 "
    } else if (fname ~ /\.py$/) {
        emoji = "🐍 "
    } else if (fname ~ /\.js$/) {
        emoji = "📜 "
    } else if (fname ~ /\.css$/) {
        emoji = "🎨 "
    } else if (fname ~ /\.(png|jpg|jpeg|svg|gif)$/) {
        emoji = "🖼️  "
    } else if (fname ~ /\.(zip|tar|gz|bz2|xz)$/) {
        emoji = "📦 "
    } else if ($0 ~ /\/$/ || $0 !~ /\./) {
        emoji = "📁 "
    }

    print indent "├── " emoji fname hidden
}')

if [ -z "$TREE_OUTPUT" ]; then
    echo "  (no visible structure within $DEPTH levels)"
else
    echo "$TREE_OUTPUT"
fi

echo
echo "✅ Done scanning."
```

## 08. Danger!

`cleanup_except.sh`


```sh
#!/usr/bin/env bash
set -euo pipefail

# DIRECTORIES (or files) TO KEEP — adjust these
KEEP=(
  "important_dir"
  "another_dir"
  "keep_this_file.txt"
)

# Convert KEEP into find arguments
KEEP_EXPR=()
for k in "${KEEP[@]}"; do
  KEEP_EXPR+=( ! -name "$k" )
done

echo "About to delete everything EXCEPT:"
printf '  - %s\n' "${KEEP[@]}"
echo
read -p "Continue? (y/N): " ans
[[ "$ans" == "y" ]] || exit 1

# Delete everything except the whitelisted items
find . -mindepth 1 -maxdepth 1 "${KEEP_EXPR[@]}" -exec rm -rf {} +

```

## 09. LaTeX

```html
<!-- Drop this anywhere in your README.md or page HTML -->
<script>
  window.MathJax = {
    tex: {
      inlineMath: [['$', '$'], ['\\(', '\\)']],
      displayMath: [['$$','$$'], ['\\[','\\]']],
      processEscapes: true
    },
    options: {
      skipHtmlTags: ['script','noscript','style','textarea','pre','code']
    }
  };
</script>
<script id="MathJax-script" async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
</script>

```

# 10. Favicon

```html
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>Ukubona LLC - Health Tech for Customized Care</title>
  <meta name="description" content="Ukubona builds AI-powered health tech for customized care.">
  <link rel="canonical" href="https://ukubona-llc.github.io/">
  <meta name="robots" content="index,follow">
  <meta name="color-scheme" content="dark light">
  <meta name="theme-color" content="#0a0a0f">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="Ukubona LLC">
  <meta property="og:title" content="Ukubona — The Game of Care">
  <meta property="og:description" content="Healthcare reimagined as sequential, consequential play. Try a scenario.">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://ukubona-llc.github.io/">
  <meta property="og:image" content="https://ukubona-llc.github.io/assets/img/to-screen.jpeg">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Ukubona — The Game of Care">
  <meta name="twitter:description" content="Healthcare reimagined as sequential, consequential play. Try a scenario.">
  <meta name="twitter:image" content="https://ukubona-llc.github.io/assets/img/to-screen.jpeg">

  <!-- Icons / assets -->
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-light.ico" type="image/x-icon">
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-light.ico" media="(prefers-color-scheme: light)">
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-dark.ico" media="(prefers-color-scheme: dark)">
  <link rel="preload" href="https://abikesa.github.io/logos/assets/ukubona-light.png" as="image">
  <link rel="preload" href="https://abikesa.github.io/logos/assets/ukubona-dark.png" as="image">

  <!-- Perf: preconnect fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <!-- CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="assets/css/main.css">
  <link rel="stylesheet" href="assets/css/index.css">
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <!-- Centralized header fetch -->
  <header class="header" id="header"></header>

  <!-- Page sections populated by your partials/scripts -->
  <section class="hero" id="hero"></section>
  <main class="main-content">
    <section class="services-section" id="services-section"></section>
    <section class="metrics-section" id="metrics-section"></section>
  </main>

  <div class="modal-overlay" id="modal-overlay"></div>

  <!-- Centralized footer fetch -->
  <div id="footer-placeholder"></div>

  <!-- Scripts (Order matters!! Feather, shared, then page code) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="assets/js/landing.js"></script>
  <script src="assets/js/index.js"></script>
  <script src="assets/js/shared.js"></script>
  <script src="assets/js/tooltips.js"></script>
</body>
</html>

```

# 11. UKB-Relativity

```txt
Deleted it / Review Decision
```

# 12. Static / Website (Scaffold)

See `ukhona/static.sh`

# 13. Dynamic / Flask (Scaffold)

See `ukhona/dynamic.sh`

# 14. Onboarding Windows (Drama)

```sh
eval "$(pyenv virtualenv-init -)"
root@gabes:~# pyenv install 3.11.12
```

Check your shell configuration and Pyenv and Pyenv-Virtualenv installation instructions.

```sh
root@gabes:~# python3 -m venv .venv
```

The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

```sh
   apt install python3.10-venv
```
You may need to use sudo with that command.  After installing the python3-venv
package, recreate your virtual environment.


Failing command: /root/.venv/bin/python3

```sh
root@gabes:~#    apt install python3.10-venv
root@gabes:~# pyenv install 3.11.12
(myenv) root@gabes:~# pip install pandas matplotlib seaborn plotly jupyter
To update, run: python -m pip install --upgrade pip
(myenv) root@gabes:~#
```

# 15. `cryo-pyro/repo` 

```sh
python3 analyze_repo.py --root . --max-depth 10 --ignore .cache
```

`analyze_repo.py`

```py
#!/usr/bin/env python3
"""
Ukubona repo explorer & coherence audit

- Walks the directory
- Renders an ASCII tree (repo_tree.txt)
- Writes a Markdown report (ukubona_audit.md)
- Emits a JSON inventory (ukubona_inventory.json)
- Clusters HTML <header> / <footer> blocks to find common vs. divergent variants

Usage:
  python analyze_repo.py --root . --max-depth 8 --ignore .git node_modules dist build .venv

Tip:
  Run from the repo root in VSCode's terminal.
"""

import argparse, os, sys, re, json, hashlib, textwrap
from collections import defaultdict, Counter
from datetime import datetime

DEFAULT_IGNORES = {'.git','node_modules','dist','build','.venv','venv','__pycache__','.DS_Store'}

DISCLAIMER_PATTERNS = [
    r'not\s+fda\s+approved',
    r'not\s+medical\s+advice',
    r'this\s+is\s+play,\s*not\s+prescription',
    r'this\s+is\s+rehearsal,\s*not\s+remedy',
    r'this\s+is\s+simulation,\s*not\s+salvation',
    r'trials,\s*not\s+intimacy',
    r'sawubona', r'ngikhona', r'ukukona', r'ukubona', r'ukuvula', r'ukuzula', r'ukukula'
]

HTML_HEADER_RE = re.compile(r'<header\b[^>]*>(.*?)</header>', re.DOTALL|re.IGNORECASE)
HTML_FOOTER_RE = re.compile(r'<footer\b[^>]*>(.*?)</footer>', re.DOTALL|re.IGNORECASE)
HTML_TITLE_RE  = re.compile(r'<title>(.*?)</title>', re.IGNORECASE|re.DOTALL)

def human(n):
    for u in ['B','KB','MB','GB','TB']:
        if n < 1024 or u=='TB': return f"{n:.1f}{u}" if u!='B' else f"{int(n)}{u}"
        n/=1024

def sha1(text):
    return hashlib.sha1(text.encode('utf-8', 'ignore')).hexdigest()

def is_binary(path):
    try:
        with open(path, 'rb') as f:
            chunk = f.read(1024)
        return b'\0' in chunk
    except Exception:
        return True

def read_text(path):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception:
        try:
            with open(path, 'r', encoding='latin-1') as f:
                return f.read()
        except Exception:
            return ""

def walk(root, max_depth, ignores):
    inventory = []
    for dirpath, dirnames, filenames in os.walk(root):
        # prune ignores
        dirnames[:] = [d for d in dirnames if d not in ignores]
        # depth check
        rel = os.path.relpath(dirpath, root)
        depth = 0 if rel == '.' else rel.count(os.sep)+1
        if depth > max_depth:
            dirnames[:] = []
            continue
        for name in filenames:
            full = os.path.join(dirpath, name)
            try:
                st = os.stat(full)
                size = st.st_size
                mtime = st.st_mtime
            except Exception:
                size, mtime = 0, 0
            ext = os.path.splitext(name)[1].lower().lstrip('.')
            inventory.append({
                "path": os.path.relpath(full, root),
                "dir": os.path.relpath(dirpath, root),
                "name": name,
                "ext": ext,
                "size": size,
                "mtime": mtime
            })
    return inventory

def make_tree(inventory):
    # Build nested dict
    root = {}
    for item in inventory:
        parts = item['path'].split(os.sep)
        cur = root
        for i, p in enumerate(parts):
            if i == len(parts)-1:
                cur.setdefault('__files__', []).append(item)
            else:
                cur = cur.setdefault(p, {})
    lines = []
    def recur(node, prefix=""):
        files = node.get('__files__', [])
        dirs  = [(k,v) for k,v in node.items() if k!='__files__']
        dirs.sort()
        for i,(k,v) in enumerate(dirs):
            is_last = (i == len(dirs)-1) and not files
            lines.append(f"{prefix}{'└── ' if is_last else '├── '}{k}/")
            recur(v, prefix + ("    " if is_last else "│   "))
        for j,f in enumerate(sorted(files, key=lambda x:x['name'])):
            is_last = (j == len(files)-1)
            lines.append(f"{prefix}{'└── ' if is_last else '├── '}{f['name']}  ({human(f['size'])})")
    recur(root)
    return "\n".join(lines)

def cluster_blocks(html_paths, root):
    clusters = {
        "headers": defaultdict(list),
        "footers": defaultdict(list),
    }
    titles = {}
    for p in html_paths:
        abs_p = os.path.join(root, p)
        txt = read_text(abs_p)
        if not txt: continue
        title = None
        mt = HTML_TITLE_RE.search(txt)
        if mt:
            title = " ".join(mt.group(1).split())
            titles[p] = title
        # header
        mh = HTML_HEADER_RE.search(txt)
        if mh:
            block = mh.group(1).strip()
            digest = sha1(block)
            clusters["headers"][digest].append(p)
        # footer
        mf = HTML_FOOTER_RE.search(txt)
        if mf:
            block = mf.group(1).strip()
            digest = sha1(block)
            clusters["footers"][digest].append(p)
    return clusters, titles

def sniff_disclaimers(paths, root):
    hits = defaultdict(list)
    compiled = [(pat, re.compile(pat, re.IGNORECASE)) for pat in DISCLAIMER_PATTERNS]
    for p in paths:
        abs_p = os.path.join(root, p)
        if is_binary(abs_p): continue
        content = read_text(abs_p)
        if not content: continue
        low = content.lower()
        matched = []
        for label, rx in compiled:
            if rx.search(low):
                matched.append(label)
        if matched:
            hits[p] = matched
    return hits

def main():
    ap = argparse.ArgumentParser(description="Ukubona repo structure & coherence audit")
    ap.add_argument("--root", default=".", help="Repo root")
    ap.add_argument("--max-depth", type=int, default=12, help="Max directory depth to traverse")
    ap.add_argument("--ignore", nargs="*", default=[], help="Extra directory names to ignore")
    args = ap.parse_args()

    root = os.path.abspath(args.root)
    ignores = DEFAULT_IGNORES.union(set(args.ignore))

    inv = walk(root, args.max_depth, ignores)
    if not inv:
        print("No files found. Check --root path.", file=sys.stderr)
        sys.exit(1)

    # Tree
    tree_txt = make_tree(inv)
    with open(os.path.join(root, "repo_tree.txt"), "w", encoding="utf-8") as f:
        f.write(tree_txt)

    # Stats
    by_ext = Counter([i['ext'] for i in inv])
    size_by_ext = defaultdict(int)
    for i in inv:
        size_by_ext[i['ext']] += i['size']

    # Largest files (html/css/js)
    def topn(exts, n=12):
        subset = [i for i in inv if i['ext'] in exts]
        subset.sort(key=lambda x:x['size'], reverse=True)
        return subset[:n]

    tops_html = topn({'html','htm'})
    tops_css  = topn({'css'})
    tops_js   = topn({'js','mjs'})

    # HTML analysis
    html_paths = [i['path'] for i in inv if i['ext'] in {'html','htm'}]
    clusters, titles = cluster_blocks(html_paths, root)
    disclaimers = sniff_disclaimers([i['path'] for i in inv if i['ext'] in {'html','md'}], root)

    # Write JSON inventory
    inv_out = {
        "generated_at": datetime.utcnow().isoformat() + "Z",
        "root": root,
        "ignores": sorted(list(ignores)),
        "counts_by_ext": dict(by_ext),
        "sizes_by_ext": {k: size_by_ext[k] for k in sorted(size_by_ext)},
        "largest_html": tops_html,
        "largest_css": tops_css,
        "largest_js": tops_js,
        "html_titles": titles,
        "header_clusters": {k: v for k,v in clusters["headers"].items()},
        "footer_clusters": {k: v for k,v in clusters["footers"].items()},
        "disclaimer_hits": disclaimers
    }
    with open(os.path.join(root, "ukubona_inventory.json"), "w", encoding="utf-8") as f:
        json.dump(inv_out, f, indent=2)

    # Markdown report
    def section(title): return f"\n\n## {title}\n\n"
    md = []
    md.append(f"# Ukubona Repo Audit\n\nGenerated: {datetime.utcnow().isoformat()}Z\nRoot: `{root}`")
    md.append(section("Directory Tree (excerpt)"))
    md.append("```text\n" + "\n".join(tree_txt.splitlines()[:400]) + ("\n… (see repo_tree.txt for full)\n" if len(tree_txt.splitlines())>400 else "\n") + "```")

    md.append(section("Counts by Extension"))
    md.append("| Ext | Count | Size |")
    md.append("|-----|------:|-----:|")
    for ext, cnt in by_ext.most_common():
        md.append(f"| .{ext or '(none)'} | {cnt} | {human(size_by_ext[ext])} |")

    def list_top(title, rows):
        md.append(section(title))
        if not rows:
            md.append("_None found_")
            return
        md.append("| Path | Size |")
        md.append("|------|-----:|")
        for r in rows:
            md.append(f"| `{r['path']}` | {human(r['size'])} |")

    list_top("Largest HTML (focus for headers/footers/polish)", tops_html)
    list_top("Largest CSS (global styles to centralize footers/headers)", tops_css)
    list_top("Largest JS (behavior that may need coherence)", tops_js)

    # Header/Footer clusters
    def cluster_table(kind, d):
        md.append(section(f"{kind.title()} clusters (same block → same hash)"))
        if not d:
            md.append("_None detected (no <{}> tags found)_".format(kind[:-1]))
            return
        rows = sorted(d.items(), key=lambda kv: (-len(kv[1]), kv[0]))
        for digest, files in rows:
            md.append(f"**Cluster {kind[:-1]} {digest[:8]}** — {len(files)} file(s):")
            for p in files[:20]:
                md.append(f"- `{p}`")
            if len(files) > 20:
                md.append(f"- … and {len(files)-20} more")
            md.append("")
        # Suggest action
        md.append("> **Action:** Convert the largest cluster into a shared partial (or consistent snippet) and replace outliers.")

    cluster_table("headers", clusters["headers"])
    cluster_table("footers", clusters["footers"])

    # Disclaimer hits
    md.append(section("Disclaimer / Chorus Sniffer"))
    if not disclaimers:
        md.append("_No matching phrases found in HTML/MD files._")
    else:
        md.append("| File | Phrases Matched |")
        md.append("|------|-----------------|")
        for p, pats in sorted(disclaimers.items()):
            md.append(f"| `{p}` | {', '.join(sorted(set(pats)))} |")
        md.append("\n> **Action:** Standardize on the liturgical chorus. Replace legacy “Not medical advice / Not FDA approved” with:\n> _This is play, not prescription. This is rehearsal, not remedy. This is simulation, not salvation. Trials, not intimacy._")

    # Titles sanity
    md.append(section("HTML <title> overview"))
    if not titles:
        md.append("_No <title> tags found._")
    else:
        md.append("| File | <title> |")
        md.append("|------|---------|")
        for p,t in sorted(titles.items()):
            md.append(f"| `{p}` | {t.replace('|','/')} |")

    report = "\n".join(md)
    with open(os.path.join(root, "ukubona_audit.md"), "w", encoding="utf-8") as f:
        f.write(report)

    print("✅ Wrote:")
    print(" - repo_tree.txt (full tree)")
    print(" - ukubona_audit.md (human report)")
    print(" - ukubona_inventory.json (machine inventory)")
    print("\nTop suggestions:")
    print(" 1) Unify the largest header/footer clusters as shared partials.")
    print(" 2) Replace legacy disclaimers with the chorus, consistently.")
    print(" 3) Start with the largest HTML/CSS/JS files flagged above.")
    print("\nOpen `ukubona_audit.md` in VSCode preview for the plan of attack.")

if __name__ == "__main__":
    main()
```

# 16 `ukb-dt/repo-00 -> cryo-pyro/repo-00`

- footer
- header
- etc

# 17 `eplnm/tin`
# 18 `ukb-dt or cryo-pyro/repos-00`

`index.html`
```html
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Smart Journaling</title>
  <meta name="color-scheme" content="dark light" />
  <meta name="theme-color" content="#0a0a0f" />
  <meta name="description" content="The Dude's Rug.">
  <link rel="canonical" href="https://ukb-dt.github.io/repos-00/">
  <meta name="robots" content="index,follow">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="Repos">
  <meta property="og:title" content="The Dude's Rug">
  <meta property="og:description" content="Saddle Point">
  <meta property="og:type" content="blog">
  <meta property="og:url" content="https://ukb-dt.github.io/repos-00/">
  <meta property="og:image" content="ukhona/img/ukb-landscape.jpg">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="The Dude's Rug">
  <meta name="twitter:description" content="Saddle Point">
  <meta name="twitter:image" content="ukhona/img/ukb-landscape.jpg"> 

  <!-- Icons / assets -->
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-light.ico" type="image/x-icon">
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-light.ico" media="(prefers-color-scheme: light)">
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-dark.ico" media="(prefers-color-scheme: dark)">
  <link rel="preload" href="https://abikesa.github.io/logos/assets/ukubona-light.png" as="image">
  <link rel="preload" href="https://abikesa.github.io/logos/assets/ukubona-dark.png" as="image">

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  
  <!-- CSS IN ORDER: Variables → Base → Components → Footer -->
  <link href="ukhona/css/variables.css" rel="stylesheet" />
  <link href="ukhona/css/head.css" rel="stylesheet" />
  <link href="ukhona/css/card.css" rel="stylesheet" />
  <link href="ukhona/css/footer.css" rel="stylesheet" />
  
  <!-- MathJax -->
  <script id="MathJax-script" defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <header class="header" id="header"></header>

  <main class="page wrap-max">
    <section class="card">
      <!-- Your content here -->
    </section>
  </main>

  <div id="footer-placeholder"></div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="ukhona/js/shared.js"></script>
</body> 
</html>
```

# 19. `ukhona/html/template.html`

```html
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Ukhona — An Accounting of Survival</title>
  <meta name="color-scheme" content="dark light" />
  <meta name="theme-color" content="#0a0a0f" />
  <meta name="description" content="The Dude's Rug.">
  <link rel="canonical" href="https://ukb-dt.github.io/repos-00/">
  <meta name="robots" content="index,follow">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="Repos">
  <meta property="og:title" content="The Dude's Rug">
  <meta property="og:description" content="Saddle Point">
  <meta property="og:type" content="blog">
  <meta property="og:url" content="https://ukb-dt.github.io/repos-00/">
  <meta property="og:image" content="../img/ukb-landscape.jpg">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="The Dude's Rug">
  <meta name="twitter:description" content="Saddle Point">
  <meta name="twitter:image" content="../img/ukb-landscape.jpg"> 

  <!-- Icons / assets -->
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-light.ico" type="image/x-icon">
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-light.ico" media="(prefers-color-scheme: light)">
  <link rel="icon" href="https://abikesa.github.io/favicon/assets/favicon-dark.ico" media="(prefers-color-scheme: dark)">
  <link rel="preload" href="https://abikesa.github.io/logos/assets/ukubona-light.png" as="image">
  <link rel="preload" href="https://abikesa.github.io/logos/assets/ukubona-dark.png" as="image">

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  
  <!-- CSS IN ORDER: Variables → Base → Components → Footer -->
  <link href="../css/variables.css" rel="stylesheet" />
  <link href="../css/head.css" rel="stylesheet" />
  <link href="../css/card.css" rel="stylesheet" />
  <link href="../css/footer.css" rel="stylesheet" />
  
  <!-- MathJax -->
  <script src="../js/mathjax.js"></script>
  <script id="MathJax-script" defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <header class="header" id="header"></header>

  <main class="page wrap-max">
    <section class="card">
      <h1>Musick</h1>
      <h2>∅</h2>
      <h3>B$^{\flat\varnothing}$</h3>

      <figure style="display: flex; flex-direction: column; align-items: center; width: 100%; margin: 2rem 0;">
        <iframe
          width="65%"
          height="315"
          src="https://www.youtube.com/embed/RY-3oEcwwzc?start=595"
          title="YouTube video player"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen>
        </iframe>
        <figcaption style="margin-top: 0.5rem; font-size: 0.85em; color: var(--text-secondary); text-align: center;">
          Mozart as star. Beethoven as Raindrop | Pop → Star, <a href="https://ukb-dt.github.io/repos-00/">Art</a> → Raindrop
        </figcaption>
      </figure>
    </section>
  </main>

  <div id="footer-placeholder"></div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="../js/shared.js"></script>
</body>
</html>
```

# 20. `ukhona/html/footer.html`

```html
<footer class="footer">
  <div class="wrap-max footer-wrap">
    <div class="footer-chorus rotating-chorus" data-interval="60000">
      <span class="chip">To see, blindly</span>
      <span class="chip">To forage, stochastically</span>
      <span class="chip">To rehearse, consequentially</span>
    </div>
    <div class="footer-micro">
        <p>
             © 2026 <a href="https://ukubona-llc.github.io/">Ukubona LLC</a>. All rights reserved.
        </p>

    </div>
  </div>
</footer>
```

# 21. `ukhona/html/header.html`

```html
<div class="nav-container wrap-max">
  <img src="https://abikesa.github.io/logos/assets/ukubona-dark.png" 
       alt="Ukubona LLC Logo" 
       id="logo" 
       class="logo" 
       data-light-src="https://abikesa.github.io/logos/assets/ukubona-light.png"
       data-dark-src="https://abikesa.github.io/logos/assets/ukubona-dark.png" />
  <div class="top-right">
    <ul class="nav-links">
      <li><a href="/" class="nav-link" data-nav="home">Home</a></li>
    </ul>
    <button class="menu-icon" id="menuIcon" role="button" aria-label="Open navigation menu">
      <div></div><div></div><div></div>
      <div></div><div></div><div></div>
      <div></div><div></div><div></div>
    </button>
    <button id="toggle-theme" aria-label="Toggle theme">🌙</button>
  </div>
</div>

<div class="app-grid wrap-max" id="gridMenu" aria-hidden="true">
  <a href="/"><div class="icon-box">📊</div>Home</a>
  <a href="/ukhona/html/template.html"><div class="icon-box">🎮</div>Template</a>
</div>
```

# 22. `ukhona/css/card.css`
```css
/* ========== CARD-SPECIFIC STYLES ========== */

/* Main card styling - NO TOP MARGIN (let head.css .page handle spacing) */
.card {
  max-width: 720px; 
  margin: 0 auto 64px; /* 0 top, auto sides, 64px bottom */
  text-align: left;
  background: rgba(255, 255, 255, 0.05); 
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px; 
  padding: 32px 24px; 
  box-shadow: 0 6px 28px rgba(0, 0, 0, 0.45);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 35px rgba(0, 0, 0, 0.55);
}

/* Card logo */
.card-logo { 
  max-width: 140px; 
  margin-bottom: 14px; 
  border-radius: 8px;
  transition: transform 0.3s ease;
}

.card-logo:hover {
  transform: scale(1.05);
}

/* Card headings */
.card-title { 
  margin: 0; 
  font-size: 2rem; 
  font-weight: 800; 
  color: var(--text);
  background: var(--primary-gradient);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-align: left;
}

.card-subtitle { 
  margin: 6px 0 16px; 
  font-weight: 600; 
  opacity: 0.9; 
  font-size: 1.15rem; 
  color: var(--text-secondary);
  text-align: left;
}

/* Bio sections */
.bio {
  opacity: 0.95; 
  font-size: 0.95rem; 
  line-height: 1.65; 
  margin: 0 auto; 
  max-width: 70ch; 
  text-align: left;
  color: var(--text);
}

.bio-secondary {
  margin-top: 10px;
}

.bio strong {
  color: var(--text);
  font-weight: 600;
}

/* Badges */
.badges {
  margin: 20px auto 0; 
  display: flex; 
  flex-wrap: wrap; 
  justify-content: center; 
  gap: 10px;
  max-width: 70ch;
}

.badge {
  background: rgba(255, 255, 255, 0.08); 
  border: 1px solid rgba(255, 255, 255, 0.2);
  padding: 8px 14px; 
  border-radius: 999px; 
  font-size: 0.9rem; 
  font-weight: 500;
  white-space: nowrap;
  color: var(--text-secondary);
  transition: all 0.3s ease;
}

.badge:hover {
  background: rgba(102, 126, 234, 0.15);
  border-color: rgba(102, 126, 234, 0.4);
  color: var(--text);
  transform: translateY(-1px);
}

/* CTA row */
.cta-row {
  margin-top: 22px; 
  display: flex; 
  flex-wrap: wrap; 
  justify-content: center; 
  gap: 14px;
}

a.cta {
  text-decoration: none; 
  padding: 0.9rem 1.4rem; 
  border-radius: 12px; 
  font-weight: 600;
  transition: transform 0.2s ease, box-shadow 0.3s ease;
  display: inline-flex; 
  align-items: center; 
  gap: 8px;
  font-size: 0.95rem;
}

a.cta:hover { 
  transform: translateY(-2px); 
}

.primary { 
  background: linear-gradient(135deg, #6366f1, #8b5cf6); 
  color: white;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.primary:hover {
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.secondary { 
  background: rgba(255, 255, 255, 0.08); 
  border: 1px solid rgba(255, 255, 255, 0.2); 
  color: white;
  backdrop-filter: blur(10px);
}

.secondary:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.3);
}

/* Responsive design */
@media (max-width: 768px) {
  .card {
    margin: 0 auto 48px;
    padding: 24px 20px;
    max-width: 90%;
  }
  
  .card-title {
    font-size: 1.75rem;
  }
  
  .card-subtitle {
    font-size: 1rem;
  }
  
  .bio {
    font-size: 0.9rem;
    max-width: none;
  }
  
  .cta-row {
    flex-direction: column;
    align-items: center;
  }
  
  a.cta {
    width: 100%;
    justify-content: center;
  }
}
```

# 23. `ukhona/css/footer.css`
```css
/* ========================================
   FOOTER.CSS - Centered Footer Styles
   ======================================== */

.footer {
    text-align: center;
    padding: 4rem 2rem;
    border-top: 1px solid var(--border);
    margin-top: 4rem;
    background: var(--surface);
}

.footer-wrap {
    max-width: var(--max-wrap);
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1.5rem;
}

/* Rotating chorus */
.footer-chorus {
    font-size: 1.1rem;
    font-weight: 600;
    min-height: 2rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

.footer-chorus .chip {
    background: var(--warning-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    font-weight: 700;
    display: inline-block;
    padding: 0.5rem 1rem;
}

/* Micro text */
.footer-micro {
    font-size: 0.9rem;
    color: var(--text-secondary);
    opacity: 0.8;
}

.footer-micro p {
    margin: 0;
}

.footer-micro a {
    color: var(--accent-blue);
    text-decoration: none;
    border-bottom: 1px solid rgba(102, 126, 234, 0.3);
    transition: var(--transition);
}

.footer-micro a:hover {
    color: var(--accent-purple);
    border-bottom-color: var(--accent-purple);
}

/* Responsive */
@media (max-width: 768px) {
    .footer {
        padding: 3rem 1.5rem;
    }
    
    .footer-chorus {
        font-size: 1rem;
    }
    
    .footer-micro {
        font-size: 0.85rem;
    }
}
```

# 24. `ukhona/css/head.css`
```css
/* ===== HEAD.CSS (Variables removed - now in variables.css) ===== */

/* Base Styles */
* { box-sizing: border-box; margin: 0; padding: 0; }
html, body { height: 100%; }
body {
    margin: 0;
    font-family: 'Inter', system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
    background: var(--bg);
    color: var(--text);
    line-height: 1.7;
    overflow-x: hidden;
    transition: var(--transition);
    font-size: 16px;
}

.wrap-max {
    max-width: 900px;
    margin: 0 auto;
    padding: 0 var(--space-lg);
}

.bg-pattern { position: fixed; inset: 0; z-index: -2; background: var(--bg); }
.bg-pattern::before {
    content: ''; position: absolute; inset: 0;
    background:
        radial-gradient(circle at 20% 20%, rgba(102,126,234,.10) 0%, transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(118,75,162,.10) 0%, transparent 50%),
        radial-gradient(circle at 40% 60%, rgba(240,147,251,.08) 0%, transparent 50%);
    animation: bgFloat 20s ease-in-out infinite;
}
@keyframes bgFloat {
    0%, 100% { transform: translate(0,0) rotate(0deg); }
    33% { transform: translate(-20px,-20px) rotate(1deg); }
    66% { transform: translate(20px,-10px) rotate(-1deg); }
}

.scroll-indicator { position: fixed; top: 0; left: 0; width: 100%; height: 3px; z-index: 1000; background: var(--glass); }
.scroll-progress { height: 100%; width: 0%; background: var(--primary-gradient); transition: width .3s ease; }

/* HEADER */
.header {
    position: fixed; top: 0; left: 0; width: 100%; z-index: 100;
    backdrop-filter: blur(var(--blur)); -webkit-backdrop-filter: blur(var(--blur));
    background: var(--surface); border-bottom: 1px solid var(--border); min-height: var(--header-h);
}
.nav-container { height: var(--header-h); display: flex; align-items: center; justify-content: space-between; }

#logo.logo {
    width: var(--logo-size); height: var(--logo-size); object-fit: contain;
    transform-origin: center center; animation: spin var(--logo-spin-duration) linear infinite;
    display: block; will-change: transform;
}
@keyframes spin { to { transform: rotate(360deg); } }

.nav-links { display: flex; list-style: none; gap: 2rem; margin: 0; padding: 0; }
.nav-link {
    color: var(--text-secondary);
    text-decoration: none;
    font-weight: 500;
    transition: var(--transition);
    position: relative;
}
.nav-link::after {
    content: ''; position: absolute; bottom: -4px; left: 0; width: 0; height: 2px;
    background: var(--primary-gradient); transition: width .3s ease;
}
.nav-link:hover { color: var(--text); }
.nav-link:hover::after { width: 100%; }

.top-right { display: flex; align-items: center; gap: 1rem; }

.menu-icon {
    display: grid; grid-template-columns: repeat(3, 6px); gap: 3px; padding: 8px;
    background: var(--glass); border: 1px solid var(--border);
    border-radius: 8px; cursor: pointer; transition: var(--transition);
}
.menu-icon div { width: 6px; height: 6px; background: var(--text); border-radius: 50%; transition: var(--transition); }
.menu-icon:hover { background: var(--primary-gradient); transform: scale(1.05); }
.menu-icon:hover div { background: white; }

#toggle-theme {
    padding: 8px 12px; background: var(--glass); border: 1px solid var(--border);
    border-radius: 8px; cursor: pointer; font-size: 16px; transition: var(--transition);
}
#toggle-theme:hover { background: var(--secondary-gradient); color: #fff; transform: scale(1.05); }

.app-grid {
    position: fixed;
    top: calc(var(--header-h) + 8px);
    right: 2rem;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    padding: 1rem;
    background: var(--surface);
    backdrop-filter: blur(var(--blur));
    -webkit-backdrop-filter: blur(var(--blur));
    border: 1px solid var(--border);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px) scale(.95);
    transition: var(--transition);
    min-width: 300px;
    z-index: 1000;
    max-height: 80vh;
    overflow-y: auto;
    overscroll-behavior: contain;
}
.app-grid.active { opacity: 1; visibility: visible; transform: translateY(0) scale(1); }

.app-grid a {
    display: flex; flex-direction: column; align-items: center; gap: .5rem; padding: 1rem;
    text-decoration: none; color: var(--text);
    background: var(--glass); border: 1px solid var(--border); border-radius: 12px;
    transition: var(--transition); font-size: 14px; font-weight: 500;
}
.app-grid a:hover {
    background: var(--primary-gradient); color: #fff; transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102,126,234,.3);
}

.icon-box {
    font-size: 24px; width: 48px; height: 48px; display: flex; align-items: center;
    justify-content: center; background: var(--glass); border-radius: 12px; transition: var(--transition);
}

/* Scrollbar styling */
.app-grid::-webkit-scrollbar { width: 8px; }
.app-grid::-webkit-scrollbar-track { background: transparent; }
.app-grid::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.2); border-radius: 4px; }
.app-grid::-webkit-scrollbar-thumb:hover { background: rgba(255,255,255,0.4); }

/* MAIN CONTENT */
.page {
    padding-top: 180px;
    padding-bottom: var(--space-2xl);
}

.card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    padding: var(--space-xl);
    margin: var(--space-xl) 0;
    box-shadow: var(--shadow);
}

/* Typography */
.card h1 {
    font-size: 2.5rem;
    font-weight: 800;
    margin-bottom: var(--space-lg);
    background: var(--primary-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: -0.02em;
    text-align: left;
}

.card h2 {
    font-size: 1.75rem;
    font-weight: 700;
    margin-top: var(--space-lg);
    margin-bottom: var(--space-md);
    color: var(--text);
    border-left: 4px solid var(--accent-blue);
    padding-left: var(--space-md);
    text-align: left;
}

.card h3 {
    font-size: 1.25rem;
    font-weight: 600;
    margin-top: var(--space-md);
    margin-bottom: var(--space-sm);
    color: var(--text);
    text-align: left;
}

.card p {
    margin-bottom: var(--space-md);
    color: var(--text-secondary);
    line-height: 1.7;
}

.card ul, .card ol {
    margin-left: var(--space-lg);
    margin-bottom: var(--space-md);
    color: var(--text-secondary);
}

.card li {
    margin-bottom: var(--space-xs);
    line-height: 1.7;
}

.card code {
    background: var(--glass);
    padding: 2px 6px;
    border-radius: 4px;
    font-family: 'Courier New', monospace;
    font-size: 0.9em;
    color: var(--accent-blue);
}

.card pre {
    background: var(--glass);
    padding: var(--space-md);
    border-radius: var(--radius);
    overflow-x: auto;
    margin-bottom: var(--space-md);
}

.card pre code {
    background: none;
    padding: 0;
    color: var(--text);
}

/* Responsive */
@media (max-width: 768px) {
    .nav-links { display: none; }
    .app-grid {
        right: 1rem;
        left: 1rem;
        grid-template-columns: repeat(2, 1fr);
    }
    .wrap-max { padding: 0 var(--space-md); }
    .card { padding: var(--space-lg); }
    .card h1 { font-size: 2rem; }
    .card h2 { font-size: 1.5rem; }
}

/* ===== ELEGANT LINK STYLES ===== */

/* Card links: Gradient underline */
.card a {
    color: var(--text);
    text-decoration: none;
    font-weight: 500;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.7), rgba(118, 75, 162, 0.7));
    background-size: 0% 1.5px;
    background-position: 0 100%;
    background-repeat: no-repeat;
    transition: background-size 0.3s cubic-bezier(0.4, 0, 0.2, 1), 
                color 0.3s ease;
}

.card a:hover {
    background-size: 100% 1.5px;
    color: #667eea;
}

/* Footer links: Specific selectors to override after injection */
.footer a,
.footer-micro a,
#footer-placeholder a {
    color: var(--text-secondary) !important;
    text-decoration: none !important;
    border-bottom: 1px solid transparent !important;
    background: none !important;
    transition: all 0.3s ease !important;
}

.footer a:hover,
.footer-micro a:hover,
#footer-placeholder a:hover {
    color: #667eea !important;
    border-bottom-color: rgba(102, 126, 234, 0.4) !important;
}

/* Figcaption links: Ultra subtle */
figcaption a {
    color: inherit;
    text-decoration: none;
    position: relative;
    opacity: 0.9;
    background: none !important;
}

figcaption a::after {
    content: '';
    position: absolute;
    bottom: -1px;
    left: 0;
    width: 0;
    height: 1px;
    background: currentColor;
    opacity: 0.5;
    transition: width 0.3s ease;
}

figcaption a:hover {
    opacity: 1;
}

figcaption a:hover::after {
    width: 100%;
}
```

# 25. `ukhona/css/main.css`
```css
/* ===== MAIN.CSS (Variables removed - now in variables.css) ===== */

/* ===== BASE STYLES ===== */
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: 'Inter', sans-serif;
    background: var(--bg);
    color: var(--text);
    line-height: 1.6;
    overflow-x: hidden;
    transition: var(--transition);
}

/* Background Animation */
.bg-pattern {
    position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -2;
    background: var(--bg);
}
.bg-pattern::before {
    content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%;
    background: radial-gradient(circle at 20% 20%, rgba(102, 126, 234, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(118, 75, 162, 0.1) 0%, transparent 50%);
    animation: backgroundFloat 20s ease-in-out infinite;
}
@keyframes backgroundFloat {
    0%, 100% { transform: translate(0, 0); }
    50% { transform: translate(20px, 10px); }
}

/* ===== HEADER & NAV ===== */
.header {
    position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;
    backdrop-filter: blur(var(--blur)); background: var(--surface);
    border-bottom: 1px solid var(--border); min-height: var(--header-h);
}
.nav-container {
    max-width: var(--max-wrap); margin: 0 auto; padding: 0 2rem;
    display: flex; align-items: center; justify-content: space-between;
    height: var(--header-h);
}

.logo {
    width: var(--logo-size); height: var(--logo-size);
    animation: spin var(--logo-spin-duration) linear infinite;
    transition: transform 0.3s ease;
    will-change: transform;
}
@keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

.top-right { display: flex; align-items: center; gap: 1rem; }

/* Menu Icon Dots */
.menu-icon {
    display: grid; grid-template-columns: repeat(3, 6px); gap: 3px;
    padding: 8px; cursor: pointer; border-radius: 8px; background: var(--glass);
}
.menu-icon div { width: 6px; height: 6px; background: var(--text); border-radius: 50%; }

/* ===== APP GRID (FIXED VERSION) ===== */
.app-grid {
    position: fixed;
    top: calc(var(--header-h) + 10px);
    right: 2rem;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    padding: 1.5rem;
    background: var(--surface);
    backdrop-filter: blur(var(--blur));
    border: 1px solid var(--border);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    z-index: 2000;
    max-height: 80vh;
    overflow-y: auto;
    
    /* Hidden by default */
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
    transform: translateY(-15px);
    transition: var(--transition);
}

.app-grid.active {
    opacity: 1;
    visibility: visible;
    pointer-events: auto;
    transform: translateY(0);
}

.app-grid a {
    display: flex; flex-direction: column; align-items: center; gap: 0.5rem;
    padding: 1rem; text-decoration: none; color: var(--text);
    background: var(--glass); border: 1px solid var(--border); border-radius: 12px;
}
.app-grid a:hover { background: var(--primary-gradient); color: #fff; transform: translateY(-2px); }

/* ===== HERO & CONTENT ===== */
.hero {
    min-height: 80vh; display: flex; align-items: center; justify-content: center;
    text-align: center; padding: 2rem;
}
.hero-title {
    font-size: clamp(3rem, 8vw, 6rem); font-weight: 900;
    background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;
}
.hero-cta { display: flex; gap: 1rem; justify-content: center; margin-top: 2rem; flex-wrap: wrap; }

.cta-button {
    padding: 1rem 2rem; border-radius: 12px; font-weight: 600; text-decoration: none;
    transition: var(--transition);
}
.cta-primary { background: var(--primary-gradient); color: white; }
.cta-secondary { background: var(--glass); color: var(--text); border: 1px solid var(--border); }

/* ===== CARDS & METRICS ===== */
.role-grid, .services-grid {
    display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem; padding: 2rem 0;
}
.role-card, .service-card {
    background: var(--surface); border: 1px solid var(--border);
    padding: 2rem; border-radius: var(--radius); transition: var(--transition);
}
.role-card:hover { transform: translateY(-5px); }

.metric-value {
    font-size: 2.5rem; font-weight: 900; background: var(--success-gradient);
    -webkit-background-clip: text; -webkit-text-fill-color: transparent;
}

/* ===== FOOTER ===== */
.footer { text-align: center; padding: 4rem 2rem; border-top: 1px solid var(--border); margin-top: 4rem; }
.footer-chorus .chip { background: var(--warning-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 700; }

/* ===== RESPONSIVE ===== */
@media (max-width: 767px) {
    .app-grid {
        right: 1rem; left: 1rem;
        grid-template-columns: repeat(2, 1fr);
    }
    .hero-title { font-size: 3rem; }
}

/* Utils */
.sep { display: none !important; }
```

# 26. `ukhona/css/variables.css`
```css
/* ========================================
   VARIABLES.CSS - Single Source of Truth
   ======================================== */

:root {
    /* Layout */
    --max-wrap: 1120px;
    --pad-x: 24px;
    --header-h: 160px;
    
    /* Spacing Scale */
    --space-xs: 0.5rem;
    --space-sm: 1rem;
    --space-md: 1.5rem;
    --space-lg: 2.5rem;
    --space-xl: 4rem;
    --space-2xl: 6rem;
    --s-1: 8px; 
    --s-2: 12px; 
    --s-3: 16px; 
    --s-4: 24px;
    --s-5: 32px; 
    --s-6: 48px; 
    --s-7: 64px; 
    --s-8: 96px;

    /* Gradients */
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
    --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
    --accent-blue: #667eea;
    --accent-purple: #764ba2;

    /* Effects */
    --blur: 20px;
    --radius: 16px;
    --shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    
    /* Logo */
    --logo-size: 140px;
    --logo-spin-duration: 60s;

    /* Light Theme Colors */
    --light-bg: #fafafa;
    --light-surface: rgba(255, 255, 255, 0.9);
    --light-glass: rgba(0, 0, 0, 0.02);
    --light-border: rgba(0, 0, 0, 0.08);
    --light-text: #1a1a1a;
    --light-text-secondary: rgba(0, 0, 0, 0.7);

    /* Dark Theme Colors */
    --dark-bg: #0a0a0f;
    --dark-surface: rgba(15, 15, 25, 0.8);
    --dark-glass: rgba(255, 255, 255, 0.05);
    --dark-border: rgba(255, 255, 255, 0.1);
    --dark-text: #ffffff;
    --dark-text-secondary: rgba(255, 255, 255, 0.7);
}

/* Theme Switching */
[data-theme="light"] {
    --bg: var(--light-bg);
    --surface: var(--light-surface);
    --glass: var(--light-glass);
    --border: var(--light-border);
    --text: var(--light-text);
    --text-secondary: var(--light-text-secondary);
}

[data-theme="dark"] {
    --bg: var(--dark-bg);
    --surface: var(--dark-surface);
    --glass: var(--dark-glass);
    --border: var(--dark-border);
    --text: var(--dark-text);
    --text-secondary: var(--dark-text-secondary);
}
```

```js
window.MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']],
    displayMath: [['$$', '$$'], ['\\[', '\\]']],
    processEscapes: true
  },
  options: {
    skipHtmlTags: ['script', 'noscript', 'style', 'textarea', 'pre']
  }
};
```

# 27. `ukhona/css/shared.js`

```js
/**
 * shared.js - Fixed Version
 * Handles: Header/Footer Injection, Grid Menu, Theme Toggle, Link Correction
 */

document.addEventListener('DOMContentLoaded', async () => {
    'use strict';

    // --- CONFIGURATION ---
    
    const getPath = (filename) => {
        const isSubDir = window.location.pathname.includes('/ukhona/html/');
        const prefix = isSubDir ? '../html/' : 'ukhona/html/';
        return `${prefix}${filename}`;
    };

    const REPO_NAME = '/repos-00';
    const BASE = window.location.pathname.startsWith(REPO_NAME) ? REPO_NAME : '';

    const fixLinks = (container) => {
        if (!container || !BASE) return;
        const links = container.querySelectorAll('a[href^="/"]');
        links.forEach(a => {
            const href = a.getAttribute('href');
            if (!href.startsWith(BASE)) {
                a.setAttribute('href', `${BASE}${href}`);
            }
        });
    };

    // --- INJECTION ENGINE (WITH ERROR FEEDBACK) ---
    async function inject(id, filename) {
        const placeholder = document.getElementById(id);
        if (!placeholder) {
            console.error(`[System] Element #${id} not found`);
            return;
        }

        try {
            const response = await fetch(getPath(filename));
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            
            const data = await response.text();
            placeholder.innerHTML = data;
            fixLinks(placeholder);
            console.log(`[System] ✓ Injected: ${filename}`);
        } catch (err) {
            console.error(`[System] ✗ Failed to inject ${filename}:`, err);
            placeholder.innerHTML = `<div style="color:red;padding:1rem;">Failed to load ${filename}</div>`;
        }
    }

    // --- LOAD PARTIALS ---
    const PARTIALS = [
        ['header', 'header.html'],
        ['footer-placeholder', 'footer.html']
    ];

    await Promise.all(PARTIALS.map(([id, file]) => inject(id, file)));

    // --- INITIALIZE COMPONENTS ---
    initGridMenu();
    initThemeToggle();
    initScrollProgress();
    initFooterChorus(); 

    // --- GRID MENU (FIXED CLICK HANDLING) ---
    function initGridMenu() {
        const menuBtn = document.getElementById('menuIcon');
        const menuGrid = document.getElementById('gridMenu');

        if (!menuBtn || !menuGrid) return;

        fixLinks(menuGrid);

        let isOpen = false;

        const openMenu = () => {
            isOpen = true;
            menuGrid.classList.add('active');
            menuBtn.setAttribute('aria-expanded', 'true');
        };

        const closeMenu = () => {
            isOpen = false;
            menuGrid.classList.remove('active');
            menuBtn.setAttribute('aria-expanded', 'false');
        };

        // Toggle on button click
        menuBtn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            isOpen ? closeMenu() : openMenu();
        });

        // Close on outside click (capture phase to catch early)
        document.addEventListener('click', (e) => {
            if (isOpen && !menuGrid.contains(e.target) && !menuBtn.contains(e.target)) {
                closeMenu();
            }
        }, true);

        // Close on Escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && isOpen) {
                closeMenu();
            }
        });
    }

    // --- THEME TOGGLE ---
    function initThemeToggle() {
        const themeBtn = document.getElementById('toggle-theme');
        const logo = document.getElementById('logo');
        const savedTheme = localStorage.getItem('theme') || 'dark';
        
        document.documentElement.setAttribute('data-theme', savedTheme);

        // Update logo for initial theme
        if (logo) {
            const lightSrc = logo.getAttribute('data-light-src');
            const darkSrc = logo.getAttribute('data-dark-src');
            logo.src = savedTheme === 'dark' ? darkSrc : lightSrc;
        }

        if (themeBtn) {
            themeBtn.textContent = savedTheme === 'dark' ? '🌙' : '☀️';
            
            themeBtn.addEventListener('click', () => {
                const currentTheme = document.documentElement.getAttribute('data-theme');
                const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
                
                document.documentElement.setAttribute('data-theme', newTheme);
                localStorage.setItem('theme', newTheme);
                themeBtn.textContent = newTheme === 'dark' ? '🌙' : '☀️';
                
                // Switch logo
                if (logo) {
                    const lightSrc = logo.getAttribute('data-light-src');
                    const darkSrc = logo.getAttribute('data-dark-src');
                    logo.src = newTheme === 'dark' ? darkSrc : lightSrc;
                }
            });
        }
    }

    // --- SCROLL PROGRESS (DEBOUNCED) ---
    function initScrollProgress() {
        const progress = document.querySelector('.scroll-progress');
        if (!progress) return;

        let ticking = false;

        window.addEventListener('scroll', () => {
            if (!ticking) {
                window.requestAnimationFrame(() => {
                    const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
                    const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
                    const scrolled = (winScroll / height) * 100;
                    progress.style.width = scrolled + "%";
                    ticking = false;
                });
                ticking = true;
            }
        });
    }

    // --- FOOTER CHORUS ---
    function initFooterChorus() {
        const box = document.querySelector('.rotating-chorus');
        if (!box) return;
        
        const chips = Array.from(box.querySelectorAll('.chip'));
        if (chips.length === 0) return;

        let currentIndex = 0;
        chips.forEach((chip, idx) => chip.style.display = idx === 0 ? 'inline' : 'none');

        if (window.chorusInterval) clearInterval(window.chorusInterval);
        
        window.chorusInterval = setInterval(() => {
            chips[currentIndex].style.display = 'none';
            currentIndex = (currentIndex + 1) % chips.length;
            chips[currentIndex].style.display = 'inline';
        }, 5000);
    }
});
```

# 28
# 29