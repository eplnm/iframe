
## 00. Image

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

## 01. YouTube

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

## 02. PDF

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

## 03. API

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

## 04. Tree

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

## 05. Danger!

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

## 06. LaTeX

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

# 06. Favicon

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
