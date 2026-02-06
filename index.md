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

See `ukhona/static.sh`

# 13. Dynamic / Flask (Scaffold)

See `ukhona/dynamic.sh`

# 13. Onboarding Windows (Drama)

```sh
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.6.87.2-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Feb  4 15:57:39 EAT 2026

  System load:  0.08                Processes:             58
  Usage of /:   0.1% of 1006.85GB   Users logged in:       0
  Memory usage: 6%                  IPv4 address for eth0: 172.28.158.63
  Swap usage:   0%


This message is shown once a day. To disable it please create the
/root/.hushlogin file.
root@gabes:~# ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub
Generating public/private ed25519 key pair.
Enter file in which to save the key (/root/.ssh/id_ed25519): local
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in local
Your public key has been saved in local.pub
The key fingerprint is:
SHA256:9ct58bjJvy8EUOP/1tf06UzB+HQCv/VeZmGHkb7zcn8 your@email.com
The key's randomart image is:
+--[ED25519 256]--+
|           .o    |
|          .. . . |
|          ..o o  |
|         . ..=oo |
|        S   .oB*=|
|           . o=@@|
|            +.*+&|
|             o*XE|
|              +O@|
+----[SHA256]-----+
cat: /root/.ssh/id_ed25519.pub: No such file or directory
root@gabes:~# curl https://pyenv.run | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   270  100   270    0     0    125      0  0:00:02  0:00:02 --:--:--   125
Cloning into '/root/.pyenv'...
remote: Enumerating objects: 1514, done.
remote: Counting objects: 100% (1514/1514), done.
remote: Compressing objects: 100% (741/741), done.
remote: Total 1514 (delta 919), reused 967 (delta 605), pack-reused 0 (from 0)
Receiving objects: 100% (1514/1514), 1.19 MiB | 2.33 MiB/s, done.
Resolving deltas: 100% (919/919), done.
Cloning into '/root/.pyenv/plugins/pyenv-doctor'...
remote: Enumerating objects: 11, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 11 (delta 1), reused 5 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (11/11), 38.72 KiB | 285.00 KiB/s, done.
Resolving deltas: 100% (1/1), done.
Cloning into '/root/.pyenv/plugins/pyenv-update'...
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 10 (delta 1), reused 6 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (10/10), done.
Resolving deltas: 100% (1/1), done.
Cloning into '/root/.pyenv/plugins/pyenv-virtualenv'...
remote: Enumerating objects: 66, done.
remote: Counting objects: 100% (66/66), done.
remote: Compressing objects: 100% (59/59), done.
remote: Total 66 (delta 10), reused 25 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (66/66), 46.00 KiB | 1.09 MiB/s, done.
Resolving deltas: 100% (10/10), done.

WARNING: seems you still have not added 'pyenv' to the load path.

# Load pyenv automatically by appending
# the following to
# ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
# and ~/.bashrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# Restart your shell for the changes to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"

root@gabes:~# # then add to ~/.bashrc or ~/.zshrc:
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
root@gabes:~# pyenv install 3.11.12
pyenv virtualenv 3.11.12 myenv
pyenv activate myenv
Downloading Python-3.11.12.tar.xz...
-> https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
Installing Python-3.11.12...
patching file setup.py

BUILD FAILED (Ubuntu 22.04 using python-build 2.6.22)

Inspect or clean up the working tree at /tmp/python-build.20260204172901.853
Results logged to /tmp/python-build.20260204172901.853.log

Last 10 log lines:
checking for pkg-config... no
checking for --enable-universalsdk... no
checking for --with-universal-archs... no
checking MACHDEP... "linux"
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/python-build.20260204172901.853/Python-3.11.12':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
pyenv-virtualenv: `3.11.12' is not installed in pyenv.
Run `pyenv install 3.11.12' to install it.

`pyenv activate' requires Pyenv and Pyenv-Virtualenv to be loaded into your shell.
Check your shell configuration and Pyenv and Pyenv-Virtualenv installation instructions.

root@gabes:~# pip install pandas matplotlib seaborn plotly jupyter
Command 'pip' not found, did you mean:
  command 'ip' from deb iproute2 (5.15.0-1ubuntu2)
  command 'pic' from deb groff-base (1.22.4-8build1)
  command 'php' from deb php8.1-cli (8.1.2-1ubuntu2.19)
  command 'php' from deb php-cli (2:8.1+92ubuntu1)
  command 'zip' from deb zip (3.0-12build2)
Try: apt install <deb name>
root@gabes:~# pyenv install 3.11.12
pyenv virtualenv 3.11.12 myenv
pyenv activate myenv
Downloading Python-3.11.12.tar.xz...
-> https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
Installing Python-3.11.12...
patching file setup.py

BUILD FAILED (Ubuntu 22.04 using python-build 2.6.22)

Inspect or clean up the working tree at /tmp/python-build.20260204173054.1424
Results logged to /tmp/python-build.20260204173054.1424.log

Last 10 log lines:
checking for pkg-config... no
checking for --enable-universalsdk... no
checking for --with-universal-archs... no
checking MACHDEP... "linux"
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/python-build.20260204173054.1424/Python-3.11.12':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
pyenv-virtualenv: `3.11.12' is not installed in pyenv.
Run `pyenv install 3.11.12' to install it.

