#!/bin/bash

# heicto - HEIC to image format converter
# Requires ImageMagick

set -e

VERSION="1.0.0"
DEFAULT_FORMAT="jpg"

usage() {
    cat << EOF
heicto - Convert HEIC files to other image formats

Usage:
    heicto [format] [file/directory]
    heicto [file]

Examples:
    heicto jpg ./photo.heic          # Convert single file to JPG
    heicto png ./photo.heic          # Convert single file to PNG
    heicto ./photo.heic              # Convert single file to JPG (default)
    heicto jpg                       # Convert all HEIC files in current directory
    heicto png /path/to/photos/      # Convert all HEIC files in directory

Supported formats: jpg, jpeg, png, webp, bmp, tiff, gif

Options:
    -h, --help     Show this help message
    -v, --version  Show version
EOF
}

check_imagemagick() {
    if ! command -v magick &> /dev/null; then
        echo "Error: ImageMagick is not installed or not accessible."
        echo "Please install ImageMagick from: https://www.imagemagick.org/"
        exit 1
    fi
}

convert_heic() {
    local input_file="$1"
    local output_format="$2"
    
    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found."
        return 1
    fi
    
    # Convert filename to lowercase for checking (compatible with older bash)
    input_file_lower=$(echo "$input_file" | tr '[:upper:]' '[:lower:]')
    if [[ ! "$input_file_lower" =~ \.heic$ ]]; then
        echo "Error: '$input_file' is not a HEIC file."
        return 1
    fi
    
    local output_file="${input_file%.*}.${output_format}"
    
    echo "Converting $input_file to $output_file..."
    
    if magick "$input_file" "$output_file" 2>/dev/null; then
        echo "Successfully converted to $output_file"
        return 0
    else
        echo "Error converting $input_file"
        return 1
    fi
}

batch_convert() {
    local directory="$1"
    local output_format="$2"
    
    if [[ ! -d "$directory" ]]; then
        echo "Error: Directory '$directory' not found."
        return 1
    fi
    
    local heic_files=()
    while IFS= read -r -d '' file; do
        heic_files+=("$file")
    done < <(find "$directory" -maxdepth 1 -iname "*.heic" -print0)
    
    if [[ ${#heic_files[@]} -eq 0 ]]; then
        echo "No HEIC files found in '$directory'"
        return 0
    fi
    
    echo "Found ${#heic_files[@]} HEIC file(s) in '$directory'"
    
    local success_count=0
    for file in "${heic_files[@]}"; do
        if convert_heic "$file" "$output_format"; then
            ((success_count++))
        fi
    done
    
    echo
    echo "Conversion complete: $success_count/${#heic_files[@]} files converted successfully."
}

main() {
    # Handle help and version flags
    case "${1:-}" in
        -h|--help)
            usage
            exit 0
            ;;
        -v|--version)
            echo "heicto $VERSION"
            exit 0
            ;;
    esac
    
    # Check ImageMagick
    check_imagemagick
    
    # Parse arguments
    local format="$DEFAULT_FORMAT"
    local target=""
    
    if [[ $# -eq 0 ]]; then
        # No arguments, convert current directory to JPG
        target="."
    elif [[ $# -eq 1 ]]; then
        # One argument: either format or file
        if [[ -f "$1" || -d "$1" ]]; then
            # It's a file or directory
            target="$1"
        else
            # It's a format, target current directory
            format="$1"
            target="."
        fi
    elif [[ $# -eq 2 ]]; then
        # Two arguments: format and target
        format="$1"
        target="$2"
    else
        echo "Error: Too many arguments"
        usage
        exit 1
    fi
    
    # Validate format (convert to lowercase for older bash compatibility)
    format_lower=$(echo "$format" | tr '[:upper:]' '[:lower:]')
    case "$format_lower" in
        jpg|jpeg|png|webp|bmp|tiff|gif)
            format="$format_lower"
            ;;
        *)
            echo "Error: Unsupported format '$format'"
            echo "Supported formats: jpg, jpeg, png, webp, bmp, tiff, gif"
            exit 1
            ;;
    esac
    
    # Convert
    if [[ -f "$target" ]]; then
        convert_heic "$target" "$format"
    elif [[ -d "$target" ]]; then
        batch_convert "$target" "$format"
    else
        echo "Error: '$target' is not a valid file or directory."
        exit 1
    fi
}

main "$@"
