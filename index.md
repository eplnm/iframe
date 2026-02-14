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

```html
<!DOCTYPE html>
<!-- html, head, body[header, main, footer] -->
<html lang="en" data-theme="dark">
<!-- head, body[header, main, footer] -->
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Ukhona — An Accounting of Survival</title>
  <meta name="color-scheme" content="dark light" />
  <meta name="theme-color" content="#0a0a0f" />
  <meta name="description" content="The Dude's Rug.">
  <link rel="canonical" href="https://ukb-dt.github.io/repos-00/">
  <meta name="robots" content="index,follow">
  <meta name="color-scheme" content="dark light">
  <meta name="theme-color" content="#0a0a0f">

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

  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link href="../css/head.css" rel="stylesheet" />
  <script src="../js/mathjax.js"></script>
  <script id="MathJax-script" defer
     src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
  </script>
</head>
<!-- body[header, main, footer] -->
<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>
  <!-- header, main, footer -->
  <header class="header">
    <div class="nav-container wrap-max">
      <img src="https://abikesa.github.io/logos/assets/ukubona-dark.png"
           alt="Ukubona LLC Logo"
           id="logo"
           class="logo" />

      <div class="top-right">
        <ul class="nav-links">
          <li><a href="https://ukb-dt.github.io/repos-00/" class="nav-link" data-nav="home">Home</a></li>
        </ul>

        <button class="menu-icon" id="menuIcon" role="button" aria-label="Open navigation menu" aria-expanded="false">
          <div></div><div></div><div></div>
          <div></div><div></div><div></div>
          <div></div><div></div><div></div>
        </button>

        <button id="toggle-theme" aria-label="Toggle theme">🌙</button>
      </div>
    </div>
    <div class="app-grid wrap-max" id="gridMenu" aria-hidden="true">

            <a href="#"><div class="icon-box">📊</div>Home</a>
            <a href="#"><div class="icon-box">🎮</div>Games</a>      
            <a href="#"><div class="icon-box">🎯</div>Mission</a>
            <a href="#"><div class="icon-box">📈</div>Models</a>
            <a href="#"><div class="icon-box">🧑‍🤝‍🧑</div>Team</a>
            <a href="#"><div class="icon-box">✉️</div>Contact</a>
            <a href="#"><div class="icon-box">🌊</div>Atheists</a>
            <a href="#"><div class="icon-box">❤️</div>Knob</a>
            <a href="#"><div class="icon-box">🔥</div>Gemini</a>
            <a href="#"><div class="icon-box">🧠</div>Table</a>
            <a href="#"><div class="icon-box">⚛️</div>Heisenberg</a>
            <a href="#"><div class="icon-box">🔄</div>Prigogine</a>
            <a href="#"><div class="icon-box">🧬</div>Vogelstein</a>
            <a href="#"><div class="icon-box">📖</div>Dostoevsky</a>
            <a href="#"><div class="icon-box">🗻</div>Nietzsche</a>
            <a href="#"><div class="icon-box">✨</div>Yebo</a>
            <a href="#"><div class="icon-box">🔥</div>Ngikhona</a>
            <a href="#"><div class="icon-box">👁️</div>Saubona</a>
            <a href="#"><div class="icon-box">🎭</div>Dionysus</a>
            <a href="#"><div class="icon-box">🏛️</div>Apollo</a>
            <a href="#"><div class="icon-box">⚡</div>Entropy</a>
            <a href="#"><div class="icon-box">🌀</div>Chaos</a>
            <a href="#"><div class="icon-box">🎼</div>Harmony</a>
            <a href="#"><div class="icon-box">🔮</div>Oracle</a>
            <a href="#"><div class="icon-box">🌌</div>Cosmos</a>
            <a href="#"><div class="icon-box">💫</div>Stardust</a>
            <a href="#"><div class="icon-box">🎨</div>Aesthetics</a>
            <a href="#"><div class="icon-box">⚖️</div>Ethics</a>
            <a href="#"><div class="icon-box">🧭</div>Navigate</a>
            <a href="#"><div class="icon-box">🌳</div>Organic</a>
            <a href="#"><div class="icon-box">🔬</div>Science</a>
            <a href="#"><div class="icon-box">🎓</div>Academia</a>
            <a href="#"><div class="icon-box">📚</div>Library</a>
            <a href="#"><div class="icon-box">🖋️</div>Poetry</a>
            <a href="#"><div class="icon-box">🎵</div>Music</a>
            <a href="#"><div class="icon-box">🌅</div>Dawn</a>
            <a href="#"><div class="icon-box">🌃</div>Dusk</a>
            <a href="#"><div class="icon-box">💡</div>Insight</a>
            <a href="#"><div class="icon-box">🔑</div>Gateway</a>
            <a href="#"><div class="icon-box">🌺</div>Blossom</a>
            <a href="#"><div class="icon-box">🦅</div>Freedom</a>
            <a href="#"><div class="icon-box">🐉</div>Myth</a>
            <a href="#"><div class="icon-box">🌙</div>Lunar</a>
            <a href="#"><div class="icon-box">☀️</div>Solar</a>
            <a href="#"><div class="icon-box">🌍</div>Terra</a>
            <a href="#"><div class="icon-box">🌬️</div>Breath</a>
            <a href="#"><div class="icon-box">💧</div>Fluid</a>
            <a href="#"><div class="icon-box">🔆</div>Radiance</a>
            <a href="#"><div class="icon-box">🌿</div>Growth</a>
            <a href="#"><div class="icon-box">🍂</div>Decay</a>
            <a href="#"><div class="icon-box">❄️</div>Crystal</a>
            <a href="#"><div class="icon-box">🌋</div>Ignition</a>
            <a href="#"><div class="icon-box">🏔️</div>Summit</a>
            <a href="#"><div class="icon-box">🌊</div>Wave</a>
            <a href="#"><div class="icon-box">🎪</div>Spectacle</a>
            <a href="#"><div class="icon-box">🗝️</div>Cipher</a>
            <a href="#"><div class="icon-box">📡</div>Signal</a>
            <a href="#"><div class="icon-box">🛸</div>Beyond</a>
            <a href="#"><div class="icon-box">🧩</div>Pattern</a>
            <a href="#"><div class="icon-box">🎲</div>Chance</a>
            <a href="#"><div class="icon-box">♟️</div>Strategy</a>
            <a href="#"><div class="icon-box">🏺</div>Artifact</a>
            <a href="#"><div class="icon-box">📜</div>Scroll</a>
            <a href="#"><div class="icon-box">🗿</div>Monument</a>
            <a href="#"><div class="icon-box">⏳</div>Time</a>
            <a href="#"><div class="icon-box">🔭</div>Vision</a>
            <a href="#"><div class="icon-box">🧪</div>Alchemy</a>
            <a href="#"><div class="icon-box">⚗️</div>Transform</a>
            <a href="#"><div class="icon-box">🎯</div>Precision</a>
            <a href="#"><div class="icon-box">🌐</div>Network</a>
            <a href="#"><div class="icon-box">🔗</div>Link</a>
            <a href="#"><div class="icon-box">🧵</div>Thread</a>
            <a href="#"><div class="icon-box">🕸️</div>Web</a>
            <a href="#"><div class="icon-box">🌟</div>Stellar</a>
            <a href="#"><div class="icon-box">💎</div>Gem</a>
            <a href="#"><div class="icon-box">🏹</div>Arrow</a>
            <a href="#"><div class="icon-box">⚔️</div>Conflict</a>
            <a href="#"><div class="icon-box">🛡️</div>Defense</a>
            <a href="#"><div class="icon-box">🕊️</div>Peace</a>
            <a href="#"><div class="icon-box">🦋</div>Metamorphosis</a>
            <a href="#"><div class="icon-box">🌸</div>Ephemeral</a>
            <a href="#"><div class="icon-box">🍃</div>Breath</a>
            <a href="#"><div class="icon-box">🌾</div>Harvest</a>
            <a href="#"><div class="icon-box">🏮</div>Lantern</a>
            <a href="#"><div class="icon-box">🎐</div>Wind</a>
            <a href="#"><div class="icon-box">🧘</div>Stillness</a>
            <a href="#"><div class="icon-box">⛩️</div>Threshold</a>
            <a href="#"><div class="icon-box">🕯️</div>Flame</a>
            <a href="#"><div class="icon-box">🌈</div>Spectrum</a>
            <a href="#"><div class="icon-box">🎆</div>Celebration</a>
            <a href="#"><div class="icon-box">🎇</div>Sparkle</a>
            <a href="#"><div class="icon-box">🌠</div>Wish</a>
            <a href="#"><div class="icon-box">🔱</div>Trident</a>
            <a href="#"><div class="icon-box">♾️</div>Infinite</a>
            <a href="#"><div class="icon-box">🎎</div>Duality</a>
            <a href="#"><div class="icon-box">🧿</div>Protection</a>
            <a href="#"><div class="icon-box">🪶</div>Lightness</a>
            <a href="#"><div class="icon-box">🏛️</div>Archive</a>

    </div>
  </header>

  <!-- main[sections], footer -->
  <main class="page wrap-max">


                    <!-- G -->
        <section class="card">
            <div class="card-body">
                <h1 class="card-title">The Raindrop and the Ledger: An Intuitive Generalization of Relativity</h1>

                <article class="concept-section">
                <h2>1. Moving Beyond the Average</h2>
                <p>
                    Classical physics (Newton) operates like a basic statistical model: <strong>Mean ± Standard Deviation</strong>. 
                    It assumes a flat linear background where variance is just "noise."
                </p>
                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ y = \beta_0 + \epsilon $$
                </div>
                <p>
                    Einstein realized the "noise" at the extremes wasn't random—it was a feature. To explain the variance, 
                    he introduced a factor: <strong>Geometry determined by Mass</strong>. If your model fails to predict 
                    the orbit of Mercury, it is because $ R^2 \approx 0 $ for that specific extreme case. 
                    Relativity provides the explanatory factor.
                </p>
                </article>

                <hr>

                <article class="concept-section">
                <h2>2. Nature's Ledger: The Cost Function</h2>
                <p>
                    The equation $ E=mc^2 $ is not just a formula; it is the <strong>exchange rate</strong> of the universe. 
                    It acts as the cost function of existence.
                </p>
                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ E = mc^2 $$
                </div>
                <ul>
                    <li><strong>$ E $ (Energy):</strong> The Cost (Currency).</li>
                    <li><strong>$ m $ (Mass):</strong> The Payload (The object/raindrop).</li>
                    <li><strong>$ c^2 $ (Exchange Rate):</strong> The price of admission.</li>
                </ul>
                <p>
                    Your intuition connects mass, responsiveness, and cost:
                </p>
                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ \frac{m \cdot s}{c} \approx \frac{\text{Payload} \times \text{Responsiveness}}{\text{Cost}} $$
                </div>
                <p>
                    As responsiveness increases (latency approaches 0, meaning $ v \to c $), the Cost must scale asymptotically to infinity.
                </p>
                </article>

                <hr>

                <article class="concept-section">
                <h2>3. Terraforming: Stochastic Gradient Descent</h2>
                <p>
                    In this model, gravity is not a force pulling objects; it is objects optimizing their path through a landscape. 
                    The "raindrop" (mass) <strong>terraforms</strong> the gradients for future raindrops.
                </p>
                <ul>
                    <li>
                    <strong>Matter tells Space how to curve (The Terraforming):</strong>
                    <br>
                    $$ G_{\mu\nu} = \frac{8\pi G}{c^4} T_{\mu\nu} $$
                    </li>
                    <li>
                    <strong>Space tells Matter how to move (The Descent):</strong>
                    <br>
                    The raindrop performs <em>Gradient Descent</em>. It finds the local minimum in the curved geometry. 
                    It doesn't "feel" gravity; it simply follows the path of least resistance (Least Action) created by the terraforming.
                    </li>
                </ul>
                </article>
            </div>
            </section>

                    <!-- O -->
          <section class="card">
            <article class="concept-section">
            <h2>4. When the Payload Is a Star: Latency Collapse and Local Zero</h2>

            <p>
                Let $ m $ grow—not to a raindrop, not to a planet—but to the <strong>mass of a star</strong>.
                Something subtle but decisive happens.
            </p>

            <p>
                The system does <em>not</em> break. Instead, latency becomes <strong>locally negligible</strong>.
            </p>

            <div class="equation-block" style="text-align: center; margin: 1em 0;">
                $$ m \uparrow \;\;\Longrightarrow\;\; \nabla(\text{Geometry}) \uparrow \;\;\Longrightarrow\;\; \text{Latency} \to 0 \;\;(\text{locally}) $$
            </div>

            <p>
                For distances that are <em>humanly comprehensible</em>—Sun to Earth, Earth to Moon—the curvature is so dominant
                that response appears instantaneous. Not because information exceeds $ c $, but because the gradient is steep
                enough that descent requires no deliberation.
            </p>

            <ul>
                <li>
                    <strong>Latency → 0 is not global.</strong><br>
                    It is confined to the basin of curvature defined by the star’s mass.
                </li>
                <li>
                    <strong>$ c $ remains absolute.</strong><br>
                    What vanishes is not the speed limit, but the need to wait.
                </li>
            </ul>

            <p>
                In optimization terms: the learning rate is unchanged, but the loss landscape is so sharply curved
                that the update converges in one step.
            </p>

            <div class="equation-block" style="text-align: center; margin: 1em 0;">
                $$ \text{Deep Curvature} \;\Rightarrow\; \text{Single-Step Convergence} $$
            </div>

            <p>
                This is why planetary motion feels clockwork-precise.
                Not because gravity is strong, but because the ledger is settled <em>near the source</em>.
            </p>

            <p>
                A star does not pull.
                It finalizes accounts.
            </p>
            </article>
            </section>

            <!-- A -->
            <section class="card">
            <div class="card-body">
                <h2 class="card-title">5. When the Ledger Closes: The Event Horizon as Terminal Curvature</h2>

                <article class="concept-section">
                <p>
                    Push $ m $ further still—beyond stars, beyond comprehension—until the gradient becomes so extreme 
                    that the landscape itself <strong>folds inward</strong>.
                </p>

                <p>
                    This is not merely steep curvature. This is <strong>terminal curvature</strong>: 
                    a point where the cost function becomes undefined for external observers.
                </p>

                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ m \to M_{\text{critical}} \;\;\Longrightarrow\;\; r \to r_s = \frac{2GM}{c^2} $$
                </div>

                <p>
                    At the Schwarzschild radius $ r_s $, the geometry ceases to permit outbound trajectories. 
                    Not because of force, but because <em>all geodesics point inward</em>.
                </p>

                <hr>

                <h3>The Ledger That Cannot Be Audited</h3>

                <p>
                    In our economic metaphor, the black hole is an account that accepts deposits but issues no receipts. 
                    Information crosses the event horizon, paying the energy cost $ E = mc^2 $, but the transaction 
                    <strong>cannot be reversed or verified</strong> from outside.
                </p>

                <ul>
                    <li>
                    <strong>Inside $ r_s $:</strong> Time and space exchange roles. 
                    The "future" points toward the singularity with the same inevitability that the past recedes from us.
                    </li>
                    <li>
                    <strong>At $ r_s $:</strong> Latency becomes <em>formally infinite</em> for external observers. 
                    A photon emitted at the horizon takes infinite coordinate time to escape—which is to say, it doesn't.
                    </li>
                    <li>
                    <strong>Beyond $ r_s $:</strong> The gradient is steep but traversable. 
                    You can still climb out—barely—if you pay the energy cost.
                    </li>
                </ul>

                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ \text{Curvature at } r_s: \quad \lim_{r \to r_s^+} \left(1 - \frac{r_s}{r}\right)^{-1} = \infty $$
                </div>

                <p>
                    This is the point where the cost function diverges. No amount of energy suffices to escape. 
                    The exchange rate becomes undefined.
                </p>

                <hr>

                <h3>Optimization Collapse: No Gradient to Descend</h3>

                <p>
                    In the language of gradient descent, a black hole represents a region where the loss landscape 
                    has <strong>collapsed into a well with vertical walls</strong>.
                </p>

                <ul>
                    <li>
                    For a star, the gradient is steep but finite. Descent is rapid but possible in reverse (with sufficient energy).
                    </li>
                    <li>
                    For a black hole, the gradient at $ r_s $ is <em>discontinuous</em>. 
                    Inside, there is no gradient pointing outward. The only direction is down.
                    </li>
                </ul>

                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ \nabla_{\text{outward}} = 0 \quad \text{for } r < r_s $$
                </div>

                <p>
                    You cannot optimize your way out. The terraforming is complete and irreversible.
                </p>

                <hr>

                <h3>The Singularity: Where the Ledger Itself Breaks</h3>

                <p>
                    At $ r = 0 $, curvature becomes infinite—not just steep, but <strong>singular</strong>. 
                    The equations fail. Geometry loses meaning. The cost function has no domain.
                </p>

                <p>
                    This is not a feature. It is a <strong>boundary condition</strong> signaling that our current framework—General Relativity—
                    requires completion. Likely by quantum gravity, where the ledger is kept at Planck scale and the concept of 
                    "position" itself becomes probabilistic.
                </p>

                <div class="equation-block" style="text-align: center; margin: 1em 0;">
                    $$ r \to 0 \quad \Longrightarrow \quad R_{\mu\nu\rho\sigma} \to \infty \quad \text{(breakdown)} $$
                </div>

                <p>
                    The singularity is where the raindrop metaphor ends. 
                    Not because the raindrop vanishes, but because the landscape itself ceases to exist as a continuum.
                </p>

                <hr>

                <h3>What the Black Hole Teaches Us</h3>

                <p>
                    A black hole is not an object. It is a <strong>threshold in the cost function of spacetime</strong>.
                </p>

                <ul>
                    <li>It is the point where latency becomes absolute.</li>
                    <li>It is the region where all paths converge to a single inevitable endpoint.</li>
                    <li>It is the limit case of terraforming: geometry so extreme it permits no return.</li>
                </ul>

                <p>
                    In optimization terms: it is a loss well so deep that gradient descent cannot climb out, 
                    no matter the learning rate, no matter the batch size, no matter the architecture.
                </p>

                <p>
                    The black hole does not pull.
                    <br>
                    It <strong>finalizes</strong>.
                </p>
                </article>
            </div>
            </section>
                            

                <!-- X -->
                <section class="card">
                    <div class="card-body">
                        <h2 class="card-title">6. Evaporation: The Ledger That Leaks</h2>

                        <article class="concept-section">
                            <p>
                                Even the most extreme terraformer—the black hole—does not last forever. Quantum mechanics introduces a slow but relentless refund process: <strong>Hawking radiation</strong>.
                            </p>

                            <p>
                                Near the event horizon, the vacuum is not empty; it flickers with virtual particle-antiparticle pairs (quantum fluctuations borrowing energy briefly from the ledger). In flat space, they annihilate harmlessly. But the steep curvature splits them: one falls in (negative energy relative to outside), the other escapes as real radiation.
                            </p>

                            <div style="text-align: center; margin: 1em 0;">
                                <img src="https://blogs-images.forbes.com/startswithabang/files/2017/08/1-JfanY_MplBJ_FX1N0I2StQ-1200x675.jpg" alt="Hawking radiation virtual particle pairs near black hole horizon" style="max-width: 80%; height: auto;">
                            </div>

                            <p>
                                The escaping particle carries positive energy away, paid for by the black hole's mass. The ledger slowly refunds itself—mass decreases, temperature rises (since <em>T ∝ 1/M</em>), and the process accelerates.
                            </p>

                            <div class="equation-block" style="text-align: center; margin: 1em 0;">
                                $$ T_H = \frac{\hbar c^3}{8\pi G M k_B} \quad \Rightarrow \quad \text{Smaller } M \rightarrow \text{Hotter, Faster Leak} $$
                            </div>

                            <p>
                                For stellar-mass black holes, this takes ~10<sup>67</sup> years—far longer than the universe's age. But eventually, the payload shrinks, the horizon contracts, and the final stages become explosive.
                            </p>

                            <hr>

                            <h3>The Paradox: Where Did the Information Go?</h3>

                            <p>
                                Here the ledger metaphor faces its deepest audit: Hawking radiation appears thermal—random, depending only on M, Q, J (no-hair theorem). It carries no trace of what fell in. As the black hole evaporates completely, the original information (quantum states of infalling matter) seems erased.
                            </p>

                            <ul>
                                <li><strong>Classical GR + Semi-Classical QFT:</strong> Pure input state → mixed thermal output → information loss.</li>
                                <li><strong>Quantum Mechanics Demands:</strong> Unitarity. Information must be preserved; the evolution is reversible. No true destruction allowed.</li>
                            </ul>

                            <p>
                                This is the <strong>black hole information paradox</strong>: the ultimate cost function appears to violate conservation. The ledger accepts irreversible deposits but issues only generic thermal receipts—no audit trail.
                            </p>

                            <div class="equation-block" style="text-align: center; margin: 1em 0;">
                                $$ \text{Initial Pure State} \to \text{Thermal Radiation} + \text{Nothing} \quad ? \quad \Rightarrow \quad \Delta S > 0 \text{ (entropy increase without recovery)} $$
                            </div>

                            <hr>

                            <h3>Modern Resolution: The Ledger is Encrypted, Not Erased</h3>

                            <p>
                                Recent advances (AdS/CFT holography, replica wormholes, Page curve) suggest the information is not lost but <strong>encoded subtly in correlations</strong> across the radiation. Early radiation looks random, but late-stage particles are highly entangled with the interior—revealing the original data as the hole shrinks past "Page time."
                            </p>

                            <ul>
                                <li><strong>Page Curve:</strong> Entanglement entropy rises, peaks, then falls to zero—information emerges unitarily in the full radiation bath.</li>
                                <li><strong>Islands & Wormholes:</strong> Hidden "islands" inside the horizon contribute to the entropy calculation; non-local connections (wormholes in path integrals) allow information to tunnel out without violating causality.</li>
                                <li><strong>Holography:</strong> The interior is a projection from the horizon ledger—all information lives on the boundary, recoverable from the radiation like a holographic refund.</li>
                            </ul>

                            <div style="text-align: center; margin: 1em 0;">
                                <img src="https://futurism.com/wp-content/uploads/2015/04/Information-Paradox-Infographic.jpg" alt="Black hole information paradox illustration showing disappearance vs firewall scenarios" style="max-width: 80%; height: auto;">
                            </div>

                            <p>
                                The ledger does not delete; it encrypts with quantum correlations. Evaporation is not destruction but a slow decryption broadcast.
                            </p>

                            <p>
                                The black hole does not finalize forever.
                                <br>
                                It <strong>broadcasts</strong>—and the information, though delayed, returns.
                            </p>
                        </article>
                    </div>
                </section>

  </main>
  <!-- footer -->
  <footer class="footer">
    <div class="wrap-max footer-wrap">
      <div class="footer-chorus" aria-label="Ukubona chorus">
        <span class="chip">"Ukubona" means to see</span>
        <span class="chip"><em>"Ivyabona" means to witness</em> —</span>
        <span class="chip">to look into the mirror.</span>
      </div>
      <div class="footer-extra" hidden></div>
      <div class="footer-footnote" aria-live="polite"></div>
      <div class="footer-micro" style="margin-top:12px">
        <p>© 2025 Ukubona LLC · <a href="https://ukubona-llc.github.io/assets/files/ukubona.vcf" download>vCard</a> · Johns Hopkins Enterprise Vendor (June 2025)</p>
      </div>
    </div>
  </footer>
  <script src="../js/main.js"></script>
</body>
</html>

```

# 12. Static / Website (Scaffold)

See `ukhona/static.sh`

# 13. Dynamic / Flask (Scaffold)

See `ukhona/dynamic.sh`

# 13. Onboarding Windows (Drama)

```sh
eval "$(pyenv virtualenv-init -)"
root@gabes:~# pyenv install 3.11.12
`pyenv activate' requires Pyenv and Pyenv-Virtualenv to be loaded into your shell.
Check your shell configuration and Pyenv and Pyenv-Virtualenv installation instructions.

root@gabes:~# python3 -m venv .venv
The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

    apt install python3.10-venv

You may need to use sudo with that command.  After installing the python3-venv
package, recreate your virtual environment.

Failing command: /root/.venv/bin/python3
root@gabes:~#    apt install python3.10-venv
root@gabes:~# pyenv install 3.11.12
(myenv) root@gabes:~# pip install pandas matplotlib seaborn plotly jupyter
To update, run: python -m pip install --upgrade pip
(myenv) root@gabes:~#

```

# 14. `cryo-pyro/repo` 

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

# 15 `ukb-dt/repo-00 -> cryo-pyro/repo-00`

- footer
- header
- etc

# 16
# 17
# 18
# 19