`pyenv activate' requires Pyenv and Pyenv-Virtualenv to be loaded into your shell.
Check your shell configuration and Pyenv and Pyenv-Virtualenv installation instructions.

root@gabes:~# ls
local  local.pub
root@gabes:~# git add .
git commit -m "Initial behavioral health analysis"
git push
fatal: not a git repository (or any of the parent directories): .git
fatal: not a git repository (or any of the parent directories): .git
fatal: not a git repository (or any of the parent directories): .git
root@gabes:~# wsl --install
Command 'wsl' not found, but can be installed with:
apt install wsl
root@gabes:~# apt install wsl
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libxml2-utils libxslt1.1 xsltproc
The following NEW packages will be installed:
  libxml2-utils libxslt1.1 wsl xsltproc
0 upgraded, 4 newly installed, 0 to remove and 140 not upgraded.
Need to get 238 kB of archives.
After this operation, 996 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxml2-utils amd64 2.9.13+dfsg-1ubuntu0.11 [40.2 kB]
Get:2 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxslt1.1 amd64 1.1.34-4ubuntu0.22.04.5 [165 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy/universe amd64 wsl all 0.2.1-3 [18.7 kB]
Get:4 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 xsltproc amd64 1.1.34-4ubuntu0.22.04.5 [14.7 kB]
Fetched 238 kB in 2s (108 kB/s)
Selecting previously unselected package libxml2-utils.
(Reading database ... 42578 files and directories currently installed.)
Preparing to unpack .../libxml2-utils_2.9.13+dfsg-1ubuntu0.11_amd64.deb ...
Unpacking libxml2-utils (2.9.13+dfsg-1ubuntu0.11) ...
Selecting previously unselected package libxslt1.1:amd64.
Preparing to unpack .../libxslt1.1_1.1.34-4ubuntu0.22.04.5_amd64.deb ...
Unpacking libxslt1.1:amd64 (1.1.34-4ubuntu0.22.04.5) ...
Selecting previously unselected package wsl.
Preparing to unpack .../archives/wsl_0.2.1-3_all.deb ...
Unpacking wsl (0.2.1-3) ...
Selecting previously unselected package xsltproc.
Preparing to unpack .../xsltproc_1.1.34-4ubuntu0.22.04.5_amd64.deb ...
Unpacking xsltproc (1.1.34-4ubuntu0.22.04.5) ...
Setting up libxslt1.1:amd64 (1.1.34-4ubuntu0.22.04.5) ...
Setting up libxml2-utils (2.9.13+dfsg-1ubuntu0.11) ...
Setting up wsl (0.2.1-3) ...
Setting up xsltproc (1.1.34-4ubuntu0.22.04.5) ...
Processing triggers for libc-bin (2.35-0ubuntu3.8) ...
Processing triggers for man-db (2.10.2-1) ...
root@gabes:~# sudo apt update && sudo apt upgrade -y
Hit:1 http://archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Get:5 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [3200 kB]
Get:6 http://security.ubuntu.com/ubuntu jammy-security/main amd64 Packages [2934 kB]
Get:7 http://archive.ubuntu.com/ubuntu jammy-updates/main Translation-en [490 kB]
Get:8 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 c-n-f Metadata [19.1 kB]
Get:9 http://archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [5196 kB]
Get:10 http://security.ubuntu.com/ubuntu jammy-security/main Translation-en [421 kB]
Get:11 http://security.ubuntu.com/ubuntu jammy-security/main amd64 c-n-f Metadata [14.1 kB]
Get:12 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [5026 kB]
Get:13 http://archive.ubuntu.com/ubuntu jammy-updates/restricted Translation-en [976 kB]
Get:14 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1252 kB]
Get:15 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 c-n-f Metadata [30.2 kB]
Get:16 http://security.ubuntu.com/ubuntu jammy-security/restricted Translation-en [947 kB]
Get:17 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [1015 kB]
Get:18 http://security.ubuntu.com/ubuntu jammy-security/universe Translation-en [223 kB]
Get:19 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 c-n-f Metadata [22.5 kB]
Fetched 22.2 MB in 10s (2260 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
140 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done
The following NEW packages will be installed:
  wsl-pro-service
The following packages will be upgraded:
  apparmor apport apt apt-utils bind9-dnsutils bind9-host bind9-libs
  binutils binutils-common binutils-x86-64-linux-gnu cloud-init curl
  dconf-gsettings-backend dconf-service dirmngr distro-info-data dmsetup
  dpkg gcc-12-base git git-man gnupg gnupg-l10n gnupg-utils gpg gpg-agent
  gpg-wks-client gpg-wks-server gpgconf gpgsm gpgv iputils-ping
  iputils-tracepath landscape-client landscape-common libapparmor1
  libapt-pkg6.0 libavahi-client3 libavahi-common-data libavahi-common3
  libbinutils libc-bin libc6 libcap2 libcap2-bin libcryptsetup12
  libctf-nobfd0 libctf0 libcups2 libcurl3-gnutls libcurl4 libdconf1
  libdevmapper1.02.1 libdw1 libelf1 libexpat1 libfreetype6 libgcc-s1
  libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-bin libgdk-pixbuf2.0-common
  libglib2.0-0 libglib2.0-bin libglib2.0-data libgnutls30 libgssapi-krb5-2
  libharfbuzz0b libk5crypto3 libkrb5-3 libkrb5support0 libldap-2.5-0
  libldap-common libnss-systemd libpam-cap libpam-modules
  libpam-modules-bin libpam-runtime libpam-systemd libpam0g libperl5.34
  libpng16-16 libpython3.10 libpython3.10-minimal libpython3.10-stdlib
  libseccomp2 libsodium23 libsqlite3-0 libssh-4 libssl3 libstdc++6
  libsystemd0 libtasn1-6 libtiff5 libudev1 libxml2 locales openssh-client
  openssl pci.ids perl perl-base perl-modules-5.34 powermgmt-base
  python-apt-common python3-apport python3-apt python3-attr python3-jinja2
  python3-pkg-resources python3-problem-report python3-pyasn1
  python3-requests python3-setuptools python3-update-manager
  python3-urllib3 python3.10 python3.10-minimal rsync screen snapd sudo
  systemd systemd-hwe-hwdb systemd-sysv systemd-timesyncd tzdata
  ubuntu-advantage-tools ubuntu-minimal ubuntu-pro-client
  ubuntu-pro-client-l10n ubuntu-standard ubuntu-wsl udev
  update-manager-core vim vim-common vim-runtime vim-tiny wsl-setup xxd
140 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
100 standard LTS security updates
Need to get 57.8 MB/113 MB of archives.
After this operation, 26.6 MB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnss-systemd amd64 249.11-0ubuntu3.17 [133 kB]
Get:2 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libsystemd0 amd64 249.11-0ubuntu3.17 [317 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 systemd-timesyncd amd64 249.11-0ubuntu3.17 [31.2 kB]
Get:4 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 systemd-sysv amd64 249.11-0ubuntu3.17 [10.5 kB]
Get:5 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libpam-systemd amd64 249.11-0ubuntu3.17 [203 kB]
Get:6 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 systemd amd64 249.11-0ubuntu3.17 [4583 kB]
Get:7 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 udev amd64 249.11-0ubuntu3.17 [1557 kB]
Get:8 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libudev1 amd64 249.11-0ubuntu3.17 [76.7 kB]
Get:9 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libapparmor1 amd64 3.0.4-2ubuntu2.5 [39.6 kB]
Get:10 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libdevmapper1.02.1 amd64 2:1.02.175-2.1ubuntu5 [139 kB]
Get:11 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libcryptsetup12 amd64 2:2.4.3-1ubuntu1.3 [211 kB]
Get:12 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libseccomp2 amd64 2.5.3-2ubuntu3~22.04.1 [47.4 kB]
Get:13 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libapt-pkg6.0 amd64 2.4.14 [912 kB]
Get:14 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 apt amd64 2.4.14 [1363 kB]
Get:15 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 apt-utils amd64 2.4.14 [211 kB]
Get:16 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libldap-2.5-0 amd64 2.5.20+dfsg-0ubuntu0.22.04.1 [184 kB]
Get:17 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libpython3.10 amd64 3.10.12-1~22.04.14 [1949 kB]
Get:18 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 python3.10 amd64 3.10.12-1~22.04.14 [509 kB]
Get:19 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libpython3.10-stdlib amd64 3.10.12-1~22.04.14 [1850 kB]
Get:20 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 python3.10-minimal amd64 3.10.12-1~22.04.14 [2275 kB]
Get:21 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libpython3.10-minimal amd64 3.10.12-1~22.04.14 [816 kB]
Get:22 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.11 [5444 B]
Get:23 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 dmsetup amd64 2:1.02.175-2.1ubuntu5 [81.7 kB]
Get:24 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libglib2.0-data all 2.72.4-0ubuntu2.9 [5088 B]
Get:25 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libglib2.0-bin amd64 2.72.4-0ubuntu2.9 [80.9 kB]
Get:26 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libglib2.0-0 amd64 2.72.4-0ubuntu2.9 [1467 kB]
Get:27 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-pro-client-l10n amd64 37.1ubuntu0~22.04 [20.7 kB]
Get:28 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-pro-client amd64 37.1ubuntu0~22.04 [238 kB]
Get:29 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-advantage-tools all 37.1ubuntu0~22.04 [10.9 kB]
Get:30 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-minimal amd64 1.481.5 [2900 B]
Get:31 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 apparmor amd64 3.0.4-2ubuntu2.5 [599 kB]
Get:32 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 pci.ids all 0.0~2022.01.22-1ubuntu0.1 [251 kB]
Get:33 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 powermgmt-base all 1.36ubuntu0.22.04.1 [7736 B]
Get:34 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 python3-update-manager all 1:22.04.22 [39.2 kB]
Get:35 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 update-manager-core all 1:22.04.22 [11.6 kB]
Get:36 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-standard amd64 1.481.5 [2920 B]
Get:37 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 dconf-service amd64 0.40.0-3ubuntu0.1 [28.1 kB]
Get:38 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 dconf-gsettings-backend amd64 0.40.0-3ubuntu0.1 [22.7 kB]
Get:39 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libdconf1 amd64 0.40.0-3ubuntu0.1 [40.5 kB]
Get:40 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 landscape-client amd64 23.02-0ubuntu1~22.04.7 [113 kB]
Get:41 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 landscape-common amd64 23.02-0ubuntu1~22.04.7 [88.9 kB]
Get:42 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libldap-common all 2.5.20+dfsg-0ubuntu0.22.04.1 [16.4 kB]
Get:43 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 python3-attr all 21.2.0-1ubuntu1 [43.9 kB]
Get:44 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 snapd amd64 2.73+ubuntu22.04 [32.3 MB]
Get:45 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 systemd-hwe-hwdb all 249.11.6 [3668 B]
Get:46 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 cloud-init all 25.2-0ubuntu1~22.04.1 [586 kB]
Get:47 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 wsl-setup amd64 0.5.8~22.04.1 [20.4 kB]
Get:48 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-wsl amd64 1.481.5 [2870 B]
Get:49 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 wsl-pro-service amd64 0.1.18~22.04.2 [4301 kB]
Fetched 57.8 MB in 18s (3293 kB/s)
Extracting templates from packages: 100%
Preconfiguring packages ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../gcc-12-base_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking gcc-12-base:amd64 (12.3.0-1ubuntu1~22.04.2) over (12.3.0-1ubuntu1~22.04) ...
Setting up gcc-12-base:amd64 (12.3.0-1ubuntu1~22.04.2) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libgcc-s1_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libgcc-s1:amd64 (12.3.0-1ubuntu1~22.04.2) over (12.3.0-1ubuntu1~22.04) ...
Setting up libgcc-s1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libstdc++6_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libstdc++6:amd64 (12.3.0-1ubuntu1~22.04.2) over (12.3.0-1ubuntu1~22.04) ...
Setting up libstdc++6:amd64 (12.3.0-1ubuntu1~22.04.2) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libc6_2.35-0ubuntu3.13_amd64.deb ...
Unpacking libc6:amd64 (2.35-0ubuntu3.13) over (2.35-0ubuntu3.8) ...
Setting up libc6:amd64 (2.35-0ubuntu3.13) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libnss-systemd_249.11-0ubuntu3.17_amd64.deb ...
Unpacking libnss-systemd:amd64 (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Preparing to unpack .../libsystemd0_249.11-0ubuntu3.17_amd64.deb ...
Unpacking libsystemd0:amd64 (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Setting up libsystemd0:amd64 (249.11-0ubuntu3.17) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../0-systemd-timesyncd_249.11-0ubuntu3.17_amd64.deb ...
Unpacking systemd-timesyncd (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Preparing to unpack .../1-systemd-sysv_249.11-0ubuntu3.17_amd64.deb ...
Unpacking systemd-sysv (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Preparing to unpack .../2-libpam-systemd_249.11-0ubuntu3.17_amd64.deb ...
Unpacking libpam-systemd:amd64 (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Preparing to unpack .../3-systemd_249.11-0ubuntu3.17_amd64.deb ...
Unpacking systemd (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Preparing to unpack .../4-udev_249.11-0ubuntu3.17_amd64.deb ...
Unpacking udev (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Preparing to unpack .../5-libudev1_249.11-0ubuntu3.17_amd64.deb ...
Unpacking libudev1:amd64 (249.11-0ubuntu3.17) over (249.11-0ubuntu3.12) ...
Setting up libudev1:amd64 (249.11-0ubuntu3.17) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libcap2_1%3a2.44-1ubuntu0.22.04.2_amd64.deb ...
Unpacking libcap2:amd64 (1:2.44-1ubuntu0.22.04.2) over (1:2.44-1ubuntu0.22.04.1) ...
Setting up libcap2:amd64 (1:2.44-1ubuntu0.22.04.2) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libpam0g_1.4.0-11ubuntu2.6_amd64.deb ...
Unpacking libpam0g:amd64 (1.4.0-11ubuntu2.6) over (1.4.0-11ubuntu2.4) ...
Setting up libpam0g:amd64 (1.4.0-11ubuntu2.6) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libpam-modules-bin_1.4.0-11ubuntu2.6_amd64.deb ...
Unpacking libpam-modules-bin (1.4.0-11ubuntu2.6) over (1.4.0-11ubuntu2.4) ...
Setting up libpam-modules-bin (1.4.0-11ubuntu2.6) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libpam-modules_1.4.0-11ubuntu2.6_amd64.deb ...
Unpacking libpam-modules:amd64 (1.4.0-11ubuntu2.6) over (1.4.0-11ubuntu2.4) ...
Setting up libpam-modules:amd64 (1.4.0-11ubuntu2.6) ...
Installing new version of config file /etc/security/namespace.init ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libpam-runtime_1.4.0-11ubuntu2.6_all.deb ...
Unpacking libpam-runtime (1.4.0-11ubuntu2.6) over (1.4.0-11ubuntu2.4) ...
Setting up libpam-runtime (1.4.0-11ubuntu2.6) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libapparmor1_3.0.4-2ubuntu2.5_amd64.deb ...
Unpacking libapparmor1:amd64 (3.0.4-2ubuntu2.5) over (3.0.4-2ubuntu2.4) ...
Preparing to unpack .../libdevmapper1.02.1_2%3a1.02.175-2.1ubuntu5_amd64.deb ...
Unpacking libdevmapper1.02.1:amd64 (2:1.02.175-2.1ubuntu5) over (2:1.02.175-2.1ubuntu4) ...
Preparing to unpack .../libssl3_3.0.2-0ubuntu1.21_amd64.deb ...
Unpacking libssl3:amd64 (3.0.2-0ubuntu1.21) over (3.0.2-0ubuntu1.18) ...
Setting up libssl3:amd64 (3.0.2-0ubuntu1.21) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libcryptsetup12_2%3a2.4.3-1ubuntu1.3_amd64.deb ...
Unpacking libcryptsetup12:amd64 (2:2.4.3-1ubuntu1.3) over (2:2.4.3-1ubuntu1.2) ...
Preparing to unpack .../libtasn1-6_4.18.0-4ubuntu0.2_amd64.deb ...
Unpacking libtasn1-6:amd64 (4.18.0-4ubuntu0.2) over (4.18.0-4build1) ...
Setting up libtasn1-6:amd64 (4.18.0-4ubuntu0.2) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libgnutls30_3.7.3-4ubuntu1.7_amd64.deb ...
Unpacking libgnutls30:amd64 (3.7.3-4ubuntu1.7) over (3.7.3-4ubuntu1.5) ...
Setting up libgnutls30:amd64 (3.7.3-4ubuntu1.7) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libseccomp2_2.5.3-2ubuntu3~22.04.1_amd64.deb ...
Unpacking libseccomp2:amd64 (2.5.3-2ubuntu3~22.04.1) over (2.5.3-2ubuntu2) ...
Setting up libseccomp2:amd64 (2.5.3-2ubuntu3~22.04.1) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libapt-pkg6.0_2.4.14_amd64.deb ...
Unpacking libapt-pkg6.0:amd64 (2.4.14) over (2.4.13) ...
Setting up libapt-pkg6.0:amd64 (2.4.14) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../dpkg_1.21.1ubuntu2.6_amd64.deb ...
Unpacking dpkg (1.21.1ubuntu2.6) over (1.21.1ubuntu2.3) ...
Setting up dpkg (1.21.1ubuntu2.6) ...
dpkg-db-backup.service is a disabled or a static unit not running, not starting it.
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libperl5.34_5.34.0-3ubuntu1.5_amd64.deb ...
Unpacking libperl5.34:amd64 (5.34.0-3ubuntu1.5) over (5.34.0-3ubuntu1.3) ...
Preparing to unpack .../perl_5.34.0-3ubuntu1.5_amd64.deb ...
Unpacking perl (5.34.0-3ubuntu1.5) over (5.34.0-3ubuntu1.3) ...
Preparing to unpack .../perl-base_5.34.0-3ubuntu1.5_amd64.deb ...
Unpacking perl-base (5.34.0-3ubuntu1.5) over (5.34.0-3ubuntu1.3) ...
Setting up perl-base (5.34.0-3ubuntu1.5) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../perl-modules-5.34_5.34.0-3ubuntu1.5_all.deb ...
Unpacking perl-modules-5.34 (5.34.0-3ubuntu1.5) over (5.34.0-3ubuntu1.3) ...
Preparing to unpack .../libc-bin_2.35-0ubuntu3.13_amd64.deb ...
Unpacking libc-bin (2.35-0ubuntu3.13) over (2.35-0ubuntu3.8) ...
Setting up libc-bin (2.35-0ubuntu3.13) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../archives/apt_2.4.14_amd64.deb ...
Unpacking apt (2.4.14) over (2.4.13) ...
Setting up apt (2.4.14) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../00-apt-utils_2.4.14_amd64.deb ...
Unpacking apt-utils (2.4.14) over (2.4.13) ...
Preparing to unpack .../01-gpg-wks-client_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpg-wks-client (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../02-dirmngr_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking dirmngr (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../03-gpg-wks-server_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpg-wks-server (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../04-gnupg-utils_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gnupg-utils (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../05-gpg-agent_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpg-agent (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../06-gpg_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpg (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../07-gpgconf_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpgconf (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../08-gnupg-l10n_2.2.27-3ubuntu2.5_all.deb ...
Unpacking gnupg-l10n (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../09-gnupg_2.2.27-3ubuntu2.5_all.deb ...
Unpacking gnupg (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../10-gpgsm_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpgsm (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Preparing to unpack .../11-libsqlite3-0_3.37.2-2ubuntu0.5_amd64.deb ...
Unpacking libsqlite3-0:amd64 (3.37.2-2ubuntu0.5) over (3.37.2-2ubuntu0.3) ...
Preparing to unpack .../12-libldap-2.5-0_2.5.20+dfsg-0ubuntu0.22.04.1_amd64.deb ...
Unpacking libldap-2.5-0:amd64 (2.5.20+dfsg-0ubuntu0.22.04.1) over (2.5.18+dfsg-0ubuntu0.22.04.2) ...
Preparing to unpack .../13-gpgv_2.2.27-3ubuntu2.5_amd64.deb ...
Unpacking gpgv (2.2.27-3ubuntu2.5) over (2.2.27-3ubuntu2.1) ...
Setting up gpgv (2.2.27-3ubuntu2.5) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../0-libexpat1_2.4.7-1ubuntu0.6_amd64.deb ...
Unpacking libexpat1:amd64 (2.4.7-1ubuntu0.6) over (2.4.7-1ubuntu0.5) ...
Preparing to unpack .../1-libpython3.10_3.10.12-1~22.04.14_amd64.deb ...
Unpacking libpython3.10:amd64 (3.10.12-1~22.04.14) over (3.10.12-1~22.04.7) ...
Preparing to unpack .../2-python3.10_3.10.12-1~22.04.14_amd64.deb ...
Unpacking python3.10 (3.10.12-1~22.04.14) over (3.10.12-1~22.04.7) ...
Preparing to unpack .../3-libpython3.10-stdlib_3.10.12-1~22.04.14_amd64.deb ...
Unpacking libpython3.10-stdlib:amd64 (3.10.12-1~22.04.14) over (3.10.12-1~22.04.7) ...
Preparing to unpack .../4-python3.10-minimal_3.10.12-1~22.04.14_amd64.deb ...
Unpacking python3.10-minimal (3.10.12-1~22.04.14) over (3.10.12-1~22.04.7) ...
Preparing to unpack .../5-libpython3.10-minimal_3.10.12-1~22.04.14_amd64.deb ...
Unpacking libpython3.10-minimal:amd64 (3.10.12-1~22.04.14) over (3.10.12-1~22.04.7) ...
Preparing to unpack .../6-rsync_3.2.7-0ubuntu0.22.04.4_amd64.deb ...
Unpacking rsync (3.2.7-0ubuntu0.22.04.4) over (3.2.7-0ubuntu0.22.04.2) ...
Preparing to unpack .../7-libk5crypto3_1.19.2-2ubuntu0.7_amd64.deb ...
Unpacking libk5crypto3:amd64 (1.19.2-2ubuntu0.7) over (1.19.2-2ubuntu0.4) ...
Setting up libk5crypto3:amd64 (1.19.2-2ubuntu0.7) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libkrb5support0_1.19.2-2ubuntu0.7_amd64.deb ...
Unpacking libkrb5support0:amd64 (1.19.2-2ubuntu0.7) over (1.19.2-2ubuntu0.4) ...
Setting up libkrb5support0:amd64 (1.19.2-2ubuntu0.7) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libkrb5-3_1.19.2-2ubuntu0.7_amd64.deb ...
Unpacking libkrb5-3:amd64 (1.19.2-2ubuntu0.7) over (1.19.2-2ubuntu0.4) ...
Setting up libkrb5-3:amd64 (1.19.2-2ubuntu0.7) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../libgssapi-krb5-2_1.19.2-2ubuntu0.7_amd64.deb ...
Unpacking libgssapi-krb5-2:amd64 (1.19.2-2ubuntu0.7) over (1.19.2-2ubuntu0.4) ...
Setting up libgssapi-krb5-2:amd64 (1.19.2-2ubuntu0.7) ...
(Reading database ... 42639 files and directories currently installed.)
Preparing to unpack .../00-distro-info-data_0.52ubuntu0.11_all.deb ...
Unpacking distro-info-data (0.52ubuntu0.11) over (0.52ubuntu0.8) ...
Preparing to unpack .../01-dmsetup_2%3a1.02.175-2.1ubuntu5_amd64.deb ...
Unpacking dmsetup (2:1.02.175-2.1ubuntu5) over (2:1.02.175-2.1ubuntu4) ...
Preparing to unpack .../02-libpam-cap_1%3a2.44-1ubuntu0.22.04.2_amd64.deb ...
Unpacking libpam-cap:amd64 (1:2.44-1ubuntu0.22.04.2) over (1:2.44-1ubuntu0.22.04.1) ...
Preparing to unpack .../03-libcap2-bin_1%3a2.44-1ubuntu0.22.04.2_amd64.deb ...
Unpacking libcap2-bin (1:2.44-1ubuntu0.22.04.2) over (1:2.44-1ubuntu0.22.04.1) ...
Preparing to unpack .../04-iputils-ping_3%3a20211215-1ubuntu0.1_amd64.deb ...
Unpacking iputils-ping (3:20211215-1ubuntu0.1) over (3:20211215-1) ...
Preparing to unpack .../05-libdw1_0.186-1ubuntu0.1_amd64.deb ...
Unpacking libdw1:amd64 (0.186-1ubuntu0.1) over (0.186-1build1) ...
Preparing to unpack .../06-libelf1_0.186-1ubuntu0.1_amd64.deb ...
Unpacking libelf1:amd64 (0.186-1ubuntu0.1) over (0.186-1build1) ...
Preparing to unpack .../07-libglib2.0-data_2.72.4-0ubuntu2.9_all.deb ...
Unpacking libglib2.0-data (2.72.4-0ubuntu2.9) over (2.72.4-0ubuntu2.4) ...
Preparing to unpack .../08-libglib2.0-bin_2.72.4-0ubuntu2.9_amd64.deb ...
Unpacking libglib2.0-bin (2.72.4-0ubuntu2.9) over (2.72.4-0ubuntu2.4) ...
Preparing to unpack .../09-libglib2.0-0_2.72.4-0ubuntu2.9_amd64.deb ...
Unpacking libglib2.0-0:amd64 (2.72.4-0ubuntu2.9) over (2.72.4-0ubuntu2.4) ...
Preparing to unpack .../10-libxml2_2.9.13+dfsg-1ubuntu0.11_amd64.deb ...
Unpacking libxml2:amd64 (2.9.13+dfsg-1ubuntu0.11) over (2.9.13+dfsg-1ubuntu0.4) ...
Preparing to unpack .../11-locales_2.35-0ubuntu3.13_all.deb ...
Unpacking locales (2.35-0ubuntu3.13) over (2.35-0ubuntu3.8) ...
Preparing to unpack .../12-openssl_3.0.2-0ubuntu1.21_amd64.deb ...
Unpacking openssl (3.0.2-0ubuntu1.21) over (3.0.2-0ubuntu1.18) ...
Preparing to unpack .../13-python-apt-common_2.4.0ubuntu4.1_all.deb ...
Unpacking python-apt-common (2.4.0ubuntu4.1) over (2.4.0ubuntu4) ...
Preparing to unpack .../14-python3-apt_2.4.0ubuntu4.1_amd64.deb ...
Unpacking python3-apt (2.4.0ubuntu4.1) over (2.4.0ubuntu4) ...
Preparing to unpack .../15-python3-setuptools_59.6.0-1.2ubuntu0.22.04.3_all.deb ...
Unpacking python3-setuptools (59.6.0-1.2ubuntu0.22.04.3) over (59.6.0-1.2ubuntu0.22.04.2) ...
Preparing to unpack .../16-python3-pkg-resources_59.6.0-1.2ubuntu0.22.04.3_all.deb ...
Unpacking python3-pkg-resources (59.6.0-1.2ubuntu0.22.04.3) over (59.6.0-1.2ubuntu0.22.04.2) ...
Preparing to unpack .../17-sudo_1.9.9-1ubuntu2.5_amd64.deb ...
Unpacking sudo (1.9.9-1ubuntu2.5) over (1.9.9-1ubuntu2.4) ...
Preparing to unpack .../18-tzdata_2025b-0ubuntu0.22.04.1_all.deb ...
Unpacking tzdata (2025b-0ubuntu0.22.04.1) over (2024a-0ubuntu0.22.04.1) ...
Preparing to unpack .../19-ubuntu-pro-client-l10n_37.1ubuntu0~22.04_amd64.deb ...
Unpacking ubuntu-pro-client-l10n (37.1ubuntu0~22.04) over (34~22.04) ...
Preparing to unpack .../20-ubuntu-pro-client_37.1ubuntu0~22.04_amd64.deb ...
Unpacking ubuntu-pro-client (37.1ubuntu0~22.04) over (34~22.04) ...
Preparing to unpack .../21-ubuntu-advantage-tools_37.1ubuntu0~22.04_all.deb ...
Unpacking ubuntu-advantage-tools (37.1ubuntu0~22.04) over (34~22.04) ...
Preparing to unpack .../22-xxd_2%3a8.2.3995-1ubuntu2.24_amd64.deb ...
Unpacking xxd (2:8.2.3995-1ubuntu2.24) over (2:8.2.3995-1ubuntu2.21) ...
Preparing to unpack .../23-vim_2%3a8.2.3995-1ubuntu2.24_amd64.deb ...
Unpacking vim (2:8.2.3995-1ubuntu2.24) over (2:8.2.3995-1ubuntu2.21) ...
Preparing to unpack .../24-vim-tiny_2%3a8.2.3995-1ubuntu2.24_amd64.deb ...
Unpacking vim-tiny (2:8.2.3995-1ubuntu2.24) over (2:8.2.3995-1ubuntu2.21) ...
Preparing to unpack .../25-vim-runtime_2%3a8.2.3995-1ubuntu2.24_all.deb ...
Unpacking vim-runtime (2:8.2.3995-1ubuntu2.24) over (2:8.2.3995-1ubuntu2.21) ...
Preparing to unpack .../26-vim-common_2%3a8.2.3995-1ubuntu2.24_all.deb ...
Unpacking vim-common (2:8.2.3995-1ubuntu2.24) over (2:8.2.3995-1ubuntu2.21) ...
Preparing to unpack .../27-libsodium23_1.0.18-1ubuntu0.22.04.1_amd64.deb ...
Unpacking libsodium23:amd64 (1.0.18-1ubuntu0.22.04.1) over (1.0.18-1build2) ...
Preparing to unpack .../28-ubuntu-minimal_1.481.5_amd64.deb ...
Unpacking ubuntu-minimal (1.481.5) over (1.481.4) ...
Preparing to unpack .../29-apparmor_3.0.4-2ubuntu2.5_amd64.deb ...
Unpacking apparmor (3.0.4-2ubuntu2.5) over (3.0.4-2ubuntu2.4) ...
Preparing to unpack .../30-bind9-dnsutils_1%3a9.18.39-0ubuntu0.22.04.2_amd64.deb ...
Unpacking bind9-dnsutils (1:9.18.39-0ubuntu0.22.04.2) over (1:9.18.28-0ubuntu0.22.04.1) ...
Preparing to unpack .../31-bind9-host_1%3a9.18.39-0ubuntu0.22.04.2_amd64.deb ...
Unpacking bind9-host (1:9.18.39-0ubuntu0.22.04.2) over (1:9.18.28-0ubuntu0.22.04.1) ...
Preparing to unpack .../32-bind9-libs_1%3a9.18.39-0ubuntu0.22.04.2_amd64.deb ...
Unpacking bind9-libs:amd64 (1:9.18.39-0ubuntu0.22.04.2) over (1:9.18.28-0ubuntu0.22.04.1) ...
Preparing to unpack .../33-iputils-tracepath_3%3a20211215-1ubuntu0.1_amd64.deb ...
Unpacking iputils-tracepath (3:20211215-1ubuntu0.1) over (3:20211215-1) ...
Preparing to unpack .../34-libpng16-16_1.6.37-3ubuntu0.3_amd64.deb ...
Unpacking libpng16-16:amd64 (1.6.37-3ubuntu0.3) over (1.6.37-3build5) ...
Preparing to unpack .../35-libssh-4_0.9.6-2ubuntu0.22.04.5_amd64.deb ...
Unpacking libssh-4:amd64 (0.9.6-2ubuntu0.22.04.5) over (0.9.6-2ubuntu0.22.04.3) ...
Preparing to unpack .../36-libcurl3-gnutls_7.81.0-1ubuntu1.21_amd64.deb ...
Unpacking libcurl3-gnutls:amd64 (7.81.0-1ubuntu1.21) over (7.81.0-1ubuntu1.20) ...
Preparing to unpack .../37-git-man_1%3a2.34.1-1ubuntu1.15_all.deb ...
Unpacking git-man (1:2.34.1-1ubuntu1.15) over (1:2.34.1-1ubuntu1.11) ...
Preparing to unpack .../38-git_1%3a2.34.1-1ubuntu1.15_amd64.deb ...
Unpacking git (1:2.34.1-1ubuntu1.15) over (1:2.34.1-1ubuntu1.11) ...
Preparing to unpack .../39-openssh-client_1%3a8.9p1-3ubuntu0.13_amd64.deb ...
Unpacking openssh-client (1:8.9p1-3ubuntu0.13) over (1:8.9p1-3ubuntu0.10) ...
Preparing to unpack .../40-pci.ids_0.0~2022.01.22-1ubuntu0.1_all.deb ...
Unpacking pci.ids (0.0~2022.01.22-1ubuntu0.1) over (0.0~2022.01.22-1) ...
Preparing to unpack .../41-powermgmt-base_1.36ubuntu0.22.04.1_all.deb ...
Unpacking powermgmt-base (1.36ubuntu0.22.04.1) over (1.36) ...
Preparing to unpack .../42-python3-update-manager_1%3a22.04.22_all.deb ...
Unpacking python3-update-manager (1:22.04.22) over (1:22.04.21) ...
Preparing to unpack .../43-update-manager-core_1%3a22.04.22_all.deb ...
Unpacking update-manager-core (1:22.04.22) over (1:22.04.21) ...
Preparing to unpack .../44-ubuntu-standard_1.481.5_amd64.deb ...
Unpacking ubuntu-standard (1.481.5) over (1.481.4) ...
Preparing to unpack .../45-python3-problem-report_2.20.11-0ubuntu82.10_all.deb ...
Unpacking python3-problem-report (2.20.11-0ubuntu82.10) over (2.20.11-0ubuntu82.6) ...
Preparing to unpack .../46-python3-apport_2.20.11-0ubuntu82.10_all.deb ...
Unpacking python3-apport (2.20.11-0ubuntu82.10) over (2.20.11-0ubuntu82.6) ...
Preparing to unpack .../47-apport_2.20.11-0ubuntu82.10_all.deb ...
Unpacking apport (2.20.11-0ubuntu82.10) over (2.20.11-0ubuntu82.6) ...
Preparing to unpack .../48-libctf0_2.38-4ubuntu2.12_amd64.deb ...
Unpacking libctf0:amd64 (2.38-4ubuntu2.12) over (2.38-4ubuntu2.6) ...
Preparing to unpack .../49-libctf-nobfd0_2.38-4ubuntu2.12_amd64.deb ...
Unpacking libctf-nobfd0:amd64 (2.38-4ubuntu2.12) over (2.38-4ubuntu2.6) ...
Preparing to unpack .../50-binutils-x86-64-linux-gnu_2.38-4ubuntu2.12_amd64.deb ...
Unpacking binutils-x86-64-linux-gnu (2.38-4ubuntu2.12) over (2.38-4ubuntu2.6) ...
Preparing to unpack .../51-libbinutils_2.38-4ubuntu2.12_amd64.deb ...
Unpacking libbinutils:amd64 (2.38-4ubuntu2.12) over (2.38-4ubuntu2.6) ...
Preparing to unpack .../52-binutils_2.38-4ubuntu2.12_amd64.deb ...
Unpacking binutils (2.38-4ubuntu2.12) over (2.38-4ubuntu2.6) ...
Preparing to unpack .../53-binutils-common_2.38-4ubuntu2.12_amd64.deb ...
Unpacking binutils-common:amd64 (2.38-4ubuntu2.12) over (2.38-4ubuntu2.6) ...
Preparing to unpack .../54-curl_7.81.0-1ubuntu1.21_amd64.deb ...
Unpacking curl (7.81.0-1ubuntu1.21) over (7.81.0-1ubuntu1.20) ...
Preparing to unpack .../55-libcurl4_7.81.0-1ubuntu1.21_amd64.deb ...
Unpacking libcurl4:amd64 (7.81.0-1ubuntu1.21) over (7.81.0-1ubuntu1.20) ...
Preparing to unpack .../56-dconf-service_0.40.0-3ubuntu0.1_amd64.deb ...
Unpacking dconf-service (0.40.0-3ubuntu0.1) over (0.40.0-3) ...
Preparing to unpack .../57-dconf-gsettings-backend_0.40.0-3ubuntu0.1_amd64.deb ...
Unpacking dconf-gsettings-backend:amd64 (0.40.0-3ubuntu0.1) over (0.40.0-3) ...
Preparing to unpack .../58-libdconf1_0.40.0-3ubuntu0.1_amd64.deb ...
Unpacking libdconf1:amd64 (0.40.0-3ubuntu0.1) over (0.40.0-3) ...
Preparing to unpack .../59-landscape-client_23.02-0ubuntu1~22.04.7_amd64.deb ...
Unpacking landscape-client (23.02-0ubuntu1~22.04.7) over (23.02-0ubuntu1~22.04.3) ...
Preparing to unpack .../60-landscape-common_23.02-0ubuntu1~22.04.7_amd64.deb ...
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.6.87.2-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

Unpacking landscape-common (23.02-0ubuntu1~22.04.7) over (23.02-0ubuntu1~22.04.3) ...
Preparing to unpack .../61-libavahi-client3_0.8-5ubuntu5.4_amd64.deb ...
Unpacking libavahi-client3:amd64 (0.8-5ubuntu5.4) over (0.8-5ubuntu5.2) ...
Preparing to unpack .../62-libavahi-common3_0.8-5ubuntu5.4_amd64.deb ...
Unpacking libavahi-common3:amd64 (0.8-5ubuntu5.4) over (0.8-5ubuntu5.2) ...
Preparing to unpack .../63-libavahi-common-data_0.8-5ubuntu5.4_amd64.deb ...
Unpacking libavahi-common-data:amd64 (0.8-5ubuntu5.4) over (0.8-5ubuntu5.2) ...
Preparing to unpack .../64-libcups2_2.4.1op1-1ubuntu4.16_amd64.deb ...
Unpacking libcups2:amd64 (2.4.1op1-1ubuntu4.16) over (2.4.1op1-1ubuntu4.11) ...
Preparing to unpack .../65-libfreetype6_2.11.1+dfsg-1ubuntu0.3_amd64.deb ...
Unpacking libfreetype6:amd64 (2.11.1+dfsg-1ubuntu0.3) over (2.11.1+dfsg-1ubuntu0.2) ...
Preparing to unpack .../66-libgdk-pixbuf2.0-common_2.42.8+dfsg-1ubuntu0.4_all.deb ...
Unpacking libgdk-pixbuf2.0-common (2.42.8+dfsg-1ubuntu0.4) over (2.42.8+dfsg-1ubuntu0.3) ...
Preparing to unpack .../67-libtiff5_4.3.0-6ubuntu0.12_amd64.deb ...
Unpacking libtiff5:amd64 (4.3.0-6ubuntu0.12) over (4.3.0-6ubuntu0.10) ...
Preparing to unpack .../68-libgdk-pixbuf-2.0-0_2.42.8+dfsg-1ubuntu0.4_amd64.deb ...
Unpacking libgdk-pixbuf-2.0-0:amd64 (2.42.8+dfsg-1ubuntu0.4) over (2.42.8+dfsg-1ubuntu0.3) ...
Preparing to unpack .../69-libgdk-pixbuf2.0-bin_2.42.8+dfsg-1ubuntu0.4_amd64.deb ...
Unpacking libgdk-pixbuf2.0-bin (2.42.8+dfsg-1ubuntu0.4) over (2.42.8+dfsg-1ubuntu0.3) ...
Preparing to unpack .../70-libharfbuzz0b_2.7.4-1ubuntu3.2_amd64.deb ...
Unpacking libharfbuzz0b:amd64 (2.7.4-1ubuntu3.2) over (2.7.4-1ubuntu3.1) ...
Preparing to unpack .../71-libldap-common_2.5.20+dfsg-0ubuntu0.22.04.1_all.deb ...
Unpacking libldap-common (2.5.20+dfsg-0ubuntu0.22.04.1) over (2.5.18+dfsg-0ubuntu0.22.04.2) ...
Preparing to unpack .../72-python3-attr_21.2.0-1ubuntu1_all.deb ...
Unpacking python3-attr (21.2.0-1ubuntu1) over (21.2.0-1) ...
Preparing to unpack .../73-python3-jinja2_3.0.3-1ubuntu0.4_all.deb ...
Unpacking python3-jinja2 (3.0.3-1ubuntu0.4) over (3.0.3-1ubuntu0.2) ...
Preparing to unpack .../74-python3-pyasn1_0.4.8-1ubuntu0.1_all.deb ...
Unpacking python3-pyasn1 (0.4.8-1ubuntu0.1) over (0.4.8-1) ...
Preparing to unpack .../75-python3-urllib3_1.26.5-1~exp1ubuntu0.6_all.deb ...
Unpacking python3-urllib3 (1.26.5-1~exp1ubuntu0.6) over (1.26.5-1~exp1ubuntu0.2) ...
Preparing to unpack .../76-python3-requests_2.25.1+dfsg-2ubuntu0.3_all.deb ...
Unpacking python3-requests (2.25.1+dfsg-2ubuntu0.3) over (2.25.1+dfsg-2ubuntu0.1) ...
Preparing to unpack .../77-screen_4.9.0-1ubuntu0.1_amd64.deb ...
Unpacking screen (4.9.0-1ubuntu0.1) over (4.9.0-1) ...
Preparing to unpack .../78-snapd_2.73+ubuntu22.04_amd64.deb ...
Unpacking snapd (2.73+ubuntu22.04) over (2.66.1+22.04) ...
Preparing to unpack .../79-systemd-hwe-hwdb_249.11.6_all.deb ...
Unpacking systemd-hwe-hwdb (249.11.6) over (249.11.5) ...
Preparing to unpack .../80-cloud-init_25.2-0ubuntu1~22.04.1_all.deb ...
Unpacking cloud-init (25.2-0ubuntu1~22.04.1) over (24.4-0ubuntu1~22.04.1) ...
Preparing to unpack .../81-wsl-setup_0.5.8~22.04.1_amd64.deb ...
Unpacking wsl-setup (0.5.8~22.04.1) over (0.5.4~22.04) ...
Preparing to unpack .../82-ubuntu-wsl_1.481.5_amd64.deb ...
Unpacking ubuntu-wsl (1.481.5) over (1.481.4) ...
Selecting previously unselected package wsl-pro-service.
Preparing to unpack .../83-wsl-pro-service_0.1.18~22.04.2_amd64.deb ...
Unpacking wsl-pro-service (0.1.18~22.04.2) ...
Setting up python3-pkg-resources (59.6.0-1.2ubuntu0.22.04.3) ...
Setting up libexpat1:amd64 (2.4.7-1ubuntu0.6) ...
Setting up powermgmt-base (1.36ubuntu0.22.04.1) ...
Setting up python3-attr (21.2.0-1ubuntu1) ...
Setting up libapparmor1:amd64 (3.0.4-2ubuntu2.5) ...
Setting up pci.ids (0.0~2022.01.22-1ubuntu0.1) ...
Setting up libsodium23:amd64 (1.0.18-1ubuntu0.22.04.1) ...
Setting up apt-utils (2.4.14) ...
Setting up python3-setuptools (59.6.0-1.2ubuntu0.22.04.3) ...
Setting up python3-problem-report (2.20.11-0ubuntu82.10) ...
Setting up libglib2.0-0:amd64 (2.72.4-0ubuntu2.9) ...
Setting up distro-info-data (0.52ubuntu0.11) ...
Setting up openssh-client (1:8.9p1-3ubuntu0.13) ...
Setting up libsqlite3-0:amd64 (3.37.2-2ubuntu0.5) ...
Setting up libgdk-pixbuf2.0-common (2.42.8+dfsg-1ubuntu0.4) ...
Setting up binutils-common:amd64 (2.38-4ubuntu2.12) ...
Setting up libctf-nobfd0:amd64 (2.38-4ubuntu2.12) ...
Setting up screen (4.9.0-1ubuntu0.1) ...
Setting up perl-modules-5.34 (5.34.0-3ubuntu1.5) ...
Setting up locales (2.35-0ubuntu3.13) ...
Generating locales (this might take a while)...
Generation complete.
Setting up libldap-common (2.5.20+dfsg-0ubuntu0.22.04.1) ...
Setting up libldap-2.5-0:amd64 (2.5.20+dfsg-0ubuntu0.22.04.1) ...
Setting up xxd (2:8.2.3995-1ubuntu2.24) ...
Setting up tzdata (2025b-0ubuntu0.22.04.1) ...

Current default time zone: 'Africa/Kampala'
Local time is now:      Fri Feb  6 11:12:38 EAT 2026.
Universal Time is now:  Fri Feb  6 08:12:38 UTC 2026.
Run 'dpkg-reconfigure tzdata' if you wish to change it.

Setting up libcap2-bin (1:2.44-1ubuntu0.22.04.2) ...
Setting up libdconf1:amd64 (0.40.0-3ubuntu0.1) ...
Setting up apparmor (3.0.4-2ubuntu2.5) ...
Installing new version of config file /etc/apparmor.d/abstractions/dri-enumerate ...
Installing new version of config file /etc/apparmor.d/abstractions/opencl-intel ...
Installing new version of config file /etc/apparmor.d/abstractions/opencl-nvidia ...
Installing new version of config file /etc/apparmor.d/abstractions/opencl-pocl ...
Installing new version of config file /etc/apparmor.d/abstractions/vulkan ...
Installing new version of config file /etc/apparmor.d/nvidia_modprobe ...
Installing new version of config file /etc/apparmor.d/tunables/global ...
Setting up python3-jinja2 (3.0.3-1ubuntu0.4) ...
Setting up libglib2.0-data (2.72.4-0ubuntu2.9) ...
Setting up vim-common (2:8.2.3995-1ubuntu2.24) ...
Setting up gnupg-l10n (2.2.27-3ubuntu2.5) ...
Setting up libavahi-common-data:amd64 (0.8-5ubuntu5.4) ...
Setting up libpng16-16:amd64 (1.6.37-3ubuntu0.3) ...
Setting up udev (249.11-0ubuntu3.17) ...
Setting up libpython3.10-minimal:amd64 (3.10.12-1~22.04.14) ...
Setting up sudo (1.9.9-1ubuntu2.5) ...
Setting up libssh-4:amd64 (0.9.6-2ubuntu0.22.04.5) ...
Setting up python3-urllib3 (1.26.5-1~exp1ubuntu0.6) ...
Setting up systemd-hwe-hwdb (249.11.6) ...
Setting up libdevmapper1.02.1:amd64 (2:1.02.175-2.1ubuntu5) ...
Setting up python-apt-common (2.4.0ubuntu4.1) ...
Setting up dmsetup (2:1.02.175-2.1ubuntu5) ...
Setting up gpgconf (2.2.27-3ubuntu2.5) ...
Setting up python3-pyasn1 (0.4.8-1ubuntu0.1) ...
Setting up libcurl4:amd64 (7.81.0-1ubuntu1.21) ...
Setting up git-man (1:2.34.1-1ubuntu1.15) ...
Setting up libcryptsetup12:amd64 (2:2.4.3-1ubuntu1.3) ...
Setting up libtiff5:amd64 (4.3.0-6ubuntu0.12) ...
Setting up curl (7.81.0-1ubuntu1.21) ...
Setting up libbinutils:amd64 (2.38-4ubuntu2.12) ...
Setting up vim-runtime (2:8.2.3995-1ubuntu2.24) ...
Setting up openssl (3.0.2-0ubuntu1.21) ...
Setting up libelf1:amd64 (0.186-1ubuntu0.1) ...
Setting up libpam-cap:amd64 (1:2.44-1ubuntu0.22.04.2) ...
Setting up iputils-ping (3:20211215-1ubuntu0.1) ...
Setting up libxml2:amd64 (2.9.13+dfsg-1ubuntu0.11) ...
Setting up gpg (2.2.27-3ubuntu2.5) ...
Setting up iputils-tracepath (3:20211215-1ubuntu0.1) ...
Setting up rsync (3.2.7-0ubuntu0.22.04.4) ...
rsync.service is a disabled or a static unit not running, not starting it.
Setting up gnupg-utils (2.2.27-3ubuntu2.5) ...
Setting up libctf0:amd64 (2.38-4ubuntu2.12) ...
Setting up libdw1:amd64 (0.186-1ubuntu0.1) ...
Setting up libperl5.34:amd64 (5.34.0-3ubuntu1.5) ...
Setting up gpg-agent (2.2.27-3ubuntu2.5) ...
Setting up bind9-libs:amd64 (1:9.18.39-0ubuntu0.22.04.2) ...
Setting up python3-apt (2.4.0ubuntu4.1) ...
Setting up gpgsm (2.2.27-3ubuntu2.5) ...
Setting up libavahi-common3:amd64 (0.8-5ubuntu5.4) ...
Setting up libglib2.0-bin (2.72.4-0ubuntu2.9) ...
Setting up libcurl3-gnutls:amd64 (7.81.0-1ubuntu1.21) ...
Setting up dconf-service (0.40.0-3ubuntu0.1) ...
Setting up systemd (249.11-0ubuntu3.17) ...
Setting up vim-tiny (2:8.2.3995-1ubuntu2.24) ...
Setting up landscape-common (23.02-0ubuntu1~22.04.7) ...
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.6.87.2-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Feb  6 11:12:51 EAT 2026

  System load:  1.27                Processes:             35
  Usage of /:   0.2% of 1006.85GB   Users logged in:       1
  Memory usage: 7%                  IPv4 address for eth0: 172.28.158.63
  Swap usage:   0%

Setting up python3.10-minimal (3.10.12-1~22.04.14) ...
Setting up python3-apport (2.20.11-0ubuntu82.10) ...
Setting up libpython3.10-stdlib:amd64 (3.10.12-1~22.04.14) ...
Setting up dirmngr (2.2.27-3ubuntu2.5) ...
Setting up perl (5.34.0-3ubuntu1.5) ...
Setting up libfreetype6:amd64 (2.11.1+dfsg-1ubuntu0.3) ...
Setting up python3-requests (2.25.1+dfsg-2ubuntu0.3) ...
Setting up landscape-client (23.02-0ubuntu1~22.04.7) ...
Setting up systemd-timesyncd (249.11-0ubuntu3.17) ...
Setting up git (1:2.34.1-1ubuntu1.15) ...
Setting up gpg-wks-server (2.2.27-3ubuntu2.5) ...
Setting up python3-update-manager (1:22.04.22) ...
Setting up libharfbuzz0b:amd64 (2.7.4-1ubuntu3.2) ...
Setting up libgdk-pixbuf-2.0-0:amd64 (2.42.8+dfsg-1ubuntu0.4) ...
Setting up bind9-host (1:9.18.39-0ubuntu0.22.04.2) ...
Setting up ubuntu-pro-client (37.1ubuntu0~22.04) ...
Installing new version of config file /etc/apparmor.d/ubuntu_pro_apt_news ...
Installing new version of config file /etc/apparmor.d/ubuntu_pro_esm_cache ...
Installing new version of config file /etc/apt/apt.conf.d/20apt-esm-hook.conf ...
Setting up libavahi-client3:amd64 (0.8-5ubuntu5.4) ...
Setting up binutils-x86-64-linux-gnu (2.38-4ubuntu2.12) ...
Setting up ubuntu-pro-client-l10n (37.1ubuntu0~22.04) ...
Setting up wsl-pro-service (0.1.18~22.04.2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/wsl-pro.service → /lib/systemd/system/wsl-pro.service.
Setting up snapd (2.73+ubuntu22.04) ...
Installing new version of config file /etc/apparmor.d/usr.lib.snapd.snap-confine.real ...
Installing new version of config file /etc/profile.d/apps-bin-path.sh ...
snapd.failure.service is a disabled or a static unit not running, not starting it.
snapd.gpio-chardev-setup.target is a disabled or a static unit not running, not starting it.
snapd.snap-repair.service is a disabled or a static unit not running, not starting it.
Setting up libpython3.10:amd64 (3.10.12-1~22.04.14) ...
Setting up systemd-sysv (249.11-0ubuntu3.17) ...
Setting up cloud-init (25.2-0ubuntu1~22.04.1) ...
Installing new version of config file /etc/cloud/templates/sources.list.debian.deb822.tmpl ...
Installing new version of config file /etc/cloud/templates/sources.list.ubuntu.deb822.tmpl ...
Setting up vim (2:8.2.3995-1ubuntu2.24) ...
Setting up python3.10 (3.10.12-1~22.04.14) ...
Setting up gpg-wks-client (2.2.27-3ubuntu2.5) ...
Setting up dconf-gsettings-backend:amd64 (0.40.0-3ubuntu0.1) ...
Setting up libnss-systemd:amd64 (249.11-0ubuntu3.17) ...
Setting up binutils (2.38-4ubuntu2.12) ...
Setting up apport (2.20.11-0ubuntu82.10) ...
Installing new version of config file /etc/init.d/apport ...
apport-autoreport.service is a disabled or a static unit, not starting it.
Setting up libcups2:amd64 (2.4.1op1-1ubuntu4.16) ...
Setting up libgdk-pixbuf2.0-bin (2.42.8+dfsg-1ubuntu0.4) ...
Setting up gnupg (2.2.27-3ubuntu2.5) ...
Setting up libpam-systemd:amd64 (249.11-0ubuntu3.17) ...
Setting up ubuntu-advantage-tools (37.1ubuntu0~22.04) ...
Setting up bind9-dnsutils (1:9.18.39-0ubuntu0.22.04.2) ...
Setting up wsl-setup (0.5.8~22.04.1) ...
Installing new version of config file /etc/update-motd.d/99-wsl ...
Setting up ubuntu-minimal (1.481.5) ...
Setting up ubuntu-wsl (1.481.5) ...
Setting up ubuntu-standard (1.481.5) ...
Setting up update-manager-core (1:22.04.22) ...
Processing triggers for hicolor-icon-theme (0.17-2) ...
Processing triggers for libc-bin (2.35-0ubuntu3.13) ...
Processing triggers for rsyslog (8.2112.0-2ubuntu2.2) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for dbus (1.12.20-2ubuntu4.1) ...
Processing triggers for install-info (6.8-4build1) ...
root@gabes:~# curl https://pyenv.run | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--    100   270  100   270    0     0    251      0  0:00:01  0:00:01 --:--:--   2100   270  100   270    0     0    250      0  0:00:01  0:00:01 --:--:--   251

WARNING: Can not proceed with installation. Kindly remove the '/root/.pyenv' directory first.

root@gabes:~# rm /root/.pyenv
rm: cannot remove '/root/.pyenv': Is a directory
root@gabes:~# rm -rf /root/.pyenv
-bash: /root/.pyenv/bin/pyenv: No such file or directory
root@gabes:~# rm -rf .pyev
-bash: /root/.pyenv/bin/pyenv: No such file or directory
root@gabes:~# rm -rf .pyenv
-bash: /root/.pyenv/bin/pyenv: No such file or directory
root@gabes:~# curl https://pyenv.run | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--    100   270  100   270    0     0    498      0 --:--:-- --:--:-- --:--:--   498
Cloning into '/root/.pyenv'...
remote: Enumerating objects: 1514, done.
remote: Counting objects: 100% (1514/1514), done.
remote: Compressing objects: 100% (741/741), done.
remote: Total 1514 (delta 919), reused 967 (delta 605), pack-reused 0 (from 0)
Receiving objects: 100% (1514/1514), 1.19 MiB | 1.06 MiB/s, done.
Resolving deltas: 100% (919/919), done.
Cloning into '/root/.pyenv/plugins/pyenv-doctor'...
remote: Enumerating objects: 11, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 11 (delta 1), reused 5 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (11/11), 38.72 KiB | 461.00 KiB/s, done.
Resolving deltas: 100% (1/1), done.
Cloning into '/root/.pyenv/plugins/pyenv-update'...
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 10 (delta 1), reused 6 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (10/10), done.
Resolving deltas: 100% (1/1), done.
Cloning into '/root/.pyenv/plugins/pyenv-virtualenv'...
remote: Enumerating objects: 66, done.
remote: Counting objects: 100% (66/66), done.
remote: Compressing objects: 100% (59/59), done.
remote: Total 66 (delta 10), reused 25 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (66/66), 46.00 KiB | 223.00 KiB/s, done.
Resolving deltas: 100% (10/10), done.
root@gabes:~# export PATH="$HOME/.pyenv/bin:$PATH"
root@gabes:~# eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
root@gabes:~# pyenv install 3.11.12
pyenv virtualenv 3.11.12 myenv
pyenv activate myenv
Downloading Python-3.11.12.tar.xz...
-> https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
Installing Python-3.11.12...
patching file setup.py

BUILD FAILED (Ubuntu 22.04 using python-build 2.6.22)

Inspect or clean up the working tree at /tmp/python-build.20260206112218.9328
Results logged to /tmp/python-build.20260206112218.9328.log

Last 10 log lines:
checking for pkg-config... no
checking for --enable-universalsdk... no
checking for --with-universal-archs... no
checking MACHDEP... "linux"
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/python-build.20260206112218.9328/Python-3.11.12':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
pyenv-virtualenv: `3.11.12' is not installed in pyenv.
Run `pyenv install 3.11.12' to install it.

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
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  python3-pip-whl python3-setuptools-whl
The following NEW packages will be installed:
  python3-pip-whl python3-setuptools-whl python3.10-venv
0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
Need to get 2478 kB of archives.
After this operation, 2891 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 python3-pip-whl all 22.0.2+dfsg-1ubuntu0.7 [1683 kB]
Get:2 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 python3-setuptools-whl all 59.6.0-1.2ubuntu0.22.04.3 [789 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 python3.10-venv amd64 3.10.12-1~22.04.14 [5724 B]
Fetched 2478 kB in 3s (757 kB/s)
Selecting previously unselected package python3-pip-whl.
(Reading database ... 42682 files and directories currently installed.)
Preparing to unpack .../python3-pip-whl_22.0.2+dfsg-1ubuntu0.7_all.deb ...
Unpacking python3-pip-whl (22.0.2+dfsg-1ubuntu0.7) ...
Selecting previously unselected package python3-setuptools-whl.
Preparing to unpack .../python3-setuptools-whl_59.6.0-1.2ubuntu0.22.04.3_all.deb ...
Unpacking python3-setuptools-whl (59.6.0-1.2ubuntu0.22.04.3) ...
Selecting previously unselected package python3.10-venv.
Preparing to unpack .../python3.10-venv_3.10.12-1~22.04.14_amd64.deb ...
Unpacking python3.10-venv (3.10.12-1~22.04.14) ...
Setting up python3-setuptools-whl (59.6.0-1.2ubuntu0.22.04.3) ...
Setting up python3-pip-whl (22.0.2+dfsg-1ubuntu0.7) ...
Setting up python3.10-venv (3.10.12-1~22.04.14) ...
root@gabes:~# pyenv install 3.11.12
pyenv virtualenv 3.11.12 myenv
pyenv activate myenv
Downloading Python-3.11.12.tar.xz...
-> https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
Installing Python-3.11.12...
patching file setup.py

BUILD FAILED (Ubuntu 22.04 using python-build 2.6.22)

Inspect or clean up the working tree at /tmp/python-build.20260206113448.10087
Results logged to /tmp/python-build.20260206113448.10087.log

Last 10 log lines:
checking for pkg-config... no
checking for --enable-universalsdk... no
checking for --with-universal-archs... no
checking MACHDEP... "linux"
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/python-build.20260206113448.10087/Python-3.11.12':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
pyenv-virtualenv: `3.11.12' is not installed in pyenv.
Run `pyenv install 3.11.12' to install it.

`pyenv activate' requires Pyenv and Pyenv-Virtualenv to be loaded into your shell.
Check your shell configuration and Pyenv and Pyenv-Virtualenv installation instructions.

