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

## 06. API

```sh
#!/usr/bin/env bash
set -e

echo "=== GitHub Pages Hard Bootstrap ==="

read -p "GitHub username: " GH_USER
read -p "Repository name: " GH_REPO
read -s -p "GitHub Personal Access Token: " GH_TOKEN
echo

API="https://api.github.com"
REPO_API="$API/repos/$GH_USER/$GH_REPO"

# ---- create repo if missing ----
curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: token $GH_TOKEN" \
  "$REPO_API" | grep -q 200 || \
curl -s -X POST "$API/user/repos" \
  -H "Authorization: token $GH_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d "{
    \"name\": \"$GH_REPO\",
    \"private\": false,
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

EOF

git add index.md
git commit -m "bootstrap gh-pages"

# ---- remote ----
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GH_USER:$GH_TOKEN@github.com/$GH_USER/$GH_REPO.git"

# ---- FORCE ALIGN (intentional) ----
git push -f origin ukhona

# ---- enable Pages ----
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

```sh
#!/bin/bash

# scaffold-website.sh - Creates a clean static website structure
# Usage: ./scaffold-website.sh [project-name]

PROJECT_NAME="${1:-my-website}"

echo "🏗️  Scaffolding static website: $PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{ukhona/{html,css,js,img},docs}

# Create partials directory for HTML components
mkdir -p "$PROJECT_NAME/ukhona/html"/{head,body,footer}

# Create index.html with modular includes
cat > "$PROJECT_NAME/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <title>Project Title</title>
  <meta name="description" content="Project description">
  <link rel="canonical" href="https://example.com/">
  <meta name="robots" content="index,follow">
  <meta name="color-scheme" content="dark light">
  <meta name="theme-color" content="#0a0a0f">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="Site Name">
  <meta property="og:title" content="Page Title">
  <meta property="og:description" content="Page description">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://example.com/">
  
  <!-- Preconnect fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <!-- CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="ukhona/css/main.css">
  <link rel="stylesheet" href="ukhona/css/index.css">
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <!-- Header -->
  <header class="header" id="header"></header>

  <!-- Main sections -->
  <section class="hero" id="hero"></section>
  <main class="main-content">
    <section class="services-section" id="services-section"></section>
    <section class="metrics-section" id="metrics-section"></section>
  </main>

  <div class="modal-overlay" id="modal-overlay"></div>

  <!-- Footer -->
  <div id="footer-placeholder"></div>

  <!-- Scripts (Order matters!) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="ukhona/js/shared.js"></script>
  <script src="ukhona/js/index.js"></script>
</body>
</html>
EOF

# Create HTML partials
cat > "$PROJECT_NAME/ukhona/html/head/meta.html" << 'EOF'
<!-- Additional meta tags -->
<meta name="author" content="Your Name">
<meta name="keywords" content="keyword1, keyword2">
EOF

cat > "$PROJECT_NAME/ukhona/html/body/header.html" << 'EOF'
<nav class="navbar">
  <div class="nav-brand">
    <img src="ukhona/img/logo.png" alt="Logo">
  </div>
  <ul class="nav-menu">
    <li><a href="#home">Home</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</nav>
EOF

cat > "$PROJECT_NAME/ukhona/html/body/hero.html" << 'EOF'
<div class="hero-content">
  <h1>Welcome</h1>
  <p>Your tagline here</p>
  <button class="cta-button">Get Started</button>
</div>
EOF

cat > "$PROJECT_NAME/ukhona/html/body/services.html" << 'EOF'
<div class="services-grid">
  <div class="service-card">
    <i data-feather="zap"></i>
    <h3>Service One</h3>
    <p>Description of service one</p>
  </div>
  <div class="service-card">
    <i data-feather="shield"></i>
    <h3>Service Two</h3>
    <p>Description of service two</p>
  </div>
</div>
EOF

cat > "$PROJECT_NAME/ukhona/html/footer/footer.html" << 'EOF'
<footer class="site-footer">
  <div class="footer-content">
    <p>&copy; 2024 Company Name. All rights reserved.</p>
    <div class="footer-links">
      <a href="#privacy">Privacy</a>
      <a href="#terms">Terms</a>
      <a href="#contact">Contact</a>
    </div>
  </div>
</footer>
EOF

# Create shared.js for loading partials
cat > "$PROJECT_NAME/ukhona/js/shared.js" << 'EOF'
// shared.js - Load HTML partials into the page

