#!/bin/bash

# Function to print headers
print_header() {
    echo "=============================================="
    echo "$1"
    echo "=============================================="
}

# Pull the latest changes
print_header "Updating the Local Repository"
git pull origin $(git rev-parse --abbrev-ref HEAD)

# Analyze Issues using GitHub CLI
print_header "Fetching Open Issues"
gh issue list --state open --limit 100 > open_issues.txt
open_count=$(wc -l < open_issues.txt)
echo "Number of Open Issues: $open_count"

print_header "Fetching Closed Issues"
gh issue list --state closed --limit 100 > closed_issues.txt
closed_count=$(wc -l < closed_issues.txt)
echo "Number of Closed Issues: $closed_count"

# Analyze Labels
print_header "Analyzing Labels in Open Issues"
gh issue list --state open --json labels | jq '.[].labels[].name' | sort | uniq -c > label_analysis.txt
cat label_analysis.txt

# Generate a Summary Report
summary_file="project_summary_report.txt"
print_header "Generating Project Summary Report"
echo "Project Summary Report - $(date)" > $summary_file
echo "==============================================" >> $summary_file
echo "Open Issues: $open_count" >> $summary_file
echo "Closed Issues: $closed_count" >> $summary_file
echo "Labels Analysis:" >> $summary_file
cat label_analysis.txt >> $summary_file
echo "==============================================" >> $summary_file

# Suggest Next Steps
print_header "Suggestions for Next Steps"
echo "Analyzing open issues for recommendations..."

if grep -q "bug" label_analysis.txt; then
    echo "🚧 Focus on resolving 'bug' labeled issues to stabilize the project."
fi

if grep -q "feature" label_analysis.txt; then
    echo "✨ Implement 'feature' labeled issues to enhance functionality."
fi

if grep -q "documentation" label_analysis.txt; then
    echo "📚 Update documentation for labeled issues to improve usability."
fi

echo "✅ All suggestions are based on the labels analyzed."

# Output Report Path
echo "Summary report generated at: $summary_file"