root@gabes:~# pip install pandas matplotlib seaborn plotly jupyter
Command 'pip' not found, but can be installed with:
apt install python3-pip
root@gabes:~# export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
root@gabes:~# source ~/.bashrc
root@gabes:~# pyenv virtualenvs
root@gabes:~# pyenv install 3.11.12
pyenv virtualenv 3.11.12 myenv
pyenv activate myenv
Downloading Python-3.11.12.tar.xz...
-> https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
Installing Python-3.11.12...
patching file setup.py

BUILD FAILED (Ubuntu 22.04 using python-build 2.6.22)

Inspect or clean up the working tree at /tmp/python-build.20260206113956.10962
Results logged to /tmp/python-build.20260206113956.10962.log

Last 10 log lines:
checking for pkg-config... no
checking for --enable-universalsdk... no
checking for --with-universal-archs... no
checking MACHDEP... "linux"
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/python-build.20260206113956.10962/Python-3.11.12':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
pyenv-virtualenv: `3.11.12' is not installed in pyenv.
Run `pyenv install 3.11.12' to install it.
pyenv-virtualenv: version `myenv' is not a virtualenv
root@gabes:~# apt update && apt install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
Hit:1 http://archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Fetched 384 kB in 2s (168 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
All packages are up to date.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
xz-utils is already the newest version (5.2.5-2ubuntu1).
xz-utils set to manually installed.
curl is already the newest version (7.81.0-1ubuntu1.21).
curl set to manually installed.
The following additional packages will be installed:
  bzip2 bzip2-doc cpp cpp-11 dpkg-dev fakeroot g++ g++-11 gcc gcc-11
  gcc-11-base icu-devtools libalgorithm-diff-perl
  libalgorithm-diff-xs-perl libalgorithm-merge-perl libasan6 libatomic1
  libbrotli-dev libc-dev-bin libc-devtools libc6-dev libcc1-0 libcrypt-dev
  libdpkg-perl libevent-2.1-7 libexpat1-dev libfakeroot
  libfile-fcntllock-perl libfontconfig-dev libfontconfig1-dev libfontenc1
  libfreetype-dev libfreetype6-dev libgcc-11-dev libgcrypt20-dev libgd3
  libgmp-dev libgmpxx4ldbl libgnutls-dane0 libgnutls-openssl27
  libgnutls28-dev libgnutlsxx28 libgomp1 libgpg-error-dev libice6
  libicu-dev libidn2-dev libisl23 libitm1 liblsan0 libmpc3 libncurses-dev
  libnsl-dev libnspr4 libnspr4-dev libnss3 libnss3-dev libp11-kit-dev
  libpng-dev libpng-tools libpthread-stubs0-dev libquadmath0 libsm6
  libstdc++-11-dev libtasn1-6-dev libtasn1-doc libtcl8.6 libtirpc-dev
  libtk8.6 libtsan0 libubsan1 libunbound8 libx11-dev libxau-dev libxaw7
  libxcb-shape0 libxcb1-dev libxdmcp-dev libxext-dev libxft-dev libxft2
  libxkbfile1 libxmlsec1 libxmlsec1-gcrypt libxmlsec1-gnutls
  libxmlsec1-nss libxmlsec1-openssl libxmu6 libxpm4 libxrender-dev
  libxslt1-dev libxss-dev libxss1 libxt6 libxv1 libxxf86dga1
  linux-libc-dev lto-disabled-list make manpages-dev nettle-dev pkg-config
  rpcsvc-proto tcl tcl-dev tcl8.6 tcl8.6-dev tk tk8.6 tk8.6-dev uuid-dev
  x11-utils x11proto-core-dev x11proto-dev xbitmaps xorg-sgml-doctools
  xterm xtrans-dev
Suggested packages:
  cpp-doc gcc-11-locales debian-keyring g++-multilib g++-11-multilib
  gcc-11-doc gcc-multilib autoconf automake libtool flex bison gdb gcc-doc
  gcc-11-multilib glibc-doc bzr freetype2-doc libgcrypt20-doc libgd-tools
  gmp-doc libgmp10-doc libmpfr-dev dns-root-data gnutls-bin gnutls-doc
  icu-doc liblzma-doc ncurses-doc p11-kit-doc readline-doc sqlite3-doc
  libssl-doc libstdc++-11-doc libx11-doc libxcb-doc libxext-doc make-doc
  tcl-doc tcl-tclreadline tcl8.6-doc tk-doc tk8.6-doc mesa-utils
  xfonts-cyrillic
The following NEW packages will be installed:
  build-essential bzip2 bzip2-doc cpp cpp-11 dpkg-dev fakeroot g++ g++-11
  gcc gcc-11 gcc-11-base icu-devtools libalgorithm-diff-perl
  libalgorithm-diff-xs-perl libalgorithm-merge-perl libasan6 libatomic1
  libbrotli-dev libbz2-dev libc-dev-bin libc-devtools libc6-dev libcc1-0
  libcrypt-dev libdpkg-perl libevent-2.1-7 libexpat1-dev libfakeroot
  libffi-dev libfile-fcntllock-perl libfontconfig-dev libfontconfig1-dev
  libfontenc1 libfreetype-dev libfreetype6-dev libgcc-11-dev
  libgcrypt20-dev libgd3 libgmp-dev libgmpxx4ldbl libgnutls-dane0
  libgnutls-openssl27 libgnutls28-dev libgnutlsxx28 libgomp1
  libgpg-error-dev libice6 libicu-dev libidn2-dev libisl23 libitm1
  liblsan0 liblzma-dev libmpc3 libncurses-dev libncursesw5-dev libnsl-dev
  libnspr4 libnspr4-dev libnss3 libnss3-dev libp11-kit-dev libpng-dev
  libpng-tools libpthread-stubs0-dev libquadmath0 libreadline-dev libsm6
  libsqlite3-dev libssl-dev libstdc++-11-dev libtasn1-6-dev libtasn1-doc
  libtcl8.6 libtirpc-dev libtk8.6 libtsan0 libubsan1 libunbound8
  libx11-dev libxau-dev libxaw7 libxcb-shape0 libxcb1-dev libxdmcp-dev
  libxext-dev libxft-dev libxft2 libxkbfile1 libxml2-dev libxmlsec1
  libxmlsec1-dev libxmlsec1-gcrypt libxmlsec1-gnutls libxmlsec1-nss
  libxmlsec1-openssl libxmu6 libxpm4 libxrender-dev libxslt1-dev
  libxss-dev libxss1 libxt6 libxv1 libxxf86dga1 linux-libc-dev
  lto-disabled-list make manpages-dev nettle-dev pkg-config rpcsvc-proto
  tcl tcl-dev tcl8.6 tcl8.6-dev tk tk-dev tk8.6 tk8.6-dev uuid-dev
  x11-utils x11proto-core-dev x11proto-dev xbitmaps xorg-sgml-doctools
  xterm xtrans-dev zlib1g-dev
0 upgraded, 130 newly installed, 0 to remove and 0 not upgraded.
Need to get 95.1 MB of archives.
After this operation, 335 MB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libc-dev-bin amd64 2.35-0ubuntu3.13 [20.3 kB]
Get:2 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 linux-libc-dev amd64 5.15.0-168.178 [1310 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy/main amd64 libcrypt-dev amd64 1:4.4.27-1 [112 kB]
Get:4 http://archive.ubuntu.com/ubuntu jammy/main amd64 rpcsvc-proto amd64 1.4.2-0ubuntu6 [68.5 kB]
Get:5 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libtirpc-dev amd64 1.3.2-2ubuntu0.1 [192 kB]
Get:6 http://archive.ubuntu.com/ubuntu jammy/main amd64 libnsl-dev amd64 1.3.0-2build2 [71.3 kB]
Get:7 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libc6-dev amd64 2.35-0ubuntu3.13 [2101 kB]
Get:8 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 gcc-11-base amd64 11.4.0-1ubuntu1~22.04.2 [20.8 kB]
Get:9 http://archive.ubuntu.com/ubuntu jammy/main amd64 libisl23 amd64 0.24-2build1 [727 kB]
Get:10 http://archive.ubuntu.com/ubuntu jammy/main amd64 libmpc3 amd64 1.2.1-2build1 [46.9 kB]
Get:11 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 cpp-11 amd64 11.4.0-1ubuntu1~22.04.2 [10.0 MB]
Get:12 http://archive.ubuntu.com/ubuntu jammy/main amd64 cpp amd64 4:11.2.0-1ubuntu1 [27.7 kB]
Get:13 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libcc1-0 amd64 12.3.0-1ubuntu1~22.04.2 [48.3 kB]
Get:14 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgomp1 amd64 12.3.0-1ubuntu1~22.04.2 [127 kB]
Get:15 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libitm1 amd64 12.3.0-1ubuntu1~22.04.2 [30.2 kB]
Get:16 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libatomic1 amd64 12.3.0-1ubuntu1~22.04.2 [10.4 kB]
Get:17 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libasan6 amd64 11.4.0-1ubuntu1~22.04.2 [2283 kB]
Get:18 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 liblsan0 amd64 12.3.0-1ubuntu1~22.04.2 [1069 kB]
Get:19 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libtsan0 amd64 11.4.0-1ubuntu1~22.04.2 [2262 kB]
Get:20 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libubsan1 amd64 12.3.0-1ubuntu1~22.04.2 [976 kB]
Get:21 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libquadmath0 amd64 12.3.0-1ubuntu1~22.04.2 [154 kB]
Get:22 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgcc-11-dev amd64 11.4.0-1ubuntu1~22.04.2 [2517 kB]
Get:23 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 gcc-11 amd64 11.4.0-1ubuntu1~22.04.2 [20.1 MB]
Get:24 http://archive.ubuntu.com/ubuntu jammy/main amd64 gcc amd64 4:11.2.0-1ubuntu1 [5112 B]
Get:25 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libstdc++-11-dev amd64 11.4.0-1ubuntu1~22.04.2 [2101 kB]
Get:26 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 g++-11 amd64 11.4.0-1ubuntu1~22.04.2 [11.4 MB]
Get:27 http://archive.ubuntu.com/ubuntu jammy/main amd64 g++ amd64 4:11.2.0-1ubuntu1 [1412 B]
Get:28 http://archive.ubuntu.com/ubuntu jammy/main amd64 make amd64 4.3-4.1build1 [180 kB]
Get:29 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libdpkg-perl all 1.21.1ubuntu2.6 [237 kB]
Get:30 http://archive.ubuntu.com/ubuntu jammy/main amd64 bzip2 amd64 1.0.8-5build1 [34.8 kB]
Get:31 http://archive.ubuntu.com/ubuntu jammy/main amd64 lto-disabled-list all 24 [12.5 kB]
Get:32 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 dpkg-dev all 1.21.1ubuntu2.6 [922 kB]
Get:33 http://archive.ubuntu.com/ubuntu jammy/main amd64 build-essential amd64 12.9ubuntu3 [4744 B]
Get:34 http://archive.ubuntu.com/ubuntu jammy/main amd64 bzip2-doc all 1.0.8-5build1 [500 kB]
Get:35 http://archive.ubuntu.com/ubuntu jammy/main amd64 libfakeroot amd64 1.28-1ubuntu1 [31.5 kB]
Get:36 http://archive.ubuntu.com/ubuntu jammy/main amd64 fakeroot amd64 1.28-1ubuntu1 [60.4 kB]
Get:37 http://archive.ubuntu.com/ubuntu jammy/main amd64 icu-devtools amd64 70.1-2 [197 kB]
Get:38 http://archive.ubuntu.com/ubuntu jammy/main amd64 libalgorithm-diff-perl all 1.201-1 [41.8 kB]
Get:39 http://archive.ubuntu.com/ubuntu jammy/main amd64 libalgorithm-diff-xs-perl amd64 0.04-6build3 [11.9 kB]
Get:40 http://archive.ubuntu.com/ubuntu jammy/main amd64 libalgorithm-merge-perl all 0.08-3 [12.0 kB]
Get:41 http://archive.ubuntu.com/ubuntu jammy/main amd64 libbrotli-dev amd64 1.0.9-2build6 [337 kB]
Get:42 http://archive.ubuntu.com/ubuntu jammy/main amd64 libbz2-dev amd64 1.0.8-5build1 [32.5 kB]
Get:43 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxpm4 amd64 1:3.5.12-1ubuntu0.22.04.2 [36.7 kB]
Get:44 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgd3 amd64 2.3.0-2ubuntu2.3 [129 kB]
Get:45 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libc-devtools amd64 2.35-0ubuntu3.13 [29.0 kB]
Get:46 http://archive.ubuntu.com/ubuntu jammy/main amd64 libevent-2.1-7 amd64 2.1.12-stable-1build3 [148 kB]
Get:47 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libexpat1-dev amd64 2.4.7-1ubuntu0.6 [148 kB]
Get:48 http://archive.ubuntu.com/ubuntu jammy/main amd64 libfile-fcntllock-perl amd64 0.22-3build7 [33.9 kB]
Get:49 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 zlib1g-dev amd64 1:1.2.11.dfsg-2ubuntu9.2 [164 kB]
Get:50 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libpng-dev amd64 1.6.37-3ubuntu0.3 [193 kB]
Get:51 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libfreetype-dev amd64 2.11.1+dfsg-1ubuntu0.3 [555 kB]
Get:52 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libfreetype6-dev amd64 2.11.1+dfsg-1ubuntu0.3 [8298 B]
Get:53 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 uuid-dev amd64 2.37.2-4ubuntu3.4 [33.1 kB]
Get:54 http://archive.ubuntu.com/ubuntu jammy/main amd64 pkg-config amd64 0.29.2-1ubuntu3 [48.2 kB]
Get:55 http://archive.ubuntu.com/ubuntu jammy/main amd64 libfontconfig-dev amd64 2.13.1-4.2ubuntu5 [151 kB]
Get:56 http://archive.ubuntu.com/ubuntu jammy/main amd64 libfontconfig1-dev amd64 2.13.1-4.2ubuntu5 [1836 B]
Get:57 http://archive.ubuntu.com/ubuntu jammy/main amd64 libfontenc1 amd64 1:1.1.4-1build3 [14.7 kB]
Get:58 http://archive.ubuntu.com/ubuntu jammy/main amd64 libgpg-error-dev amd64 1.43-3 [129 kB]
Get:59 http://archive.ubuntu.com/ubuntu jammy/main amd64 libgcrypt20-dev amd64 1.9.4-3ubuntu3 [572 kB]
Get:60 http://archive.ubuntu.com/ubuntu jammy/main amd64 libgmpxx4ldbl amd64 2:6.2.1+dfsg-3ubuntu1 [9580 B]
Get:61 http://archive.ubuntu.com/ubuntu jammy/main amd64 libgmp-dev amd64 2:6.2.1+dfsg-3ubuntu1 [337 kB]
Get:62 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgnutls-openssl27 amd64 3.7.3-4ubuntu1.7 [22.8 kB]
Get:63 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libunbound8 amd64 1.13.1-1ubuntu5.14 [400 kB]
Get:64 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgnutls-dane0 amd64 3.7.3-4ubuntu1.7 [22.6 kB]
Get:65 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgnutlsxx28 amd64 3.7.3-4ubuntu1.7 [16.3 kB]
Get:66 http://archive.ubuntu.com/ubuntu jammy/main amd64 libidn2-dev amd64 2.3.2-2build1 [86.7 kB]
Get:67 http://archive.ubuntu.com/ubuntu jammy/main amd64 libp11-kit-dev amd64 0.24.0-6build1 [20.2 kB]
Get:68 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libtasn1-6-dev amd64 4.18.0-4ubuntu0.2 [91.8 kB]
Get:69 http://archive.ubuntu.com/ubuntu jammy/main amd64 nettle-dev amd64 3.7.3-1build2 [1135 kB]
Get:70 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgnutls28-dev amd64 3.7.3-4ubuntu1.7 [1044 kB]
Get:71 http://archive.ubuntu.com/ubuntu jammy/main amd64 libice6 amd64 2:1.0.10-1build2 [42.6 kB]
Get:72 http://archive.ubuntu.com/ubuntu jammy/main amd64 libicu-dev amd64 70.1-2 [11.6 MB]
Get:73 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libncurses-dev amd64 6.3-2ubuntu0.1 [381 kB]
Get:74 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libncursesw5-dev amd64 6.3-2ubuntu0.1 [790 B]
Get:75 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnspr4 amd64 2:4.35-0ubuntu0.22.04.1 [119 kB]
Get:76 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnspr4-dev amd64 2:4.35-0ubuntu0.22.04.1 [219 kB]
Get:77 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnss3 amd64 2:3.98-0ubuntu0.22.04.2 [1347 kB]
Get:78 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnss3-dev amd64 2:3.98-0ubuntu0.22.04.2 [246 kB]
Get:79 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libpng-tools amd64 1.6.37-3ubuntu0.3 [28.7 kB]
Get:80 http://archive.ubuntu.com/ubuntu jammy/main amd64 libpthread-stubs0-dev amd64 0.4-1build2 [5516 B]
Get:81 http://archive.ubuntu.com/ubuntu jammy/main amd64 libreadline-dev amd64 8.1.2-1 [166 kB]
Get:82 http://archive.ubuntu.com/ubuntu jammy/main amd64 libsm6 amd64 2:1.2.3-1build2 [16.7 kB]
Get:83 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libsqlite3-dev amd64 3.37.2-2ubuntu0.5 [847 kB]
Get:84 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libssl-dev amd64 3.0.2-0ubuntu1.21 [2375 kB]
Get:85 http://archive.ubuntu.com/ubuntu jammy/main amd64 libtcl8.6 amd64 8.6.12+dfsg-1build1 [990 kB]
Get:86 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxft2 amd64 2.3.4-1 [41.8 kB]
Get:87 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxss1 amd64 1:1.2.3-1build2 [8476 B]
Get:88 http://archive.ubuntu.com/ubuntu jammy/main amd64 libtk8.6 amd64 8.6.12-1build1 [784 kB]
Get:89 http://archive.ubuntu.com/ubuntu jammy/main amd64 xorg-sgml-doctools all 1:1.11-1.1 [10.9 kB]
Get:90 http://archive.ubuntu.com/ubuntu jammy/main amd64 x11proto-dev all 2021.5-1 [604 kB]
Get:91 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxau-dev amd64 1:1.0.9-1build5 [9724 B]
Get:92 http://archive.ubuntu.com/ubuntu jammy/main amd64 x11proto-core-dev all 2021.5-1 [2438 B]
Get:93 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxdmcp-dev amd64 1:1.1.3-0ubuntu5 [26.5 kB]
Get:94 http://archive.ubuntu.com/ubuntu jammy/main amd64 xtrans-dev all 1.4.0-1 [68.9 kB]
Get:95 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxcb1-dev amd64 1.14-3ubuntu3 [86.5 kB]
Get:96 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libx11-dev amd64 2:1.7.5-1ubuntu0.3 [744 kB]
Get:97 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxt6 amd64 1:1.2.1-1 [177 kB]
Get:98 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmu6 amd64 2:1.1.3-3 [49.6 kB]
Get:99 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxaw7 amd64 2:1.0.14-1 [191 kB]
Get:100 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxcb-shape0 amd64 1.14-3ubuntu3 [6158 B]
Get:101 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxext-dev amd64 2:1.3.4-1build1 [84.7 kB]
Get:102 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxrender-dev amd64 1:0.9.10-1build4 [26.7 kB]
Get:103 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxft-dev amd64 2.3.4-1 [52.4 kB]
Get:104 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxkbfile1 amd64 1:1.1.0-1build3 [71.8 kB]
Get:105 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxml2-dev amd64 2.9.13+dfsg-1ubuntu0.11 [805 kB]
Get:106 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmlsec1 amd64 1.2.33-1build2 [139 kB]
Get:107 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmlsec1-gcrypt amd64 1.2.33-1build2 [45.2 kB]
Get:108 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmlsec1-gnutls amd64 1.2.33-1build2 [36.9 kB]
Get:109 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmlsec1-nss amd64 1.2.33-1build2 [67.7 kB]
Get:110 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmlsec1-openssl amd64 1.2.33-1build2 [85.5 kB]
Get:111 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxslt1-dev amd64 1.1.34-4ubuntu0.22.04.5 [219 kB]
Get:112 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxmlsec1-dev amd64 1.2.33-1build2 [428 kB]
Get:113 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxss-dev amd64 1:1.2.3-1build2 [12.3 kB]
Get:114 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxv1 amd64 2:1.0.11-1build2 [11.2 kB]
Get:115 http://archive.ubuntu.com/ubuntu jammy/main amd64 libxxf86dga1 amd64 2:1.1.5-0ubuntu3 [12.6 kB]
Get:116 http://archive.ubuntu.com/ubuntu jammy/main amd64 manpages-dev all 5.10-1ubuntu1 [2309 kB]
Get:117 http://archive.ubuntu.com/ubuntu jammy/main amd64 tcl8.6 amd64 8.6.12+dfsg-1build1 [15.0 kB]
Get:118 http://archive.ubuntu.com/ubuntu jammy/main amd64 tcl amd64 8.6.11+1build2 [4678 B]
Get:119 http://archive.ubuntu.com/ubuntu jammy/main amd64 tcl8.6-dev amd64 8.6.12+dfsg-1build1 [1002 kB]
Get:120 http://archive.ubuntu.com/ubuntu jammy/main amd64 tcl-dev amd64 8.6.11+1build2 [5768 B]
Get:121 http://archive.ubuntu.com/ubuntu jammy/main amd64 tk8.6 amd64 8.6.12-1build1 [12.8 kB]
Get:122 http://archive.ubuntu.com/ubuntu jammy/main amd64 tk amd64 8.6.11+1build2 [3058 B]
Get:123 http://archive.ubuntu.com/ubuntu jammy/main amd64 tk8.6-dev amd64 8.6.12-1build1 [785 kB]
Get:124 http://archive.ubuntu.com/ubuntu jammy/main amd64 tk-dev amd64 8.6.11+1build2 [2904 B]
Get:125 http://archive.ubuntu.com/ubuntu jammy/main amd64 x11-utils amd64 7.7+5build2 [206 kB]
Get:126 http://archive.ubuntu.com/ubuntu jammy/main amd64 xbitmaps all 1.1.1-2.1ubuntu1 [23.4 kB]
Get:127 http://archive.ubuntu.com/ubuntu jammy/universe amd64 xterm amd64 372-1ubuntu1 [857 kB]
Get:128 http://archive.ubuntu.com/ubuntu jammy/main amd64 libffi-dev amd64 3.4.2-4 [63.7 kB]
Get:129 http://archive.ubuntu.com/ubuntu jammy/main amd64 liblzma-dev amd64 5.2.5-2ubuntu1 [159 kB]
Get:130 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 libtasn1-doc all 4.18.0-4ubuntu0.2 [305 kB]
Fetched 95.1 MB in 28s (3387 kB/s)
Extracting templates from packages: 100%
Selecting previously unselected package libc-dev-bin.
(Reading database ... 42697 files and directories currently installed.)
Preparing to unpack .../000-libc-dev-bin_2.35-0ubuntu3.13_amd64.deb ...
Unpacking libc-dev-bin (2.35-0ubuntu3.13) ...
Selecting previously unselected package linux-libc-dev:amd64.
Preparing to unpack .../001-linux-libc-dev_5.15.0-168.178_amd64.deb ...
Unpacking linux-libc-dev:amd64 (5.15.0-168.178) ...
Selecting previously unselected package libcrypt-dev:amd64.
Preparing to unpack .../002-libcrypt-dev_1%3a4.4.27-1_amd64.deb ...
Unpacking libcrypt-dev:amd64 (1:4.4.27-1) ...
Selecting previously unselected package rpcsvc-proto.
Preparing to unpack .../003-rpcsvc-proto_1.4.2-0ubuntu6_amd64.deb ...
Unpacking rpcsvc-proto (1.4.2-0ubuntu6) ...
Selecting previously unselected package libtirpc-dev:amd64.
Preparing to unpack .../004-libtirpc-dev_1.3.2-2ubuntu0.1_amd64.deb ...
Unpacking libtirpc-dev:amd64 (1.3.2-2ubuntu0.1) ...
Selecting previously unselected package libnsl-dev:amd64.
Preparing to unpack .../005-libnsl-dev_1.3.0-2build2_amd64.deb ...
Unpacking libnsl-dev:amd64 (1.3.0-2build2) ...
Selecting previously unselected package libc6-dev:amd64.
Preparing to unpack .../006-libc6-dev_2.35-0ubuntu3.13_amd64.deb ...
Unpacking libc6-dev:amd64 (2.35-0ubuntu3.13) ...
Selecting previously unselected package gcc-11-base:amd64.
Preparing to unpack .../007-gcc-11-base_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking gcc-11-base:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libisl23:amd64.
Preparing to unpack .../008-libisl23_0.24-2build1_amd64.deb ...
Unpacking libisl23:amd64 (0.24-2build1) ...
Selecting previously unselected package libmpc3:amd64.
Preparing to unpack .../009-libmpc3_1.2.1-2build1_amd64.deb ...
Unpacking libmpc3:amd64 (1.2.1-2build1) ...
Selecting previously unselected package cpp-11.
Preparing to unpack .../010-cpp-11_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking cpp-11 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package cpp.
Preparing to unpack .../011-cpp_4%3a11.2.0-1ubuntu1_amd64.deb ...
Unpacking cpp (4:11.2.0-1ubuntu1) ...
Selecting previously unselected package libcc1-0:amd64.
Preparing to unpack .../012-libcc1-0_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libcc1-0:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libgomp1:amd64.
Preparing to unpack .../013-libgomp1_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libgomp1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libitm1:amd64.
Preparing to unpack .../014-libitm1_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libitm1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libatomic1:amd64.
Preparing to unpack .../015-libatomic1_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libatomic1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libasan6:amd64.
Preparing to unpack .../016-libasan6_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libasan6:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package liblsan0:amd64.
Preparing to unpack .../017-liblsan0_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking liblsan0:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libtsan0:amd64.
Preparing to unpack .../018-libtsan0_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libtsan0:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libubsan1:amd64.
Preparing to unpack .../019-libubsan1_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libubsan1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libquadmath0:amd64.
Preparing to unpack .../020-libquadmath0_12.3.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libquadmath0:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package libgcc-11-dev:amd64.
Preparing to unpack .../021-libgcc-11-dev_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libgcc-11-dev:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package gcc-11.
Preparing to unpack .../022-gcc-11_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking gcc-11 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package gcc.
Preparing to unpack .../023-gcc_4%3a11.2.0-1ubuntu1_amd64.deb ...
Unpacking gcc (4:11.2.0-1ubuntu1) ...
Selecting previously unselected package libstdc++-11-dev:amd64.
Preparing to unpack .../024-libstdc++-11-dev_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking libstdc++-11-dev:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package g++-11.
Preparing to unpack .../025-g++-11_11.4.0-1ubuntu1~22.04.2_amd64.deb ...
Unpacking g++-11 (11.4.0-1ubuntu1~22.04.2) ...
Selecting previously unselected package g++.
Preparing to unpack .../026-g++_4%3a11.2.0-1ubuntu1_amd64.deb ...
Unpacking g++ (4:11.2.0-1ubuntu1) ...
Selecting previously unselected package make.
Preparing to unpack .../027-make_4.3-4.1build1_amd64.deb ...
Unpacking make (4.3-4.1build1) ...
Selecting previously unselected package libdpkg-perl.
Preparing to unpack .../028-libdpkg-perl_1.21.1ubuntu2.6_all.deb ...
Unpacking libdpkg-perl (1.21.1ubuntu2.6) ...
Selecting previously unselected package bzip2.
Preparing to unpack .../029-bzip2_1.0.8-5build1_amd64.deb ...
Unpacking bzip2 (1.0.8-5build1) ...
Selecting previously unselected package lto-disabled-list.
Preparing to unpack .../030-lto-disabled-list_24_all.deb ...
Unpacking lto-disabled-list (24) ...
Selecting previously unselected package dpkg-dev.
Preparing to unpack .../031-dpkg-dev_1.21.1ubuntu2.6_all.deb ...
Unpacking dpkg-dev (1.21.1ubuntu2.6) ...
Selecting previously unselected package build-essential.
Preparing to unpack .../032-build-essential_12.9ubuntu3_amd64.deb ...
Unpacking build-essential (12.9ubuntu3) ...
Selecting previously unselected package bzip2-doc.
Preparing to unpack .../033-bzip2-doc_1.0.8-5build1_all.deb ...
Unpacking bzip2-doc (1.0.8-5build1) ...
Selecting previously unselected package libfakeroot:amd64.
Preparing to unpack .../034-libfakeroot_1.28-1ubuntu1_amd64.deb ...
Unpacking libfakeroot:amd64 (1.28-1ubuntu1) ...
Selecting previously unselected package fakeroot.
Preparing to unpack .../035-fakeroot_1.28-1ubuntu1_amd64.deb ...
Unpacking fakeroot (1.28-1ubuntu1) ...
Selecting previously unselected package icu-devtools.
Preparing to unpack .../036-icu-devtools_70.1-2_amd64.deb ...
Unpacking icu-devtools (70.1-2) ...
Selecting previously unselected package libalgorithm-diff-perl.
Preparing to unpack .../037-libalgorithm-diff-perl_1.201-1_all.deb ...
Unpacking libalgorithm-diff-perl (1.201-1) ...
Selecting previously unselected package libalgorithm-diff-xs-perl.
Preparing to unpack .../038-libalgorithm-diff-xs-perl_0.04-6build3_amd64.deb ...
Unpacking libalgorithm-diff-xs-perl (0.04-6build3) ...
Selecting previously unselected package libalgorithm-merge-perl.
Preparing to unpack .../039-libalgorithm-merge-perl_0.08-3_all.deb ...
Unpacking libalgorithm-merge-perl (0.08-3) ...
Selecting previously unselected package libbrotli-dev:amd64.
Preparing to unpack .../040-libbrotli-dev_1.0.9-2build6_amd64.deb ...
Unpacking libbrotli-dev:amd64 (1.0.9-2build6) ...
Selecting previously unselected package libbz2-dev:amd64.
Preparing to unpack .../041-libbz2-dev_1.0.8-5build1_amd64.deb ...
Unpacking libbz2-dev:amd64 (1.0.8-5build1) ...
Selecting previously unselected package libxpm4:amd64.
Preparing to unpack .../042-libxpm4_1%3a3.5.12-1ubuntu0.22.04.2_amd64.deb ...
Unpacking libxpm4:amd64 (1:3.5.12-1ubuntu0.22.04.2) ...
Selecting previously unselected package libgd3:amd64.
Preparing to unpack .../043-libgd3_2.3.0-2ubuntu2.3_amd64.deb ...
Unpacking libgd3:amd64 (2.3.0-2ubuntu2.3) ...
Selecting previously unselected package libc-devtools.
Preparing to unpack .../044-libc-devtools_2.35-0ubuntu3.13_amd64.deb ...
Unpacking libc-devtools (2.35-0ubuntu3.13) ...
Selecting previously unselected package libevent-2.1-7:amd64.
Preparing to unpack .../045-libevent-2.1-7_2.1.12-stable-1build3_amd64.deb ...
Unpacking libevent-2.1-7:amd64 (2.1.12-stable-1build3) ...
Selecting previously unselected package libexpat1-dev:amd64.
Preparing to unpack .../046-libexpat1-dev_2.4.7-1ubuntu0.6_amd64.deb ...
Unpacking libexpat1-dev:amd64 (2.4.7-1ubuntu0.6) ...
Selecting previously unselected package libfile-fcntllock-perl.
Preparing to unpack .../047-libfile-fcntllock-perl_0.22-3build7_amd64.deb ...
Unpacking libfile-fcntllock-perl (0.22-3build7) ...
Selecting previously unselected package zlib1g-dev:amd64.
Preparing to unpack .../048-zlib1g-dev_1%3a1.2.11.dfsg-2ubuntu9.2_amd64.deb ...
Unpacking zlib1g-dev:amd64 (1:1.2.11.dfsg-2ubuntu9.2) ...
Selecting previously unselected package libpng-dev:amd64.
Preparing to unpack .../049-libpng-dev_1.6.37-3ubuntu0.3_amd64.deb ...
Unpacking libpng-dev:amd64 (1.6.37-3ubuntu0.3) ...
Selecting previously unselected package libfreetype-dev:amd64.
Preparing to unpack .../050-libfreetype-dev_2.11.1+dfsg-1ubuntu0.3_amd64.deb ...
Unpacking libfreetype-dev:amd64 (2.11.1+dfsg-1ubuntu0.3) ...
Selecting previously unselected package libfreetype6-dev:amd64.
Preparing to unpack .../051-libfreetype6-dev_2.11.1+dfsg-1ubuntu0.3_amd64.deb ...
Unpacking libfreetype6-dev:amd64 (2.11.1+dfsg-1ubuntu0.3) ...
Selecting previously unselected package uuid-dev:amd64.
Preparing to unpack .../052-uuid-dev_2.37.2-4ubuntu3.4_amd64.deb ...
Unpacking uuid-dev:amd64 (2.37.2-4ubuntu3.4) ...
Selecting previously unselected package pkg-config.
Preparing to unpack .../053-pkg-config_0.29.2-1ubuntu3_amd64.deb ...
Unpacking pkg-config (0.29.2-1ubuntu3) ...
Selecting previously unselected package libfontconfig-dev:amd64.
Preparing to unpack .../054-libfontconfig-dev_2.13.1-4.2ubuntu5_amd64.deb ...
Unpacking libfontconfig-dev:amd64 (2.13.1-4.2ubuntu5) ...
Selecting previously unselected package libfontconfig1-dev:amd64.
Preparing to unpack .../055-libfontconfig1-dev_2.13.1-4.2ubuntu5_amd64.deb ...
Unpacking libfontconfig1-dev:amd64 (2.13.1-4.2ubuntu5) ...
Selecting previously unselected package libfontenc1:amd64.
Preparing to unpack .../056-libfontenc1_1%3a1.1.4-1build3_amd64.deb ...
Unpacking libfontenc1:amd64 (1:1.1.4-1build3) ...
Selecting previously unselected package libgpg-error-dev.
Preparing to unpack .../057-libgpg-error-dev_1.43-3_amd64.deb ...
Unpacking libgpg-error-dev (1.43-3) ...
Selecting previously unselected package libgcrypt20-dev.
Preparing to unpack .../058-libgcrypt20-dev_1.9.4-3ubuntu3_amd64.deb ...
Unpacking libgcrypt20-dev (1.9.4-3ubuntu3) ...
Selecting previously unselected package libgmpxx4ldbl:amd64.
Preparing to unpack .../059-libgmpxx4ldbl_2%3a6.2.1+dfsg-3ubuntu1_amd64.deb ...
Unpacking libgmpxx4ldbl:amd64 (2:6.2.1+dfsg-3ubuntu1) ...
Selecting previously unselected package libgmp-dev:amd64.
Preparing to unpack .../060-libgmp-dev_2%3a6.2.1+dfsg-3ubuntu1_amd64.deb ...
Unpacking libgmp-dev:amd64 (2:6.2.1+dfsg-3ubuntu1) ...
Selecting previously unselected package libgnutls-openssl27:amd64.
Preparing to unpack .../061-libgnutls-openssl27_3.7.3-4ubuntu1.7_amd64.deb ...
Unpacking libgnutls-openssl27:amd64 (3.7.3-4ubuntu1.7) ...
Selecting previously unselected package libunbound8:amd64.
Preparing to unpack .../062-libunbound8_1.13.1-1ubuntu5.14_amd64.deb ...
Unpacking libunbound8:amd64 (1.13.1-1ubuntu5.14) ...
Selecting previously unselected package libgnutls-dane0:amd64.
Preparing to unpack .../063-libgnutls-dane0_3.7.3-4ubuntu1.7_amd64.deb ...
Unpacking libgnutls-dane0:amd64 (3.7.3-4ubuntu1.7) ...
Selecting previously unselected package libgnutlsxx28:amd64.
Preparing to unpack .../064-libgnutlsxx28_3.7.3-4ubuntu1.7_amd64.deb ...
Unpacking libgnutlsxx28:amd64 (3.7.3-4ubuntu1.7) ...
Selecting previously unselected package libidn2-dev:amd64.
Preparing to unpack .../065-libidn2-dev_2.3.2-2build1_amd64.deb ...
Unpacking libidn2-dev:amd64 (2.3.2-2build1) ...
Selecting previously unselected package libp11-kit-dev:amd64.
Preparing to unpack .../066-libp11-kit-dev_0.24.0-6build1_amd64.deb ...
Unpacking libp11-kit-dev:amd64 (0.24.0-6build1) ...
Selecting previously unselected package libtasn1-6-dev:amd64.
Preparing to unpack .../067-libtasn1-6-dev_4.18.0-4ubuntu0.2_amd64.deb ...
Unpacking libtasn1-6-dev:amd64 (4.18.0-4ubuntu0.2) ...
Selecting previously unselected package nettle-dev:amd64.
Preparing to unpack .../068-nettle-dev_3.7.3-1build2_amd64.deb ...
Unpacking nettle-dev:amd64 (3.7.3-1build2) ...
Selecting previously unselected package libgnutls28-dev:amd64.
Preparing to unpack .../069-libgnutls28-dev_3.7.3-4ubuntu1.7_amd64.deb ...
Unpacking libgnutls28-dev:amd64 (3.7.3-4ubuntu1.7) ...
Selecting previously unselected package libice6:amd64.
Preparing to unpack .../070-libice6_2%3a1.0.10-1build2_amd64.deb ...
Unpacking libice6:amd64 (2:1.0.10-1build2) ...
Selecting previously unselected package libicu-dev:amd64.
Preparing to unpack .../071-libicu-dev_70.1-2_amd64.deb ...
Unpacking libicu-dev:amd64 (70.1-2) ...
Selecting previously unselected package libncurses-dev:amd64.
Preparing to unpack .../072-libncurses-dev_6.3-2ubuntu0.1_amd64.deb ...
Unpacking libncurses-dev:amd64 (6.3-2ubuntu0.1) ...
Selecting previously unselected package libncursesw5-dev:amd64.
Preparing to unpack .../073-libncursesw5-dev_6.3-2ubuntu0.1_amd64.deb ...
Unpacking libncursesw5-dev:amd64 (6.3-2ubuntu0.1) ...
Selecting previously unselected package libnspr4:amd64.
Preparing to unpack .../074-libnspr4_2%3a4.35-0ubuntu0.22.04.1_amd64.deb ...
Unpacking libnspr4:amd64 (2:4.35-0ubuntu0.22.04.1) ...
Selecting previously unselected package libnspr4-dev.
Preparing to unpack .../075-libnspr4-dev_2%3a4.35-0ubuntu0.22.04.1_amd64.deb ...
Unpacking libnspr4-dev (2:4.35-0ubuntu0.22.04.1) ...
Selecting previously unselected package libnss3:amd64.
Preparing to unpack .../076-libnss3_2%3a3.98-0ubuntu0.22.04.2_amd64.deb ...
Unpacking libnss3:amd64 (2:3.98-0ubuntu0.22.04.2) ...
Selecting previously unselected package libnss3-dev:amd64.
Preparing to unpack .../077-libnss3-dev_2%3a3.98-0ubuntu0.22.04.2_amd64.deb ...
Unpacking libnss3-dev:amd64 (2:3.98-0ubuntu0.22.04.2) ...
Selecting previously unselected package libpng-tools.
Preparing to unpack .../078-libpng-tools_1.6.37-3ubuntu0.3_amd64.deb ...
Unpacking libpng-tools (1.6.37-3ubuntu0.3) ...
Selecting previously unselected package libpthread-stubs0-dev:amd64.
Preparing to unpack .../079-libpthread-stubs0-dev_0.4-1build2_amd64.deb ...
Unpacking libpthread-stubs0-dev:amd64 (0.4-1build2) ...
Selecting previously unselected package libreadline-dev:amd64.
Preparing to unpack .../080-libreadline-dev_8.1.2-1_amd64.deb ...
Unpacking libreadline-dev:amd64 (8.1.2-1) ...
Selecting previously unselected package libsm6:amd64.
Preparing to unpack .../081-libsm6_2%3a1.2.3-1build2_amd64.deb ...
Unpacking libsm6:amd64 (2:1.2.3-1build2) ...
Selecting previously unselected package libsqlite3-dev:amd64.
Preparing to unpack .../082-libsqlite3-dev_3.37.2-2ubuntu0.5_amd64.deb ...
Unpacking libsqlite3-dev:amd64 (3.37.2-2ubuntu0.5) ...
Selecting previously unselected package libssl-dev:amd64.
Preparing to unpack .../083-libssl-dev_3.0.2-0ubuntu1.21_amd64.deb ...
Unpacking libssl-dev:amd64 (3.0.2-0ubuntu1.21) ...
Selecting previously unselected package libtcl8.6:amd64.
Preparing to unpack .../084-libtcl8.6_8.6.12+dfsg-1build1_amd64.deb ...
Unpacking libtcl8.6:amd64 (8.6.12+dfsg-1build1) ...
Selecting previously unselected package libxft2:amd64.
Preparing to unpack .../085-libxft2_2.3.4-1_amd64.deb ...
Unpacking libxft2:amd64 (2.3.4-1) ...
Selecting previously unselected package libxss1:amd64.
Preparing to unpack .../086-libxss1_1%3a1.2.3-1build2_amd64.deb ...
Unpacking libxss1:amd64 (1:1.2.3-1build2) ...
Selecting previously unselected package libtk8.6:amd64.
Preparing to unpack .../087-libtk8.6_8.6.12-1build1_amd64.deb ...
Unpacking libtk8.6:amd64 (8.6.12-1build1) ...
Selecting previously unselected package xorg-sgml-doctools.
Preparing to unpack .../088-xorg-sgml-doctools_1%3a1.11-1.1_all.deb ...
Unpacking xorg-sgml-doctools (1:1.11-1.1) ...
Selecting previously unselected package x11proto-dev.
Preparing to unpack .../089-x11proto-dev_2021.5-1_all.deb ...
Unpacking x11proto-dev (2021.5-1) ...
Selecting previously unselected package libxau-dev:amd64.
Preparing to unpack .../090-libxau-dev_1%3a1.0.9-1build5_amd64.deb ...
Unpacking libxau-dev:amd64 (1:1.0.9-1build5) ...
Selecting previously unselected package x11proto-core-dev.
Preparing to unpack .../091-x11proto-core-dev_2021.5-1_all.deb ...
Unpacking x11proto-core-dev (2021.5-1) ...
Selecting previously unselected package libxdmcp-dev:amd64.
Preparing to unpack .../092-libxdmcp-dev_1%3a1.1.3-0ubuntu5_amd64.deb ...
Unpacking libxdmcp-dev:amd64 (1:1.1.3-0ubuntu5) ...
Selecting previously unselected package xtrans-dev.
Preparing to unpack .../093-xtrans-dev_1.4.0-1_all.deb ...
Unpacking xtrans-dev (1.4.0-1) ...
Selecting previously unselected package libxcb1-dev:amd64.
Preparing to unpack .../094-libxcb1-dev_1.14-3ubuntu3_amd64.deb ...
Unpacking libxcb1-dev:amd64 (1.14-3ubuntu3) ...
Selecting previously unselected package libx11-dev:amd64.
Preparing to unpack .../095-libx11-dev_2%3a1.7.5-1ubuntu0.3_amd64.deb ...
Unpacking libx11-dev:amd64 (2:1.7.5-1ubuntu0.3) ...
Selecting previously unselected package libxt6:amd64.
Preparing to unpack .../096-libxt6_1%3a1.2.1-1_amd64.deb ...
Unpacking libxt6:amd64 (1:1.2.1-1) ...
Selecting previously unselected package libxmu6:amd64.
Preparing to unpack .../097-libxmu6_2%3a1.1.3-3_amd64.deb ...
Unpacking libxmu6:amd64 (2:1.1.3-3) ...
Selecting previously unselected package libxaw7:amd64.
Preparing to unpack .../098-libxaw7_2%3a1.0.14-1_amd64.deb ...
Unpacking libxaw7:amd64 (2:1.0.14-1) ...
Selecting previously unselected package libxcb-shape0:amd64.
Preparing to unpack .../099-libxcb-shape0_1.14-3ubuntu3_amd64.deb ...
Unpacking libxcb-shape0:amd64 (1.14-3ubuntu3) ...
Selecting previously unselected package libxext-dev:amd64.
Preparing to unpack .../100-libxext-dev_2%3a1.3.4-1build1_amd64.deb ...
Unpacking libxext-dev:amd64 (2:1.3.4-1build1) ...
Selecting previously unselected package libxrender-dev:amd64.
Preparing to unpack .../101-libxrender-dev_1%3a0.9.10-1build4_amd64.deb ...
Unpacking libxrender-dev:amd64 (1:0.9.10-1build4) ...
Selecting previously unselected package libxft-dev:amd64.
Preparing to unpack .../102-libxft-dev_2.3.4-1_amd64.deb ...
Unpacking libxft-dev:amd64 (2.3.4-1) ...
Selecting previously unselected package libxkbfile1:amd64.
Preparing to unpack .../103-libxkbfile1_1%3a1.1.0-1build3_amd64.deb ...
Unpacking libxkbfile1:amd64 (1:1.1.0-1build3) ...
Selecting previously unselected package libxml2-dev:amd64.
Preparing to unpack .../104-libxml2-dev_2.9.13+dfsg-1ubuntu0.11_amd64.deb ...
Unpacking libxml2-dev:amd64 (2.9.13+dfsg-1ubuntu0.11) ...
Selecting previously unselected package libxmlsec1:amd64.
Preparing to unpack .../105-libxmlsec1_1.2.33-1build2_amd64.deb ...
Unpacking libxmlsec1:amd64 (1.2.33-1build2) ...
Selecting previously unselected package libxmlsec1-gcrypt:amd64.
Preparing to unpack .../106-libxmlsec1-gcrypt_1.2.33-1build2_amd64.deb ...
Unpacking libxmlsec1-gcrypt:amd64 (1.2.33-1build2) ...
Selecting previously unselected package libxmlsec1-gnutls:amd64.
Preparing to unpack .../107-libxmlsec1-gnutls_1.2.33-1build2_amd64.deb ...
Unpacking libxmlsec1-gnutls:amd64 (1.2.33-1build2) ...
Selecting previously unselected package libxmlsec1-nss:amd64.
Preparing to unpack .../108-libxmlsec1-nss_1.2.33-1build2_amd64.deb ...
Unpacking libxmlsec1-nss:amd64 (1.2.33-1build2) ...
Selecting previously unselected package libxmlsec1-openssl:amd64.
Preparing to unpack .../109-libxmlsec1-openssl_1.2.33-1build2_amd64.deb ...
Unpacking libxmlsec1-openssl:amd64 (1.2.33-1build2) ...
Selecting previously unselected package libxslt1-dev:amd64.
Preparing to unpack .../110-libxslt1-dev_1.1.34-4ubuntu0.22.04.5_amd64.deb ...
Unpacking libxslt1-dev:amd64 (1.1.34-4ubuntu0.22.04.5) ...
Selecting previously unselected package libxmlsec1-dev.
Preparing to unpack .../111-libxmlsec1-dev_1.2.33-1build2_amd64.deb ...
Unpacking libxmlsec1-dev (1.2.33-1build2) ...
Selecting previously unselected package libxss-dev:amd64.
Preparing to unpack .../112-libxss-dev_1%3a1.2.3-1build2_amd64.deb ...
Unpacking libxss-dev:amd64 (1:1.2.3-1build2) ...
Selecting previously unselected package libxv1:amd64.
Preparing to unpack .../113-libxv1_2%3a1.0.11-1build2_amd64.deb ...
Unpacking libxv1:amd64 (2:1.0.11-1build2) ...
Selecting previously unselected package libxxf86dga1:amd64.
Preparing to unpack .../114-libxxf86dga1_2%3a1.1.5-0ubuntu3_amd64.deb ...
Unpacking libxxf86dga1:amd64 (2:1.1.5-0ubuntu3) ...
Selecting previously unselected package manpages-dev.
Preparing to unpack .../115-manpages-dev_5.10-1ubuntu1_all.deb ...
Unpacking manpages-dev (5.10-1ubuntu1) ...
Selecting previously unselected package tcl8.6.
Preparing to unpack .../116-tcl8.6_8.6.12+dfsg-1build1_amd64.deb ...
Unpacking tcl8.6 (8.6.12+dfsg-1build1) ...
Selecting previously unselected package tcl.
Preparing to unpack .../117-tcl_8.6.11+1build2_amd64.deb ...
Unpacking tcl (8.6.11+1build2) ...
Selecting previously unselected package tcl8.6-dev:amd64.
Preparing to unpack .../118-tcl8.6-dev_8.6.12+dfsg-1build1_amd64.deb ...
Unpacking tcl8.6-dev:amd64 (8.6.12+dfsg-1build1) ...
Selecting previously unselected package tcl-dev:amd64.
Preparing to unpack .../119-tcl-dev_8.6.11+1build2_amd64.deb ...
Unpacking tcl-dev:amd64 (8.6.11+1build2) ...
Selecting previously unselected package tk8.6.
Preparing to unpack .../120-tk8.6_8.6.12-1build1_amd64.deb ...
Unpacking tk8.6 (8.6.12-1build1) ...
Selecting previously unselected package tk.
Preparing to unpack .../121-tk_8.6.11+1build2_amd64.deb ...
Unpacking tk (8.6.11+1build2) ...
Selecting previously unselected package tk8.6-dev:amd64.
Preparing to unpack .../122-tk8.6-dev_8.6.12-1build1_amd64.deb ...
Unpacking tk8.6-dev:amd64 (8.6.12-1build1) ...
Selecting previously unselected package tk-dev:amd64.
Preparing to unpack .../123-tk-dev_8.6.11+1build2_amd64.deb ...
Unpacking tk-dev:amd64 (8.6.11+1build2) ...
Selecting previously unselected package x11-utils.
Preparing to unpack .../124-x11-utils_7.7+5build2_amd64.deb ...
Unpacking x11-utils (7.7+5build2) ...
Selecting previously unselected package xbitmaps.
Preparing to unpack .../125-xbitmaps_1.1.1-2.1ubuntu1_all.deb ...
Unpacking xbitmaps (1.1.1-2.1ubuntu1) ...
Selecting previously unselected package xterm.
Preparing to unpack .../126-xterm_372-1ubuntu1_amd64.deb ...
Unpacking xterm (372-1ubuntu1) ...
Selecting previously unselected package libffi-dev:amd64.
Preparing to unpack .../127-libffi-dev_3.4.2-4_amd64.deb ...
Unpacking libffi-dev:amd64 (3.4.2-4) ...
Selecting previously unselected package liblzma-dev:amd64.
Preparing to unpack .../128-liblzma-dev_5.2.5-2ubuntu1_amd64.deb ...
Unpacking liblzma-dev:amd64 (5.2.5-2ubuntu1) ...
Selecting previously unselected package libtasn1-doc.
Preparing to unpack .../129-libtasn1-doc_4.18.0-4ubuntu0.2_all.deb ...
Unpacking libtasn1-doc (4.18.0-4ubuntu0.2) ...
Setting up bzip2-doc (1.0.8-5build1) ...
Setting up gcc-11-base:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Setting up manpages-dev (5.10-1ubuntu1) ...
Setting up libice6:amd64 (2:1.0.10-1build2) ...
Setting up lto-disabled-list (24) ...
Setting up libxft2:amd64 (2.3.4-1) ...
Setting up libgnutls-openssl27:amd64 (3.7.3-4ubuntu1.7) ...
Setting up libxpm4:amd64 (1:3.5.12-1ubuntu0.22.04.2) ...
Setting up libpng-tools (1.6.37-3ubuntu0.3) ...
Setting up libfile-fcntllock-perl (0.22-3build7) ...
Setting up libalgorithm-diff-perl (1.201-1) ...
Setting up libtasn1-doc (4.18.0-4ubuntu0.2) ...
Setting up libxcb-shape0:amd64 (1.14-3ubuntu3) ...
Setting up libxxf86dga1:amd64 (2:1.1.5-0ubuntu3) ...
Setting up linux-libc-dev:amd64 (5.15.0-168.178) ...
Setting up libgomp1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up bzip2 (1.0.8-5build1) ...
Setting up libffi-dev:amd64 (3.4.2-4) ...
Setting up libpthread-stubs0-dev:amd64 (0.4-1build2) ...
Setting up libfakeroot:amd64 (1.28-1ubuntu1) ...
Setting up libasan6:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Setting up fakeroot (1.28-1ubuntu1) ...
update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode
Setting up xtrans-dev (1.4.0-1) ...
Setting up libfontenc1:amd64 (1:1.1.4-1build3) ...
Setting up libtirpc-dev:amd64 (1.3.2-2ubuntu0.1) ...
Setting up libgmpxx4ldbl:amd64 (2:6.2.1+dfsg-3ubuntu1) ...
Setting up rpcsvc-proto (1.4.2-0ubuntu6) ...
Setting up make (4.3-4.1build1) ...
Setting up libgpg-error-dev (1.43-3) ...
Setting up libnspr4:amd64 (2:4.35-0ubuntu0.22.04.1) ...
Setting up libquadmath0:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up libgd3:amd64 (2.3.0-2ubuntu2.3) ...
Setting up libxv1:amd64 (2:1.0.11-1build2) ...
Setting up libssl-dev:amd64 (3.0.2-0ubuntu1.21) ...
Setting up libmpc3:amd64 (1.2.1-2build1) ...
Setting up libatomic1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up libevent-2.1-7:amd64 (2.1.12-stable-1build3) ...
Setting up libtcl8.6:amd64 (8.6.12+dfsg-1build1) ...
Setting up icu-devtools (70.1-2) ...
Setting up libgnutlsxx28:amd64 (3.7.3-4ubuntu1.7) ...
Setting up libidn2-dev:amd64 (2.3.2-2build1) ...
Setting up libdpkg-perl (1.21.1ubuntu2.6) ...
Setting up liblzma-dev:amd64 (5.2.5-2ubuntu1) ...
Setting up libubsan1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up libnsl-dev:amd64 (1.3.0-2build2) ...
Setting up libcrypt-dev:amd64 (1:4.4.27-1) ...
Setting up xorg-sgml-doctools (1:1.11-1.1) ...
Setting up libxss1:amd64 (1:1.2.3-1build2) ...
Setting up libxkbfile1:amd64 (1:1.1.0-1build3) ...
Setting up libxmlsec1:amd64 (1.2.33-1build2) ...
Setting up libisl23:amd64 (0.24-2build1) ...
Setting up libc-dev-bin (2.35-0ubuntu3.13) ...
Setting up libtasn1-6-dev:amd64 (4.18.0-4ubuntu0.2) ...
Setting up libsm6:amd64 (2:1.2.3-1build2) ...
Setting up libalgorithm-diff-xs-perl (0.04-6build3) ...
Setting up libcc1-0:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up libbrotli-dev:amd64 (1.0.9-2build6) ...
Setting up xbitmaps (1.1.1-2.1ubuntu1) ...
Setting up liblsan0:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up libp11-kit-dev:amd64 (0.24.0-6build1) ...
Setting up libitm1:amd64 (12.3.0-1ubuntu1~22.04.2) ...
Setting up libc-devtools (2.35-0ubuntu3.13) ...
Setting up libalgorithm-merge-perl (0.08-3) ...
Setting up libtsan0:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Setting up x11proto-dev (2021.5-1) ...
Setting up libnspr4-dev (2:4.35-0ubuntu0.22.04.1) ...
Setting up cpp-11 (11.4.0-1ubuntu1~22.04.2) ...
Setting up tcl8.6 (8.6.12+dfsg-1build1) ...
Setting up libgmp-dev:amd64 (2:6.2.1+dfsg-3ubuntu1) ...
Setting up libxau-dev:amd64 (1:1.0.9-1build5) ...
Setting up nettle-dev:amd64 (3.7.3-1build2) ...
Setting up libxmlsec1-openssl:amd64 (1.2.33-1build2) ...
Setting up libtk8.6:amd64 (8.6.12-1build1) ...
Setting up libnss3:amd64 (2:3.98-0ubuntu0.22.04.2) ...
Setting up dpkg-dev (1.21.1ubuntu2.6) ...
Setting up libxdmcp-dev:amd64 (1:1.1.3-0ubuntu5) ...
Setting up libunbound8:amd64 (1.13.1-1ubuntu5.14) ...
Setting up x11proto-core-dev (2021.5-1) ...
Setting up libxmlsec1-gcrypt:amd64 (1.2.33-1build2) ...
Setting up pkg-config (0.29.2-1ubuntu3) ...
Setting up libxt6:amd64 (1:1.2.1-1) ...
Setting up libxmlsec1-nss:amd64 (1.2.33-1build2) ...
Setting up libgcc-11-dev:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Setting up gcc-11 (11.4.0-1ubuntu1~22.04.2) ...
Setting up libnss3-dev:amd64 (2:3.98-0ubuntu0.22.04.2) ...
Setting up cpp (4:11.2.0-1ubuntu1) ...
Setting up tcl (8.6.11+1build2) ...
Setting up libc6-dev:amd64 (2.35-0ubuntu3.13) ...
Setting up libxmlsec1-gnutls:amd64 (1.2.33-1build2) ...
Setting up libicu-dev:amd64 (70.1-2) ...
Setting up libbz2-dev:amd64 (1.0.8-5build1) ...
Setting up tk8.6 (8.6.12-1build1) ...
Setting up libgnutls-dane0:amd64 (3.7.3-4ubuntu1.7) ...
Setting up libncurses-dev:amd64 (6.3-2ubuntu0.1) ...
Setting up libxmu6:amd64 (2:1.1.3-3) ...
Setting up libxcb1-dev:amd64 (1.14-3ubuntu3) ...
Setting up libncursesw5-dev:amd64 (6.3-2ubuntu0.1) ...
Setting up libx11-dev:amd64 (2:1.7.5-1ubuntu0.3) ...
Setting up libxaw7:amd64 (2:1.0.14-1) ...
Setting up libreadline-dev:amd64 (8.1.2-1) ...
Setting up gcc (4:11.2.0-1ubuntu1) ...
Setting up libxml2-dev:amd64 (2.9.13+dfsg-1ubuntu0.11) ...
Setting up libexpat1-dev:amd64 (2.4.7-1ubuntu0.6) ...
Setting up libgcrypt20-dev (1.9.4-3ubuntu3) ...
Setting up libsqlite3-dev:amd64 (3.37.2-2ubuntu0.5) ...
Setting up uuid-dev:amd64 (2.37.2-4ubuntu3.4) ...
Setting up libxext-dev:amd64 (2:1.3.4-1build1) ...
Setting up libstdc++-11-dev:amd64 (11.4.0-1ubuntu1~22.04.2) ...
Setting up zlib1g-dev:amd64 (1:1.2.11.dfsg-2ubuntu9.2) ...
Setting up x11-utils (7.7+5build2) ...
Setting up xterm (372-1ubuntu1) ...
update-alternatives: using /usr/bin/xterm to provide /usr/bin/x-terminal-emulator (x-terminal-emulator) in auto mode
update-alternatives: using /usr/bin/lxterm to provide /usr/bin/x-terminal-emulator (x-terminal-emulator) in auto mode
Setting up tk (8.6.11+1build2) ...
Setting up libxrender-dev:amd64 (1:0.9.10-1build4) ...
Setting up libgnutls28-dev:amd64 (3.7.3-4ubuntu1.7) ...
Setting up libxslt1-dev:amd64 (1.1.34-4ubuntu0.22.04.5) ...
Setting up g++-11 (11.4.0-1ubuntu1~22.04.2) ...
Setting up tcl8.6-dev:amd64 (8.6.12+dfsg-1build1) ...
Setting up libpng-dev:amd64 (1.6.37-3ubuntu0.3) ...
Setting up libxss-dev:amd64 (1:1.2.3-1build2) ...
Setting up libfreetype-dev:amd64 (2.11.1+dfsg-1ubuntu0.3) ...
Setting up tcl-dev:amd64 (8.6.11+1build2) ...
Setting up g++ (4:11.2.0-1ubuntu1) ...
update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in auto mode
Setting up libxmlsec1-dev (1.2.33-1build2) ...
Setting up build-essential (12.9ubuntu3) ...
Setting up libfontconfig-dev:amd64 (2.13.1-4.2ubuntu5) ...
Setting up libfreetype6-dev:amd64 (2.11.1+dfsg-1ubuntu0.3) ...
Setting up libxft-dev:amd64 (2.3.4-1) ...
Setting up libfontconfig1-dev:amd64 (2.13.1-4.2ubuntu5) ...
Setting up tk8.6-dev:amd64 (8.6.12-1build1) ...
Setting up tk-dev:amd64 (8.6.11+1build2) ...
Processing triggers for hicolor-icon-theme (0.17-2) ...
Processing triggers for libc-bin (2.35-0ubuntu3.13) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for install-info (6.8-4build1) ...
root@gabes:~# pyenv install 3.11.12
pyenv virtualenv 3.11.12 myenv
pyenv activate myenv
Downloading Python-3.11.12.tar.xz...
-> https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
Installing Python-3.11.12...
patching file setup.py
Installed Python-3.11.12 to /root/.pyenv/versions/3.11.12
(myenv) root@gabes:~# pip install pandas matplotlib seaborn plotly jupyter
Collecting pandas
  Downloading pandas-3.0.0-cp311-cp311-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl.metadata (79 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 79.5/79.5 kB 491.0 kB/s eta 0:00:00
Collecting matplotlib
  Downloading matplotlib-3.10.8-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl.metadata (52 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 52.8/52.8 kB 525.2 kB/s eta 0:00:00
Collecting seaborn
  Downloading seaborn-0.13.2-py3-none-any.whl.metadata (5.4 kB)
Collecting plotly
  Downloading plotly-6.5.2-py3-none-any.whl.metadata (8.5 kB)
Collecting jupyter
  Downloading jupyter-1.1.1-py2.py3-none-any.whl.metadata (2.0 kB)
Collecting numpy>=1.26.0 (from pandas)
  Downloading numpy-2.4.2-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl.metadata (6.6 kB)
Collecting python-dateutil>=2.8.2 (from pandas)
  Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl.metadata (8.4 kB)
Collecting contourpy>=1.0.1 (from matplotlib)
  Downloading contourpy-1.3.3-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl.metadata (5.5 kB)
Collecting cycler>=0.10 (from matplotlib)
  Downloading cycler-0.12.1-py3-none-any.whl.metadata (3.8 kB)
Collecting fonttools>=4.22.0 (from matplotlib)
  Downloading fonttools-4.61.1-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl.metadata (114 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 114.2/114.2 kB 1.4 MB/s eta 0:00:00
Collecting kiwisolver>=1.3.1 (from matplotlib)
  Downloading kiwisolver-1.4.9-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl.metadata (6.3 kB)
Collecting packaging>=20.0 (from matplotlib)
  Downloading packaging-26.0-py3-none-any.whl.metadata (3.3 kB)
Collecting pillow>=8 (from matplotlib)
  Downloading pillow-12.1.0-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl.metadata (8.8 kB)
Collecting pyparsing>=3 (from matplotlib)
  Downloading pyparsing-3.3.2-py3-none-any.whl.metadata (5.8 kB)
Collecting narwhals>=1.15.1 (from plotly)
  Downloading narwhals-2.16.0-py3-none-any.whl.metadata (14 kB)
Collecting notebook (from jupyter)
  Downloading notebook-7.5.3-py3-none-any.whl.metadata (10 kB)
Collecting jupyter-console (from jupyter)
  Downloading jupyter_console-6.6.3-py3-none-any.whl.metadata (5.8 kB)
Collecting nbconvert (from jupyter)
  Downloading nbconvert-7.17.0-py3-none-any.whl.metadata (8.4 kB)
Collecting ipykernel (from jupyter)
  Downloading ipykernel-7.1.0-py3-none-any.whl.metadata (4.5 kB)
Collecting ipywidgets (from jupyter)
  Downloading ipywidgets-8.1.8-py3-none-any.whl.metadata (2.4 kB)
Collecting jupyterlab (from jupyter)
  Downloading jupyterlab-4.5.3-py3-none-any.whl.metadata (16 kB)
Collecting six>=1.5 (from python-dateutil>=2.8.2->pandas)
  Downloading six-1.17.0-py2.py3-none-any.whl.metadata (1.7 kB)
Collecting comm>=0.1.1 (from ipykernel->jupyter)
  Downloading comm-0.2.3-py3-none-any.whl.metadata (3.7 kB)
Collecting debugpy>=1.6.5 (from ipykernel->jupyter)
  Downloading debugpy-1.8.20-cp311-cp311-manylinux_2_34_x86_64.whl.metadata (1.4 kB)
Collecting ipython>=7.23.1 (from ipykernel->jupyter)
  Downloading ipython-9.10.0-py3-none-any.whl.metadata (4.6 kB)
Collecting jupyter-client>=8.0.0 (from ipykernel->jupyter)
  Downloading jupyter_client-8.8.0-py3-none-any.whl.metadata (8.4 kB)
Collecting jupyter-core!=5.0.*,>=4.12 (from ipykernel->jupyter)
  Downloading jupyter_core-5.9.1-py3-none-any.whl.metadata (1.5 kB)
Collecting matplotlib-inline>=0.1 (from ipykernel->jupyter)
  Downloading matplotlib_inline-0.2.1-py3-none-any.whl.metadata (2.3 kB)
Collecting nest-asyncio>=1.4 (from ipykernel->jupyter)
  Downloading nest_asyncio-1.6.0-py3-none-any.whl.metadata (2.8 kB)
Collecting psutil>=5.7 (from ipykernel->jupyter)
  Downloading psutil-7.2.2-cp36-abi3-manylinux2010_x86_64.manylinux_2_12_x86_64.manylinux_2_28_x86_64.whl.metadata (22 kB)
Collecting pyzmq>=25 (from ipykernel->jupyter)
  Downloading pyzmq-27.1.0-cp311-cp311-manylinux_2_26_x86_64.manylinux_2_28_x86_64.whl.metadata (6.0 kB)
Collecting tornado>=6.2 (from ipykernel->jupyter)
  Downloading tornado-6.5.4-cp39-abi3-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (2.8 kB)
Collecting traitlets>=5.4.0 (from ipykernel->jupyter)
  Downloading traitlets-5.14.3-py3-none-any.whl.metadata (10 kB)
Collecting widgetsnbextension~=4.0.14 (from ipywidgets->jupyter)
  Downloading widgetsnbextension-4.0.15-py3-none-any.whl.metadata (1.6 kB)
Collecting jupyterlab_widgets~=3.0.15 (from ipywidgets->jupyter)
  Downloading jupyterlab_widgets-3.0.16-py3-none-any.whl.metadata (20 kB)
Collecting prompt-toolkit>=3.0.30 (from jupyter-console->jupyter)
  Downloading prompt_toolkit-3.0.52-py3-none-any.whl.metadata (6.4 kB)
Collecting pygments (from jupyter-console->jupyter)
  Downloading pygments-2.19.2-py3-none-any.whl.metadata (2.5 kB)
Collecting async-lru>=1.0.0 (from jupyterlab->jupyter)
  Downloading async_lru-2.1.0-py3-none-any.whl.metadata (5.3 kB)
Collecting httpx<1,>=0.25.0 (from jupyterlab->jupyter)
  Downloading httpx-0.28.1-py3-none-any.whl.metadata (7.1 kB)
Collecting jinja2>=3.0.3 (from jupyterlab->jupyter)
  Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
Collecting jupyter-lsp>=2.0.0 (from jupyterlab->jupyter)
  Downloading jupyter_lsp-2.3.0-py3-none-any.whl.metadata (1.8 kB)
Collecting jupyter-server<3,>=2.4.0 (from jupyterlab->jupyter)
  Downloading jupyter_server-2.17.0-py3-none-any.whl.metadata (8.5 kB)
Collecting jupyterlab-server<3,>=2.28.0 (from jupyterlab->jupyter)
  Downloading jupyterlab_server-2.28.0-py3-none-any.whl.metadata (5.9 kB)
Collecting notebook-shim>=0.2 (from jupyterlab->jupyter)
  Downloading notebook_shim-0.2.4-py3-none-any.whl.metadata (4.0 kB)
Requirement already satisfied: setuptools>=41.1.0 in ./.pyenv/versions/3.11.12/envs/myenv/lib/python3.11/site-packages (from jupyterlab->jupyter) (65.5.0)
Collecting beautifulsoup4 (from nbconvert->jupyter)
  Downloading beautifulsoup4-4.14.3-py3-none-any.whl.metadata (3.8 kB)
Collecting bleach!=5.0.0 (from bleach[css]!=5.0.0->nbconvert->jupyter)
  Downloading bleach-6.3.0-py3-none-any.whl.metadata (31 kB)
Collecting defusedxml (from nbconvert->jupyter)
  Downloading defusedxml-0.7.1-py2.py3-none-any.whl.metadata (32 kB)
Collecting jupyterlab-pygments (from nbconvert->jupyter)
  Downloading jupyterlab_pygments-0.3.0-py3-none-any.whl.metadata (4.4 kB)
Collecting markupsafe>=2.0 (from nbconvert->jupyter)
  Downloading markupsafe-3.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.7 kB)
Collecting mistune<4,>=2.0.3 (from nbconvert->jupyter)
  Downloading mistune-3.2.0-py3-none-any.whl.metadata (1.9 kB)
Collecting nbclient>=0.5.0 (from nbconvert->jupyter)
  Downloading nbclient-0.10.4-py3-none-any.whl.metadata (8.3 kB)
Collecting nbformat>=5.7 (from nbconvert->jupyter)
  Downloading nbformat-5.10.4-py3-none-any.whl.metadata (3.6 kB)
Collecting pandocfilters>=1.4.1 (from nbconvert->jupyter)
  Downloading pandocfilters-1.5.1-py2.py3-none-any.whl.metadata (9.0 kB)
Collecting webencodings (from bleach!=5.0.0->bleach[css]!=5.0.0->nbconvert->jupyter)
  Downloading webencodings-0.5.1-py2.py3-none-any.whl.metadata (2.1 kB)
Collecting tinycss2<1.5,>=1.1.0 (from bleach[css]!=5.0.0->nbconvert->jupyter)
  Downloading tinycss2-1.4.0-py3-none-any.whl.metadata (3.0 kB)
Collecting anyio (from httpx<1,>=0.25.0->jupyterlab->jupyter)
  Downloading anyio-4.12.1-py3-none-any.whl.metadata (4.3 kB)
Collecting certifi (from httpx<1,>=0.25.0->jupyterlab->jupyter)
  Downloading certifi-2026.1.4-py3-none-any.whl.metadata (2.5 kB)
Collecting httpcore==1.* (from httpx<1,>=0.25.0->jupyterlab->jupyter)
  Downloading httpcore-1.0.9-py3-none-any.whl.metadata (21 kB)
Collecting idna (from httpx<1,>=0.25.0->jupyterlab->jupyter)
  Downloading idna-3.11-py3-none-any.whl.metadata (8.4 kB)
Collecting h11>=0.16 (from httpcore==1.*->httpx<1,>=0.25.0->jupyterlab->jupyter)
  Downloading h11-0.16.0-py3-none-any.whl.metadata (8.3 kB)
Collecting decorator>=4.3.2 (from ipython>=7.23.1->ipykernel->jupyter)
  Downloading decorator-5.2.1-py3-none-any.whl.metadata (3.9 kB)
Collecting ipython-pygments-lexers>=1.0.0 (from ipython>=7.23.1->ipykernel->jupyter)
  Downloading ipython_pygments_lexers-1.1.1-py3-none-any.whl.metadata (1.1 kB)
Collecting jedi>=0.18.1 (from ipython>=7.23.1->ipykernel->jupyter)
  Downloading jedi-0.19.2-py2.py3-none-any.whl.metadata (22 kB)
Collecting pexpect>4.3 (from ipython>=7.23.1->ipykernel->jupyter)
  Downloading pexpect-4.9.0-py2.py3-none-any.whl.metadata (2.5 kB)
Collecting stack_data>=0.6.0 (from ipython>=7.23.1->ipykernel->jupyter)
  Downloading stack_data-0.6.3-py3-none-any.whl.metadata (18 kB)
Collecting typing_extensions>=4.6 (from ipython>=7.23.1->ipykernel->jupyter)
  Downloading typing_extensions-4.15.0-py3-none-any.whl.metadata (3.3 kB)
Collecting platformdirs>=2.5 (from jupyter-core!=5.0.*,>=4.12->ipykernel->jupyter)
  Downloading platformdirs-4.5.1-py3-none-any.whl.metadata (12 kB)
Collecting argon2-cffi>=21.1 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading argon2_cffi-25.1.0-py3-none-any.whl.metadata (4.1 kB)
Collecting jupyter-events>=0.11.0 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading jupyter_events-0.12.0-py3-none-any.whl.metadata (5.8 kB)
Collecting jupyter-server-terminals>=0.4.4 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading jupyter_server_terminals-0.5.4-py3-none-any.whl.metadata (5.9 kB)
Collecting overrides>=5.0 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading overrides-7.7.0-py3-none-any.whl.metadata (5.8 kB)
Collecting prometheus-client>=0.9 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading prometheus_client-0.24.1-py3-none-any.whl.metadata (2.1 kB)
Collecting send2trash>=1.8.2 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading send2trash-2.1.0-py3-none-any.whl.metadata (4.1 kB)
Collecting terminado>=0.8.3 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading terminado-0.18.1-py3-none-any.whl.metadata (5.8 kB)
Collecting websocket-client>=1.7 (from jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading websocket_client-1.9.0-py3-none-any.whl.metadata (8.3 kB)
Collecting babel>=2.10 (from jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading babel-2.18.0-py3-none-any.whl.metadata (2.2 kB)
Collecting json5>=0.9.0 (from jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading json5-0.13.0-py3-none-any.whl.metadata (36 kB)
Collecting jsonschema>=4.18.0 (from jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading jsonschema-4.26.0-py3-none-any.whl.metadata (7.6 kB)
Collecting requests>=2.31 (from jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading requests-2.32.5-py3-none-any.whl.metadata (4.9 kB)
Collecting fastjsonschema>=2.15 (from nbformat>=5.7->nbconvert->jupyter)
  Downloading fastjsonschema-2.21.2-py3-none-any.whl.metadata (2.3 kB)
Collecting wcwidth (from prompt-toolkit>=3.0.30->jupyter-console->jupyter)
  Downloading wcwidth-0.5.3-py3-none-any.whl.metadata (30 kB)
Collecting soupsieve>=1.6.1 (from beautifulsoup4->nbconvert->jupyter)
  Downloading soupsieve-2.8.3-py3-none-any.whl.metadata (4.6 kB)
Collecting argon2-cffi-bindings (from argon2-cffi>=21.1->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading argon2_cffi_bindings-25.1.0-cp39-abi3-manylinux_2_26_x86_64.manylinux_2_28_x86_64.whl.metadata (7.4 kB)
Collecting parso<0.9.0,>=0.8.4 (from jedi>=0.18.1->ipython>=7.23.1->ipykernel->jupyter)
  Downloading parso-0.8.5-py2.py3-none-any.whl.metadata (8.3 kB)
Collecting attrs>=22.2.0 (from jsonschema>=4.18.0->jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading attrs-25.4.0-py3-none-any.whl.metadata (10 kB)
Collecting jsonschema-specifications>=2023.03.6 (from jsonschema>=4.18.0->jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading jsonschema_specifications-2025.9.1-py3-none-any.whl.metadata (2.9 kB)
Collecting referencing>=0.28.4 (from jsonschema>=4.18.0->jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading referencing-0.37.0-py3-none-any.whl.metadata (2.8 kB)
Collecting rpds-py>=0.25.0 (from jsonschema>=4.18.0->jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading rpds_py-0.30.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.1 kB)
Collecting python-json-logger>=2.0.4 (from jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading python_json_logger-4.0.0-py3-none-any.whl.metadata (4.0 kB)
Collecting pyyaml>=5.3 (from jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading pyyaml-6.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.4 kB)
Collecting rfc3339-validator (from jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading rfc3339_validator-0.1.4-py2.py3-none-any.whl.metadata (1.5 kB)
Collecting rfc3986-validator>=0.1.1 (from jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading rfc3986_validator-0.1.1-py2.py3-none-any.whl.metadata (1.7 kB)
Collecting ptyprocess>=0.5 (from pexpect>4.3->ipython>=7.23.1->ipykernel->jupyter)
  Downloading ptyprocess-0.7.0-py2.py3-none-any.whl.metadata (1.3 kB)
Collecting charset_normalizer<4,>=2 (from requests>=2.31->jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading charset_normalizer-3.4.4-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (37 kB)
Collecting urllib3<3,>=1.21.1 (from requests>=2.31->jupyterlab-server<3,>=2.28.0->jupyterlab->jupyter)
  Downloading urllib3-2.6.3-py3-none-any.whl.metadata (6.9 kB)
Collecting executing>=1.2.0 (from stack_data>=0.6.0->ipython>=7.23.1->ipykernel->jupyter)
  Downloading executing-2.2.1-py2.py3-none-any.whl.metadata (8.9 kB)
Collecting asttokens>=2.1.0 (from stack_data>=0.6.0->ipython>=7.23.1->ipykernel->jupyter)
  Downloading asttokens-3.0.1-py3-none-any.whl.metadata (4.9 kB)
Collecting pure-eval (from stack_data>=0.6.0->ipython>=7.23.1->ipykernel->jupyter)
  Downloading pure_eval-0.2.3-py3-none-any.whl.metadata (6.3 kB)
Collecting fqdn (from jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading fqdn-1.5.1-py3-none-any.whl.metadata (1.4 kB)
Collecting isoduration (from jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading isoduration-20.11.0-py3-none-any.whl.metadata (5.7 kB)
Collecting jsonpointer>1.13 (from jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading jsonpointer-3.0.0-py2.py3-none-any.whl.metadata (2.3 kB)
Collecting rfc3987-syntax>=1.1.0 (from jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading rfc3987_syntax-1.1.0-py3-none-any.whl.metadata (7.7 kB)
Collecting uri-template (from jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading uri_template-1.3.0-py3-none-any.whl.metadata (8.8 kB)
Collecting webcolors>=24.6.0 (from jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading webcolors-25.10.0-py3-none-any.whl.metadata (2.2 kB)
Collecting cffi>=1.0.1 (from argon2-cffi-bindings->argon2-cffi>=21.1->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading cffi-2.0.0-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl.metadata (2.6 kB)
Collecting pycparser (from cffi>=1.0.1->argon2-cffi-bindings->argon2-cffi>=21.1->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading pycparser-3.0-py3-none-any.whl.metadata (8.2 kB)
Collecting lark>=1.2.2 (from rfc3987-syntax>=1.1.0->jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading lark-1.3.1-py3-none-any.whl.metadata (1.8 kB)
Collecting arrow>=0.15.0 (from isoduration->jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading arrow-1.4.0-py3-none-any.whl.metadata (7.7 kB)
Collecting tzdata (from arrow>=0.15.0->isoduration->jsonschema[format-nongpl]>=4.18.0->jupyter-events>=0.11.0->jupyter-server<3,>=2.4.0->jupyterlab->jupyter)
  Downloading tzdata-2025.3-py2.py3-none-any.whl.metadata (1.4 kB)
Downloading pandas-3.0.0-cp311-cp311-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl (11.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 11.2/11.2 MB 1.2 MB/s eta 0:00:00
Downloading matplotlib-3.10.8-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (8.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 8.7/8.7 MB 1.5 MB/s eta 0:00:00
Downloading seaborn-0.13.2-py3-none-any.whl (294 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 294.9/294.9 kB 789.5 kB/s eta 0:00:00
Downloading plotly-6.5.2-py3-none-any.whl (9.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 9.9/9.9 MB 1.7 MB/s eta 0:00:00
Downloading jupyter-1.1.1-py2.py3-none-any.whl (2.7 kB)
Downloading contourpy-1.3.3-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl (355 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 355.2/355.2 kB 1.1 MB/s eta 0:00:00
Downloading cycler-0.12.1-py3-none-any.whl (8.3 kB)
Downloading fonttools-4.61.1-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (5.0 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 5.0/5.0 MB 2.8 MB/s eta 0:00:00
Downloading kiwisolver-1.4.9-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (1.4 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.4/1.4 MB 2.2 MB/s eta 0:00:00
Downloading narwhals-2.16.0-py3-none-any.whl (443 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 444.0/444.0 kB 2.2 MB/s eta 0:00:00
Downloading numpy-2.4.2-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl (16.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 16.9/16.9 MB 5.5 MB/s eta 0:00:00
Downloading packaging-26.0-py3-none-any.whl (74 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 74.4/74.4 kB 750.4 kB/s eta 0:00:00
Downloading pillow-12.1.0-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl (7.0 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.0/7.0 MB 6.1 MB/s eta 0:00:00
Downloading pyparsing-3.3.2-py3-none-any.whl (122 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 122.8/122.8 kB 5.3 MB/s eta 0:00:00
Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl (229 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.9/229.9 kB 1.7 MB/s eta 0:00:00
Downloading ipykernel-7.1.0-py3-none-any.whl (117 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 118.0/118.0 kB 1.0 MB/s eta 0:00:00
Downloading ipywidgets-8.1.8-py3-none-any.whl (139 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 139.8/139.8 kB 1.3 MB/s eta 0:00:00
Downloading jupyter_console-6.6.3-py3-none-any.whl (24 kB)
Downloading jupyterlab-4.5.3-py3-none-any.whl (12.4 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.4/12.4 MB 6.3 MB/s eta 0:00:00
Downloading nbconvert-7.17.0-py3-none-any.whl (261 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 261.5/261.5 kB 3.4 MB/s eta 0:00:00
Downloading notebook-7.5.3-py3-none-any.whl (14.5 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 14.5/14.5 MB 5.5 MB/s eta 0:00:00
Downloading async_lru-2.1.0-py3-none-any.whl (6.9 kB)
Downloading bleach-6.3.0-py3-none-any.whl (164 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 164.4/164.4 kB 3.1 MB/s eta 0:00:00
Downloading comm-0.2.3-py3-none-any.whl (7.3 kB)
Downloading debugpy-1.8.20-cp311-cp311-manylinux_2_34_x86_64.whl (3.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.2/3.2 MB 7.9 MB/s eta 0:00:00
Downloading httpx-0.28.1-py3-none-any.whl (73 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 73.5/73.5 kB 2.5 MB/s eta 0:00:00
Downloading httpcore-1.0.9-py3-none-any.whl (78 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.8/78.8 kB 1.8 MB/s eta 0:00:00
Downloading ipython-9.10.0-py3-none-any.whl (622 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 622.8/622.8 kB 7.6 MB/s eta 0:00:00
Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 kB 1.0 MB/s eta 0:00:00
Downloading jupyter_client-8.8.0-py3-none-any.whl (107 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 107.4/107.4 kB 2.5 MB/s eta 0:00:00
Downloading jupyter_core-5.9.1-py3-none-any.whl (29 kB)
Downloading jupyter_lsp-2.3.0-py3-none-any.whl (76 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 76.7/76.7 kB 1.7 MB/s eta 0:00:00
Downloading jupyter_server-2.17.0-py3-none-any.whl (388 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 388.2/388.2 kB 1.4 MB/s eta 0:00:00
Downloading jupyterlab_server-2.28.0-py3-none-any.whl (59 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 59.8/59.8 kB 374.1 kB/s eta 0:00:00
Downloading jupyterlab_widgets-3.0.16-py3-none-any.whl (914 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 914.9/914.9 kB 2.2 MB/s eta 0:00:00
Downloading markupsafe-3.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (22 kB)
Downloading matplotlib_inline-0.2.1-py3-none-any.whl (9.5 kB)
Downloading mistune-3.2.0-py3-none-any.whl (53 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 53.6/53.6 kB 1.9 MB/s eta 0:00:00
Downloading nbclient-0.10.4-py3-none-any.whl (25 kB)
Downloading nbformat-5.10.4-py3-none-any.whl (78 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.5/78.5 kB 1.8 MB/s eta 0:00:00
Downloading nest_asyncio-1.6.0-py3-none-any.whl (5.2 kB)
Downloading notebook_shim-0.2.4-py3-none-any.whl (13 kB)
Downloading pandocfilters-1.5.1-py2.py3-none-any.whl (8.7 kB)
Downloading prompt_toolkit-3.0.52-py3-none-any.whl (391 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 391.4/391.4 kB 1.5 MB/s eta 0:00:00
Downloading psutil-7.2.2-cp36-abi3-manylinux2010_x86_64.manylinux_2_12_x86_64.manylinux_2_28_x86_64.whl (155 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 155.6/155.6 kB 964.7 kB/s eta 0:00:00
Downloading pygments-2.19.2-py3-none-any.whl (1.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 5.7 MB/s eta 0:00:00
Downloading pyzmq-27.1.0-cp311-cp311-manylinux_2_26_x86_64.manylinux_2_28_x86_64.whl (857 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 857.0/857.0 kB 5.3 MB/s eta 0:00:00
Downloading six-1.17.0-py2.py3-none-any.whl (11 kB)
Downloading tornado-6.5.4-cp39-abi3-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (445 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 445.3/445.3 kB 4.5 MB/s eta 0:00:00
Downloading traitlets-5.14.3-py3-none-any.whl (85 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 85.4/85.4 kB 3.2 MB/s eta 0:00:00
Downloading widgetsnbextension-4.0.15-py3-none-any.whl (2.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.2/2.2 MB 5.9 MB/s eta 0:00:00
Downloading beautifulsoup4-4.14.3-py3-none-any.whl (107 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 107.7/107.7 kB 1.8 MB/s eta 0:00:00
Downloading defusedxml-0.7.1-py2.py3-none-any.whl (25 kB)
Downloading jupyterlab_pygments-0.3.0-py3-none-any.whl (15 kB)
Downloading anyio-4.12.1-py3-none-any.whl (113 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 113.6/113.6 kB 681.4 kB/s eta 0:00:00
Downloading argon2_cffi-25.1.0-py3-none-any.whl (14 kB)
Downloading babel-2.18.0-py3-none-any.whl (10.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 10.2/10.2 MB 5.0 MB/s eta 0:00:00
Downloading decorator-5.2.1-py3-none-any.whl (9.2 kB)
Downloading fastjsonschema-2.21.2-py3-none-any.whl (24 kB)
Downloading idna-3.11-py3-none-any.whl (71 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 71.0/71.0 kB 2.0 MB/s eta 0:00:00
Downloading ipython_pygments_lexers-1.1.1-py3-none-any.whl (8.1 kB)
Downloading jedi-0.19.2-py2.py3-none-any.whl (1.6 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.6/1.6 MB 6.9 MB/s eta 0:00:00
Downloading json5-0.13.0-py3-none-any.whl (36 kB)
Downloading jsonschema-4.26.0-py3-none-any.whl (90 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 90.6/90.6 kB 3.6 MB/s eta 0:00:00
Downloading jupyter_events-0.12.0-py3-none-any.whl (19 kB)
Downloading jupyter_server_terminals-0.5.4-py3-none-any.whl (13 kB)
Downloading overrides-7.7.0-py3-none-any.whl (17 kB)
Downloading pexpect-4.9.0-py2.py3-none-any.whl (63 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 63.8/63.8 kB 1.6 MB/s eta 0:00:00
Downloading platformdirs-4.5.1-py3-none-any.whl (18 kB)
Downloading prometheus_client-0.24.1-py3-none-any.whl (64 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 64.1/64.1 kB 1.4 MB/s eta 0:00:00
Downloading requests-2.32.5-py3-none-any.whl (64 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 64.7/64.7 kB 1.6 MB/s eta 0:00:00
Downloading certifi-2026.1.4-py3-none-any.whl (152 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 152.9/152.9 kB 975.5 kB/s eta 0:00:00
Downloading send2trash-2.1.0-py3-none-any.whl (17 kB)
Downloading soupsieve-2.8.3-py3-none-any.whl (37 kB)
Downloading stack_data-0.6.3-py3-none-any.whl (24 kB)
Downloading terminado-0.18.1-py3-none-any.whl (14 kB)
Downloading tinycss2-1.4.0-py3-none-any.whl (26 kB)
Downloading typing_extensions-4.15.0-py3-none-any.whl (44 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 44.6/44.6 kB 248.6 kB/s eta 0:00:00
Downloading webencodings-0.5.1-py2.py3-none-any.whl (11 kB)
Downloading websocket_client-1.9.0-py3-none-any.whl (82 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 82.6/82.6 kB 479.3 kB/s eta 0:00:00
Downloading wcwidth-0.5.3-py3-none-any.whl (92 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 93.0/93.0 kB 3.3 MB/s eta 0:00:00
Downloading asttokens-3.0.1-py3-none-any.whl (27 kB)
Downloading attrs-25.4.0-py3-none-any.whl (67 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 67.6/67.6 kB 1.5 MB/s eta 0:00:00
Downloading charset_normalizer-3.4.4-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (151 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 151.6/151.6 kB 3.5 MB/s eta 0:00:00
Downloading executing-2.2.1-py2.py3-none-any.whl (28 kB)
Downloading h11-0.16.0-py3-none-any.whl (37 kB)
Downloading jsonschema_specifications-2025.9.1-py3-none-any.whl (18 kB)
Downloading parso-0.8.5-py2.py3-none-any.whl (106 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 106.7/106.7 kB 2.3 MB/s eta 0:00:00
Downloading ptyprocess-0.7.0-py2.py3-none-any.whl (13 kB)
Downloading python_json_logger-4.0.0-py3-none-any.whl (15 kB)
Downloading pyyaml-6.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (806 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 806.6/806.6 kB 6.4 MB/s eta 0:00:00
Downloading referencing-0.37.0-py3-none-any.whl (26 kB)
Downloading rfc3986_validator-0.1.1-py2.py3-none-any.whl (4.2 kB)
Downloading rpds_py-0.30.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (390 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 390.8/390.8 kB 5.8 MB/s eta 0:00:00
Downloading urllib3-2.6.3-py3-none-any.whl (131 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 131.6/131.6 kB 814.6 kB/s eta 0:00:00
Downloading argon2_cffi_bindings-25.1.0-cp39-abi3-manylinux_2_26_x86_64.manylinux_2_28_x86_64.whl (87 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 87.1/87.1 kB 2.4 MB/s eta 0:00:00
Downloading pure_eval-0.2.3-py3-none-any.whl (11 kB)
Downloading rfc3339_validator-0.1.4-py2.py3-none-any.whl (3.5 kB)
Downloading cffi-2.0.0-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (215 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 215.6/215.6 kB 3.5 MB/s eta 0:00:00
Downloading jsonpointer-3.0.0-py2.py3-none-any.whl (7.6 kB)
Downloading rfc3987_syntax-1.1.0-py3-none-any.whl (8.0 kB)
Downloading webcolors-25.10.0-py3-none-any.whl (14 kB)
Downloading fqdn-1.5.1-py3-none-any.whl (9.1 kB)
Downloading isoduration-20.11.0-py3-none-any.whl (11 kB)
Downloading uri_template-1.3.0-py3-none-any.whl (11 kB)
Downloading arrow-1.4.0-py3-none-any.whl (68 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 68.8/68.8 kB 1.5 MB/s eta 0:00:00
Downloading lark-1.3.1-py3-none-any.whl (113 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 113.2/113.2 kB 2.1 MB/s eta 0:00:00
Downloading pycparser-3.0-py3-none-any.whl (48 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 48.2/48.2 kB 1.2 MB/s eta 0:00:00
Downloading tzdata-2025.3-py2.py3-none-any.whl (348 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 348.5/348.5 kB 5.3 MB/s eta 0:00:00
Installing collected packages: webencodings, pure-eval, ptyprocess, fastjsonschema, widgetsnbextension, websocket-client, webcolors, wcwidth, urllib3, uri-template, tzdata, typing_extensions, traitlets, tornado, tinycss2, soupsieve, six, send2trash, rpds-py, rfc3986-validator, pyzmq, pyyaml, python-json-logger, pyparsing, pygments, pycparser, psutil, prometheus-client, platformdirs, pillow, pexpect, parso, pandocfilters, packaging, overrides, numpy, nest-asyncio, narwhals, mistune, markupsafe, lark, kiwisolver, jupyterlab_widgets, jupyterlab-pygments, jsonpointer, json5, idna, h11, fqdn, fonttools, executing, defusedxml, decorator, debugpy, cycler, comm, charset_normalizer, certifi, bleach, babel, attrs, async-lru, asttokens, terminado, stack_data, rfc3987-syntax, rfc3339-validator, requests, referencing, python-dateutil, prompt-toolkit, plotly, matplotlib-inline, jupyter-core, jinja2, jedi, ipython-pygments-lexers, httpcore, contourpy, cffi, beautifulsoup4, anyio, pandas, matplotlib, jupyter-server-terminals, jupyter-client, jsonschema-specifications, ipython, httpx, arrow, argon2-cffi-bindings, seaborn, jsonschema, isoduration, ipywidgets, ipykernel, argon2-cffi, nbformat, jupyter-console, nbclient, jupyter-events, nbconvert, jupyter-server, notebook-shim, jupyterlab-server, jupyter-lsp, jupyterlab, notebook, jupyter
Successfully installed anyio-4.12.1 argon2-cffi-25.1.0 argon2-cffi-bindings-25.1.0 arrow-1.4.0 asttokens-3.0.1 async-lru-2.1.0 attrs-25.4.0 babel-2.18.0 beautifulsoup4-4.14.3 bleach-6.3.0 certifi-2026.1.4 cffi-2.0.0 charset_normalizer-3.4.4 comm-0.2.3 contourpy-1.3.3 cycler-0.12.1 debugpy-1.8.20 decorator-5.2.1 defusedxml-0.7.1 executing-2.2.1 fastjsonschema-2.21.2 fonttools-4.61.1 fqdn-1.5.1 h11-0.16.0 httpcore-1.0.9 httpx-0.28.1 idna-3.11 ipykernel-7.1.0 ipython-9.10.0 ipython-pygments-lexers-1.1.1 ipywidgets-8.1.8 isoduration-20.11.0 jedi-0.19.2 jinja2-3.1.6 json5-0.13.0 jsonpointer-3.0.0 jsonschema-4.26.0 jsonschema-specifications-2025.9.1 jupyter-1.1.1 jupyter-client-8.8.0 jupyter-console-6.6.3 jupyter-core-5.9.1 jupyter-events-0.12.0 jupyter-lsp-2.3.0 jupyter-server-2.17.0 jupyter-server-terminals-0.5.4 jupyterlab-4.5.3 jupyterlab-pygments-0.3.0 jupyterlab-server-2.28.0 jupyterlab_widgets-3.0.16 kiwisolver-1.4.9 lark-1.3.1 markupsafe-3.0.3 matplotlib-3.10.8 matplotlib-inline-0.2.1 mistune-3.2.0 narwhals-2.16.0 nbclient-0.10.4 nbconvert-7.17.0 nbformat-5.10.4 nest-asyncio-1.6.0 notebook-7.5.3 notebook-shim-0.2.4 numpy-2.4.2 overrides-7.7.0 packaging-26.0 pandas-3.0.0 pandocfilters-1.5.1 parso-0.8.5 pexpect-4.9.0 pillow-12.1.0 platformdirs-4.5.1 plotly-6.5.2 prometheus-client-0.24.1 prompt-toolkit-3.0.52 psutil-7.2.2 ptyprocess-0.7.0 pure-eval-0.2.3 pycparser-3.0 pygments-2.19.2 pyparsing-3.3.2 python-dateutil-2.9.0.post0 python-json-logger-4.0.0 pyyaml-6.0.3 pyzmq-27.1.0 referencing-0.37.0 requests-2.32.5 rfc3339-validator-0.1.4 rfc3986-validator-0.1.1 rfc3987-syntax-1.1.0 rpds-py-0.30.0 seaborn-0.13.2 send2trash-2.1.0 six-1.17.0 soupsieve-2.8.3 stack_data-0.6.3 terminado-0.18.1 tinycss2-1.4.0 tornado-6.5.4 traitlets-5.14.3 typing_extensions-4.15.0 tzdata-2025.3 uri-template-1.3.0 urllib3-2.6.3 wcwidth-0.5.3 webcolors-25.10.0 webencodings-0.5.1 websocket-client-1.9.0 widgetsnbextension-4.0.15

[notice] A new release of pip is available: 24.0 -> 26.0.1
[notice] To update, run: python -m pip install --upgrade pip
(myenv) root@gabes:~#

```