async function loadPartial(selector, path) {
  try {
    const response = await fetch(path);
    const html = await response.text();
    const element = document.querySelector(selector);
    if (element) {
      element.innerHTML = html;
    }
  } catch (error) {
    console.error(`Failed to load ${path}:`, error);
  }
}

// Load all partials on page load
document.addEventListener('DOMContentLoaded', () => {
  loadPartial('#header', 'ukhona/html/body/header.html');
  loadPartial('#hero', 'ukhona/html/body/hero.html');
  loadPartial('#services-section', 'ukhona/html/body/services.html');
  loadPartial('#footer-placeholder', 'ukhona/html/footer/footer.html');
  
  // Initialize feather icons after content loads
  setTimeout(() => {
    if (typeof feather !== 'undefined') {
      feather.replace();
    }
  }, 100);
});

// Scroll progress indicator
window.addEventListener('scroll', () => {
  const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  const scrolled = (winScroll / height) * 100;
  const progress = document.querySelector('.scroll-progress');
  if (progress) {
    progress.style.width = scrolled + '%';
  }
});
EOF

# Create index.js for page-specific functionality
cat > "$PROJECT_NAME/ukhona/js/index.js" << 'EOF'
// index.js - Page-specific JavaScript

console.log('Index page loaded');

// Add your page-specific code here
EOF

# Create basic CSS
cat > "$PROJECT_NAME/ukhona/css/main.css" << 'EOF'
/* main.css - Global styles */

:root {
  --bg-primary: #0a0a0f;
  --bg-secondary: #1a1a24;
  --text-primary: #ffffff;
  --text-secondary: #a0a0b0;
  --accent: #4f46e5;
}

[data-theme="light"] {
  --bg-primary: #ffffff;
  --bg-secondary: #f5f5f5;
  --text-primary: #0a0a0f;
  --text-secondary: #505060;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  background-color: var(--bg-primary);
  color: var(--text-primary);
  line-height: 1.6;
}

.scroll-indicator {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 3px;
  background: var(--bg-secondary);
  z-index: 9999;
}

.scroll-progress {
  height: 100%;
  background: var(--accent);
  width: 0%;
  transition: width 0.2s ease;
}

.bg-pattern {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.03;
  pointer-events: none;
  background-image: 
    linear-gradient(45deg, var(--text-primary) 1px, transparent 1px),
    linear-gradient(-45deg, var(--text-primary) 1px, transparent 1px);
  background-size: 20px 20px;
  z-index: -1;
}
EOF

cat > "$PROJECT_NAME/ukhona/css/index.css" << 'EOF'
/* index.css - Page-specific styles */

.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 2rem;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  font-weight: 800;
}

.hero-content p {
  font-size: 1.25rem;
  color: var(--text-secondary);
  margin-bottom: 2rem;
}

.cta-button {
  background: var(--accent);
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s;
}

.cta-button:hover {
  transform: translateY(-2px);
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 3rem;
  background: var(--bg-secondary);
}

.nav-menu {
  display: flex;
  gap: 2rem;
  list-style: none;
}

.nav-menu a {
  color: var(--text-primary);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s;
}

