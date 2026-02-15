<p align="center">
  <img src="https://brew.sh/assets/img/homebrew.svg" width="64" alt="Homebrew">
</p>

<h1 align="center">homebrew-tools</h1>

<p align="center">
  <strong>CLI tools for document review, scientific research, clinical data, and macOS automation.</strong><br>
  Built for humans and AI agents. One tap, seven tools.
</p>

<p align="center">
  <a href="#install">Install</a> •
  <a href="#tools">Tools</a> •
  <a href="#document-office-suite">Office Suite</a> •
  <a href="#research--clinical">Research</a> •
  <a href="#macos">macOS</a>
</p>

---

## Install

```bash
brew tap henrybloomingdale/tools
```

Then install any tool:

```bash
brew install pubmed-cli        # PubMed search & literature synthesis
brew install docx-review       # Word tracked changes & comments
brew install pptx-review       # PowerPoint editing & comments
brew install xlsx-review       # Excel editing & comments
brew install pdf-create        # PDF generation from JSON
brew install phi-cleaner       # Clinical text de-identification
brew install mac-control       # macOS GUI automation
```

Or install everything:

```bash
brew install pubmed-cli docx-review pptx-review xlsx-review pdf-create phi-cleaner mac-control
```

---

## Tools

### Document Office Suite

Programmatic document editing via JSON manifests. Read, edit, comment — all from the command line. Built with .NET 8 and Open XML SDK. Cross-platform (macOS, Linux). Designed so AI agents can review and modify Office documents without ever opening Word, PowerPoint, or Excel.

<table>
<tr>
<td width="120" align="center">
<br>
<strong>📝</strong><br>
<a href="https://github.com/henrybloomingdale/docx-review"><strong>docx-review</strong></a><br>
<code>v1.1.0</code>
</td>
<td>

**Add tracked changes and comments to Word documents.**

```bash
# Read existing review state
docx-review paper.docx --read --json

# Apply tracked changes from a JSON manifest
docx-review paper.docx edits.json -o paper_reviewed.docx

# Pipe from stdin
cat edits.json | docx-review paper.docx --author "Reviewer 1"

# Dry run (validate without modifying)
docx-review paper.docx edits.json --dry-run
```

Insert, delete, replace text with full revision tracking. Add margin comments anchored to specific text. All changes appear in Word's Review pane exactly as if a human reviewer made them.

</td>
</tr>

<tr>
<td width="120" align="center">
<br>
<strong>📊</strong><br>
<a href="https://github.com/henrybloomingdale/pptx-review"><strong>pptx-review</strong></a><br>
<code>v1.0.1</code>
</td>
<td>

**Edit and comment on PowerPoint presentations.**

```bash
# Read slide contents
pptx-review deck.pptx --read --json

# Apply edits from manifest
pptx-review deck.pptx edits.json -o deck_edited.pptx

# Validate changes without writing
pptx-review deck.pptx edits.json --dry-run
```

Edit text, add speaker notes, insert comments — all driven by JSON. Review presentations programmatically without opening PowerPoint.

</td>
</tr>

<tr>
<td width="120" align="center">
<br>
<strong>📈</strong><br>
<a href="https://github.com/henrybloomingdale/xlsx-review"><strong>xlsx-review</strong></a><br>
<code>v1.0.0</code>
</td>
<td>

**Edit Excel spreadsheets with highlighted changes and comments.**

```bash
# Read spreadsheet contents
xlsx-review data.xlsx --read --json

# Apply edits with change highlighting
xlsx-review data.xlsx edits.json -o data_edited.xlsx

# Add comments to cells
cat edits.json | xlsx-review data.xlsx --author "Data Review"
```

Cell edits, formula updates, comments, formatting — highlight changes so reviewers can see exactly what was modified.

</td>
</tr>

<tr>
<td width="120" align="center">
<br>
<strong>📄</strong><br>
<a href="https://github.com/henrybloomingdale/pdf-create"><strong>pdf-create</strong></a><br>
<code>v1.0.0</code>
</td>
<td>

**Generate PDFs from JSON manifests.**

```bash
# Generate a PDF from a manifest
pdf-create report.json -o report.pdf

# Pipe from stdin
cat manifest.json | pdf-create -o output.pdf --json
```

