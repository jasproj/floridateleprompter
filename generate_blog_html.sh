#!/bin/bash

# Generate blog.html with all markdown files in correct paths

cat > blog.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teleprompter Blog | Tips, Guides & Industry Insights | Florida Teleprompter</title>
    <meta name="description" content="Expert teleprompter tips, guides, and industry insights. Learn how to read a teleprompter, choose equipment, and master teleprompting.">
    <link rel="canonical" href="https://floridateleprompter.com/blog/">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        .header {
            background: #fff;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 { font-size: 2.5rem; color: #1a1a1a; margin-bottom: 0.5rem; }
        .subtitle { color: #666; font-size: 1.1rem; }
        .content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .articles {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .article {
            background: #fff;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .article:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        .article a {
            display: block;
            color: #1a1a1a;
            text-decoration: none;
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .article a:hover { color: #d4a03a; }
        .meta { color: #999; font-size: 0.9rem; }
        .category { display: inline-block; background: #f0f0f0; padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.8rem; color: #666; margin-bottom: 0.5rem; }
        h2 { font-size: 1.8rem; margin: 2rem 0 1rem 0; border-bottom: 2px solid #d4a03a; padding-bottom: 0.5rem; }
    </style>
</head>
<body>
<div class="header">
    <h1>📚 Teleprompter Blog</h1>
    <p class="subtitle">Expert guides, tips & industry insights for professional teleprompter rental & services</p>
</div>
<div class="content">
HTMLEOF

# Get all markdown files and generate article entries
cd /home/openclaw/repos/floridateleprompter

# Service Guides
echo '<h2>Service Guides</h2><div class="articles">' >> blog.html
for file in blog/0[1-9]-*.md blog/1[0-5]-*.md; do
    [ -f "$file" ] && {
        basename=$(basename "$file" .md)
        title=$(head -1 "$file" | sed 's/^# //')
        echo "<div class=\"article\"><a href=\"/blog/$basename.md\">$title</a><p class=\"meta\">Read More →</p></div>" >> blog.html
    }
done
echo '</div>' >> blog.html

# National Cities
echo '<h2>National City Guides (28+ Markets)</h2><div class="articles">' >> blog.html
for file in blog/1[8-9]-*.md blog/[2-6][0-9]-*.md; do
    [ -f "$file" ] && {
        # Skip industry guides
        basename=$(basename "$file" .md)
        if [[ ! "$basename" =~ ^(26|27|28|29|30|41|42|43|44|45|46|47|48|49|50) ]]; then
            title=$(head -1 "$file" | sed 's/^# //')
            echo "<div class=\"article\"><a href=\"/blog/$basename.md\">$title</a><p class=\"meta\">Read More →</p></div>" >> blog.html
        fi
    }
done
echo '</div>' >> blog.html

# Industry Guides
echo '<h2>Industry Specialization Guides</h2><div class="articles">' >> blog.html
for file in blog/{26,27,28,29,30,41,42,43,44,45,46,47,48,49,50}-*.md; do
    [ -f "$file" ] && {
        basename=$(basename "$file" .md)
        title=$(head -1 "$file" | sed 's/^# //')
        echo "<div class=\"article\"><a href=\"/blog/$basename.md\">$title</a><p class=\"meta\">Read More →</p></div>" >> blog.html
    }
done
echo '</div>' >> blog.html

# Add footer and close
cat >> blog.html << 'FOOTEREOF'
</div>
<div style="text-align: center; padding: 2rem; color: #999; font-size: 0.9rem;">
    <p>&copy; 2026 Florida Teleprompter. All Rights Reserved.</p>
    <p><a href="/" style="color: #d4a03a; text-decoration: none;">Back to Home</a></p>
</div>
</body>
</html>
FOOTEREOF

echo "✅ Generated corrected blog.html with correct paths"