.nav-menu a:hover {
  color: var(--accent);
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  padding: 4rem 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.service-card {
  background: var(--bg-secondary);
  padding: 2rem;
  border-radius: 12px;
  text-align: center;
}

.service-card i {
  width: 48px;
  height: 48px;
  margin-bottom: 1rem;
  color: var(--accent);
}

.site-footer {
  background: var(--bg-secondary);
  padding: 2rem;
  text-align: center;
  margin-top: 4rem;
}

.footer-links {
  display: flex;
  gap: 2rem;
  justify-content: center;
  margin-top: 1rem;
}

.footer-links a {
  color: var(--text-secondary);
  text-decoration: none;
}

.footer-links a:hover {
  color: var(--accent);
}
EOF

# Create README
cat > "$PROJECT_NAME/README.md" << 'EOF'
# Website Project

## Structure

```
.
├── index.html                 # Main entry point (clean, minimal)
├── ukhona/                    # Assets directory
│   ├── html/                  # HTML partials
│   │   ├── head/              # <head> components
│   │   ├── body/              # <body> sections (header, hero, services, etc.)
│   │   └── footer/            # Footer components
│   ├── css/                   # Stylesheets
│   ├── js/                    # JavaScript files
│   └── img/                   # Images
└── docs/                      # Documentation

```

## Usage

1. Open `index.html` in a browser (use a local server for partials to load)
2. Edit partials in `ukhona/html/` to modify page sections
3. Keep `index.html` clean - it just references the partials

## Local Development

```bash
# Python 3
python -m http.server 8000

# Or with Python 2
python -m SimpleHTTPServer 8000

# Then visit: http://localhost:8000
```

## Philosophy

- **Pure HTML in index.html** - No clutter, easy to audit
- **Modular partials** - Each section lives in its own file
- **Organized assets** - Everything in `ukhona/` subdirectories
- **Easy maintenance** - Non-coders can edit individual sections
EOF

echo "✅ Static website scaffolded: $PROJECT_NAME/"
echo ""
echo "📁 Structure:"
echo "   index.html (clean entry point)"
echo "   ukhona/html/{head,body,footer}/ (modular partials)"
echo "   ukhona/{css,js,img}/ (assets)"
echo ""
echo "🚀 To run:"
echo "   cd $PROJECT_NAME"
echo "   python -m http.server 8000"
echo "   # Visit http://localhost:8000"
```
# 13. Dynamic / Flask (Scaffold)

```sh
#!/bin/bash

# scaffold-flask.sh - Creates a Flask app with modular HTML structure
# Usage: ./scaffold-flask.sh [project-name]

PROJECT_NAME="${1:-my-flask-app}"

echo "🏗️  Scaffolding Flask app: $PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{app/{templates,static/{ukhona/{html,css,js,img}}},docs}

# Create partials directory
mkdir -p "$PROJECT_NAME/app/static/ukhona/html"/{head,body,footer}

# Create Flask app.py
cat > "$PROJECT_NAME/app.py" << 'EOF'
from flask import Flask, render_template, send_from_directory
import os

app = Flask(__name__, 
            template_folder='app/templates',
            static_folder='app/static')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

# Serve static files from ukhona directory
@app.route('/ukhona/<path:filename>')
def ukhona_files(filename):
    return send_from_directory('app/static/ukhona', filename)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
EOF

# Create requirements.txt
cat > "$PROJECT_NAME/requirements.txt" << 'EOF'
Flask==3.0.0
gunicorn==21.2.0
python-dotenv==1.0.0
EOF

# Create .env
cat > "$PROJECT_NAME/.env" << 'EOF'
FLASK_APP=app.py
FLASK_ENV=development
SECRET_KEY=change-this-in-production
EOF

# Create .gitignore
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
__pycache__/
*.py[cod]
*$py.class
*.so
.env
venv/
env/
.venv
instance/
.pytest_cache/
.coverage
htmlcov/
dist/
build/
*.egg-info/
.DS_Store
EOF

# Create base template
cat > "$PROJECT_NAME/app/templates/base.html" << 'EOF'
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <title>{% block title %}Flask App{% endblock %}</title>
  <meta name="description" content="{% block description %}Flask application{% endblock %}">
  <meta name="robots" content="index,follow">
  <meta name="color-scheme" content="dark light">
  <meta name="theme-color" content="#0a0a0f">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="{% block og_site %}Site Name{% endblock %}">
  <meta property="og:title" content="{% block og_title %}Page Title{% endblock %}">
  <meta property="og:description" content="{% block og_description %}Page description{% endblock %}">
  <meta property="og:type" content="website">
  
  <!-- Preconnect fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <!-- CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{ url_for('static', filename='ukhona/css/main.css') }}">
  {% block extra_css %}{% endblock %}
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <!-- Header -->
  <header class="header" id="header"></header>

  <!-- Main content -->
  {% block content %}{% endblock %}

  <div class="modal-overlay" id="modal-overlay"></div>

  <!-- Footer -->
  <div id="footer-placeholder"></div>

  <!-- Scripts (Order matters!) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="{{ url_for('static', filename='ukhona/js/shared.js') }}"></script>
  {% block extra_js %}{% endblock %}
</body>
</html>
EOF

# Create index template
cat > "$PROJECT_NAME/app/templates/index.html" << 'EOF'
{% extends "base.html" %}

{% block title %}Home - Flask App{% endblock %}
{% block description %}Welcome to our Flask application{% endblock %}

{% block extra_css %}
<link rel="stylesheet" href="{{ url_for('static', filename='ukhona/css/index.css') }}">
{% endblock %}

{% block content %}
<section class="hero" id="hero"></section>
<main class="main-content">
  <section class="services-section" id="services-section"></section>
  <section class="metrics-section" id="metrics-section"></section>
</main>
{% endblock %}