Describe your document layout in JSON — headings, paragraphs, tables, images, page breaks — and get a pixel-perfect PDF. Built on QuestPDF. Ideal for automated report generation.

</td>
</tr>
</table>

---

### Research & Clinical

<table>
<tr>
<td width="120" align="center">
<br>
<strong>🔬</strong><br>
<a href="https://github.com/henrybloomingdale/pubmed-cli"><strong>pubmed-cli</strong></a><br>
<code>v0.5.3</code>
</td>
<td>

**PubMed from your terminal — search, fetch, cite, traverse.**

```bash
# Search PubMed
pubmed search "fragile X syndrome EEG" --max 10

# Fetch full article details
pubmed fetch 39906041 --json

# Citation traversal
pubmed cited-by 39906041          # Who cited this?
pubmed references 39906041        # What does this cite?
pubmed related 39906041           # Similar articles

# Literature synthesis with APA citations
pubmed synth "FMRP and synaptic plasticity"

# Interactive wizard
pubmed wizard

# Answer biomedical questions with adaptive retrieval
pubmed qa "Does CBD improve seizures in Dravet syndrome?"
```

Zero dependencies. Structured JSON output. Agent-ready. Includes `pubmed synth` for AI-powered literature synthesis with proper APA citations and RIS export. Built for both terminal power users and AI coding agents.

</td>
</tr>

<tr>
<td width="120" align="center">
<br>
<strong>🏥</strong><br>
<a href="https://github.com/henrybloomingdale/phi-cleaner"><strong>phi-cleaner</strong></a><br>
<code>v0.1.0</code>
</td>
<td>

**De-identify clinical text using BERT-based NER models.**

```bash
# De-identify inline text
phi-clean "Patient John Smith was seen on 03/15/2024 at Mayo Clinic."
# → Patient [PATIENT] was seen on [DATE] at [HOSPITAL].

# Process a file
phi-clean -f clinical_note.txt -o cleaned.txt

# Batch process a directory
phi-clean -d ./notes/ -O ./cleaned/

# Detection only (no replacement)
phi-clean --detect "Dr. Chen ordered labs for MRN 12345678"

# Choose replacement style
phi-clean --redact "..."       # [REDACTED]
phi-clean --generic "..."      # [PATIENT], [DATE], etc.
phi-clean --underscores "..."  # _____
```

Detects patient names, provider names, dates, hospitals, IDs/MRNs, phone numbers, and vendor names. Uses StanfordAIMI/stanford-deidentifier-base (BERT NER). Runs locally — no data leaves your machine.

</td>
</tr>
</table>

---

### macOS

<table>
<tr>
<td width="120" align="center">
<br>
<strong>🖱️</strong><br>
<a href="https://github.com/henrybloomingdale/mac-control"><strong>mac-control</strong></a><br>
<code>v0.1.0</code>
</td>
<td>

**macOS GUI automation using the Accessibility API.**

```bash
# List clickable elements in an app
mac-ui list "Finder"

# Click by element index or coordinates
mac-ui click 5
mac-control click 100 200

# Type text and press keys
mac-control type "Hello, world"
mac-control key "cmd+space"

# Take a screenshot
mac-control screenshot
```

Two commands: `mac-control` for direct mouse/keyboard input and `mac-ui` for Accessibility-based element discovery and interaction. Requires macOS Accessibility permissions.

</td>
</tr>
</table>

---

## Platform Support

| Tool | macOS (ARM) | macOS (Intel) | Linux (ARM) | Linux (x86) |
|------|:-----------:|:-------------:|:-----------:|:------------:|
| pubmed-cli | ✅ | ✅ | — | — |
| docx-review | ✅ | ✅ | ✅ | ✅ |
| pptx-review | ✅ | ✅ | ✅ | ✅ |
| xlsx-review | ✅ | ✅ | ✅ | ✅ |
| pdf-create | ✅ | ✅ | ✅ | ✅ |
| phi-cleaner | ✅ | ✅ | ✅ | ✅ |
| mac-control | ✅ | ✅ | — | — |

## License

All tools are MIT licensed. See individual repositories for details.
