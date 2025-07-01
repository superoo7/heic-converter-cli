# 🖼️ heic-converter-cli

> Fast CLI tool to convert HEIC files to JPG, PNG, WebP and other formats

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Shell-Bash/Zsh-green.svg)](https://www.gnu.org/software/bash/)

## 🤔 The Problem

As an iPhone user, all my photos are saved in HEIC format by default. While HEIC offers great compression, I constantly need to convert them to PNG/JPG for:
- Uploading to websites that don't support HEIC
- Sharing with friends on Android/Windows
- Using in projects and presentations

After dealing with this conversion hassle repeatedly, I created this quick script on top of ImageMagick to automate the process.

Convert your iPhone HEIC photos to universal formats with a single command. Perfect for batch processing.

## 🚀 Quick Start

```bash
# Convert single file to JPG (default)
heicto IMG_001.HEIC

# Convert to PNG
heicto png IMG_001.HEIC

# Convert all HEIC files in current directory
heicto jpg

# Batch convert directory
heicto png ~/Pictures/iPhone_Photos/
```

## 📦 Installation

### Prerequisites
Install ImageMagick first:
```bash
# macOS
brew install imagemagick

# Ubuntu/Debian  
sudo apt install imagemagick

# Windows - Download from imagemagick.org
```

### Install heicto

```bash
# Download and install
curl -O https://raw.githubusercontent.com/superoo7/heic-converter-cli/main/heicto.bash
chmod +x heicto.bash
sudo mv heicto.bash /usr/local/bin/heicto

# Test installation
heicto --version
```

**Alternative (user-only install):**
```bash
mkdir -p ~/.local/bin
curl -o ~/.local/bin/heicto https://raw.githubusercontent.com/superoo7/heic-converter-cli/main/heicto.bash
chmod +x ~/.local/bin/heicto
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 📖 Usage

### Basic Commands
```bash
heicto [format] [file/directory]
```

### Examples
```bash
# Single file conversion
heicto IMG_001.HEIC          # Convert to JPG (default)
heicto png photo.HEIC        # Convert to PNG
heicto webp image.HEIC       # Convert to WebP

# Batch conversion
heicto jpg                   # Convert all HEIC in current directory
heicto png ~/Downloads/      # Convert all HEIC in Downloads folder
```

### Supported Formats
`jpg` (default) • `png` • `webp` • `bmp` • `tiff` • `gif`

## 🔧 Troubleshooting

**"magick: command not found"** - Install ImageMagick  
**"heicto: command not found"** - Add to PATH or use full path  
**"Permission denied"** - Run `chmod +x heicto`

## 💡 Why Convert HEIC?

HEIC is Apple's efficient format but has compatibility issues:
- Many websites don't accept HEIC uploads
- Older software can't open HEIC files
- Sharing with non-Apple users is problematic

This tool converts to universally supported formats.

## 🤝 Contributing

Found a bug? Have a suggestion? [Open an issue](https://github.com/superoo7/heic-converter-cli/issues) or submit a PR!

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

⭐ **Star this repo if it helped you!** Made with ❤️ for everyone tired of HEIC compatibility issues.