{% block extra_js %}
<script src="{{ url_for('static', filename='ukhona/js/index.js') }}"></script>
{% endblock %}
EOF

# Create about template
cat > "$PROJECT_NAME/app/templates/about.html" << 'EOF'
{% extends "base.html" %}

{% block title %}About - Flask App{% endblock %}
{% block description %}Learn more about us{% endblock %}

{% block extra_css %}
<link rel="stylesheet" href="{{ url_for('static', filename='ukhona/css/about.css') }}">
{% endblock %}

{% block content %}
<section class="about-hero">
  <h1>About Us</h1>
  <p>Our story and mission</p>
</section>
{% endblock %}
EOF

# Create HTML partials (same as static site)
cat > "$PROJECT_NAME/app/static/ukhona/html/body/header.html" << 'EOF'
<nav class="navbar">
  <div class="nav-brand">
    <img src="/ukhona/img/logo.png" alt="Logo" onerror="this.style.display='none'">
    <span class="brand-text">Flask App</span>
  </div>
  <ul class="nav-menu">
    <li><a href="/">Home</a></li>
    <li><a href="/about">About</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</nav>
EOF

cat > "$PROJECT_NAME/app/static/ukhona/html/body/hero.html" << 'EOF'
<div class="hero-content">
  <h1>Welcome to Flask</h1>
  <p>Build powerful web applications with Python</p>
  <button class="cta-button" onclick="window.location.href='/about'">Learn More</button>
</div>
EOF

cat > "$PROJECT_NAME/app/static/ukhona/html/body/services.html" << 'EOF'
<div class="services-grid">
  <div class="service-card">
    <i data-feather="zap"></i>
    <h3>Fast Development</h3>
    <p>Build applications quickly with Flask's simplicity</p>
  </div>
  <div class="service-card">
    <i data-feather="shield"></i>
    <h3>Secure</h3>
    <p>Built-in protection against common vulnerabilities</p>
  </div>
  <div class="service-card">
    <i data-feather="code"></i>
    <h3>Flexible</h3>
    <p>Extend with thousands of Python packages</p>
  </div>
</div>
EOF

cat > "$PROJECT_NAME/app/static/ukhona/html/footer/footer.html" << 'EOF'
<footer class="site-footer">
  <div class="footer-content">
    <p>&copy; 2024 Flask App. All rights reserved.</p>
    <div class="footer-links">
      <a href="/privacy">Privacy</a>
      <a href="/terms">Terms</a>
      <a href="/contact">Contact</a>
    </div>
  </div>
</footer>
EOF

# Create shared.js (same as static site but with Flask-aware paths)
cat > "$PROJECT_NAME/app/static/ukhona/js/shared.js" << 'EOF'
// shared.js - Load HTML partials into the page

async function loadPartial(selector, path) {
  try {
    const response = await fetch(path);
    const html = await response.text();
    const element = document.querySelector(selector);
    if (element) {
      element.innerHTML = html;
    }
  } catch (error) {
    console.error(`Failed to load ${path}:`, error);
  }
}

// Load all partials on page load
document.addEventListener('DOMContentLoaded', () => {
  loadPartial('#header', '/ukhona/html/body/header.html');
  loadPartial('#hero', '/ukhona/html/body/hero.html');
  loadPartial('#services-section', '/ukhona/html/body/services.html');
  loadPartial('#footer-placeholder', '/ukhona/html/footer/footer.html');
  
  // Initialize feather icons after content loads
  setTimeout(() => {
    if (typeof feather !== 'undefined') {
      feather.replace();
    }
  }, 100);
});

// Scroll progress indicator
window.addEventListener('scroll', () => {
  const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  const scrolled = (winScroll / height) * 100;
  const progress = document.querySelector('.scroll-progress');
  if (progress) {
    progress.style.width = scrolled + '%';
  }
});
EOF

cat > "$PROJECT_NAME/app/static/ukhona/js/index.js" << 'EOF'
// index.js - Homepage specific JavaScript

console.log('Index page loaded');

// Add your page-specific code here
EOF

# Create CSS files (same as static site)
cat > "$PROJECT_NAME/app/static/ukhona/css/main.css" << 'EOF'
/* main.css - Global styles */

:root {
  --bg-primary: #0a0a0f;
  --bg-secondary: #1a1a24;
  --text-primary: #ffffff;
  --text-secondary: #a0a0b0;
  --accent: #4f46e5;
}

[data-theme="light"] {
  --bg-primary: #ffffff;
  --bg-secondary: #f5f5f5;
  --text-primary: #0a0a0f;
  --text-secondary: #505060;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  background-color: var(--bg-primary);
  color: var(--text-primary);
  line-height: 1.6;
}

.scroll-indicator {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 3px;
  background: var(--bg-secondary);
  z-index: 9999;
}

.scroll-progress {
  height: 100%;
  background: var(--accent);
  width: 0%;
  transition: width 0.2s ease;
}

.bg-pattern {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.03;
  pointer-events: none;
  background-image: 
    linear-gradient(45deg, var(--text-primary) 1px, transparent 1px),
    linear-gradient(-45deg, var(--text-primary) 1px, transparent 1px);
  background-size: 20px 20px;
  z-index: -1;
}
EOF

cat > "$PROJECT_NAME/app/static/ukhona/css/index.css" << 'EOF'
/* index.css - Homepage styles */

.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 2rem;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  font-weight: 800;
}

.hero-content p {
  font-size: 1.25rem;
  color: var(--text-secondary);
  margin-bottom: 2rem;
}

.cta-button {
  background: var(--accent);
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s;
}

.cta-button:hover {
  transform: translateY(-2px);
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 3rem;
  background: var(--bg-secondary);
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.brand-text {
  font-size: 1.25rem;
  font-weight: 700;
}

.nav-menu {
  display: flex;
  gap: 2rem;
  list-style: none;
}

.nav-menu a {
  color: var(--text-primary);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s;
}

.nav-menu a:hover {
  color: var(--accent);
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  padding: 4rem 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.service-card {
  background: var(--bg-secondary);
  padding: 2rem;
  border-radius: 12px;
  text-align: center;
}

.service-card i {
  width: 48px;
  height: 48px;
  margin-bottom: 1rem;
  color: var(--accent);
}

.site-footer {
  background: var(--bg-secondary);
  padding: 2rem;
  text-align: center;
  margin-top: 4rem;
}

.footer-links {
  display: flex;
  gap: 2rem;
  justify-content: center;
  margin-top: 1rem;
}

.footer-links a {
  color: var(--text-secondary);
  text-decoration: none;
}

.footer-links a:hover {
  color: var(--accent);
}
EOF

cat > "$PROJECT_NAME/app/static/ukhona/css/about.css" << 'EOF'
/* about.css - About page styles */

.about-hero {
  min-height: 60vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 4rem 2rem;
}

.about-hero h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.about-hero p {
  font-size: 1.25rem;
  color: var(--text-secondary);
}
EOF

# Create README
cat > "$PROJECT_NAME/README.md" << 'EOF'
# Flask App

## Structure

```
.
├── app.py                          # Flask application
├── requirements.txt                # Python dependencies
├── .env                            # Environment variables
├── app/
│   ├── templates/                  # Jinja2 templates
│   │   ├── base.html               # Base template
│   │   ├── index.html              # Homepage
│   │   └── about.html              # About page
│   └── static/
│       └── ukhona/                 # Assets (same structure as static site)
│           ├── html/               # HTML partials
│           │   ├── head/
│           │   ├── body/
│           │   └── footer/
│           ├── css/
│           ├── js/
│           └── img/
└── docs/                           # Documentation
```

## Setup

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Run

```bash
# Development
python app.py

# Production (with gunicorn)
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```      

Visit: http://localhost:5000

## Philosophy

- **Jinja2 templates** for dynamic content
- **Same modular structure** as static site (ukhona/ partials)
- **Flask routes** for backend logic
- **Easy to maintain** - non-coders can still edit HTML partials
- **Scalable** - Add routes, blueprints, database as needed

## Adding Routes

Edit `app.py`:

```python
@app.route('/new-page')
def new_page():
    return render_template('new_page.html')
```

Create `app/templates/new_page.html` extending `base.html`.
EOF

echo "✅ Flask app scaffolded: $PROJECT_NAME/"
echo ""
echo "📁 Structure:"
echo "   app.py (Flask application)"
echo "   app/templates/ (Jinja2 templates)"
echo "   app/static/ukhona/ (same modular structure)"
echo ""
echo "🚀 To run:"
echo "   cd $PROJECT_NAME"
echo "   python -m venv venv"
echo "   source venv/bin/activate  # or venv\\Scripts\\activate on Windows"
echo "   pip install -r requirements.txt"
echo "   python app.py"
echo "   # Visit http://localhost:5000"
```