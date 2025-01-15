# Folder Size Scanner

A high-performance directory size analyzer. This tool scans a specified directory, calculates the size of each folder, and generates a CSV report. It uses multithreading to speed up the scanning process, making it suitable for large directories.

## Setup

1. Clone the repository:
```bash
git clone https://github.com/dmcp718/fs-folder-sizes.git
cd fs-folder-sizes
```

2. Create a virtual environment:
```bash
python -m venv venv
```

3. Activate the virtual environment:

On Unix/macOS:
```bash
source venv/bin/activate
```

On Windows:
```bash
.\venv\Scripts\activate
```

4. Install requirements:
```bash
pip install -r requirements.txt
```

## Features

-   **Fast Scanning:** Utilizes multithreading to scan directories quickly.
-   **Detailed Output:** Generates a CSV report with folder paths and their sizes.
-   **Human-Readable Sizes:** Displays sizes in a human-friendly format (e.g., KB, MB, GB, TB).
-   **Progress Tracking:** Shows the number of files processed during the scan.
-   **Handles Errors:** Gracefully handles permission errors and other issues during scanning.
-   **Customizable:** Allows specifying the number of worker threads and whether to include hidden files.
-   **Interruptible:** Supports graceful interruption via `Ctrl+C`, saving partial results.
-   **Flexible Reports:** Option to show only top-level directory sizes for a concise overview.

## Usage

```bash
python folder_sizes.py --mount-point /path/to/scan [options]
```

### Options

-   `--mount-point PATH`: Root directory path to scan (required).
-   `--output FILE`: Output CSV file path (default: `folder_sizes.csv`).
-   `--include-hidden`: Include hidden files and folders starting with ".".
-   `--workers N`: Number of scanner threads (default: 8).
-   `--top-level`: Only report sizes for top-level directories.

### Examples

```bash
# Basic scan of a directory
python folder_sizes.py --mount-point /data

# Scan with custom output file
python folder_sizes.py --mount-point /data --output sizes.csv

# Include hidden files and use 16 worker threads
python folder_sizes.py --mount-point /data --include-hidden --workers 16

# Only show sizes of top-level directories
python folder_sizes.py --mount-point /data --top-level
```

### Example Output

```
Starting scan of /path/to/scan
Processed 467,792 files...

Scan Summary:
Total Files: 467,792
Total Directories: 188,870
Total Size: 7.91 TB
Scan Time: 60.35 seconds
Scan Rate: 10,880.15 entries/sec
```

## Output CSV Format

The output CSV file contains the following columns:

-   `Folder Path`: The path of the folder relative to the mount point.
-   `Size`: The total size of the folder in a human-readable format.

Example:
```csv
Folder Path, Size
/,          7.91 TB
/docs,      45.67 MB
/images,    234.56 GB
```

With `--top-level` option:
```csv
Folder Path, Size
/,          7.91 TB
/docs,      45.67 MB
/images,    234.56 GB
/data,      1.23 TB
```
Note: When using `--top-level`, only the root directory and its immediate subdirectories are included in the report.

## How It Works

1.  **Initialization:** The script takes the mount point, output file, and other options as command-line arguments.
2.  **Parallel Scanning:** It uses a queue and multiple worker threads to scan the directory tree in parallel.
3.  **Size Calculation:** Each worker thread calculates the size of the files and directories it encounters.
4.  **Progress Tracking:** The main thread monitors the progress and prints the number of files processed.
5.  **Cumulative Sizes:** After scanning, the script calculates the cumulative size of each directory by summing the sizes of its subdirectories.
6.  **CSV Report:** Finally, it writes the folder paths and their sizes to a CSV file.
7.  **Report Filtering:** If `--top-level` is specified, only root and immediate subdirectories are included in the report.
8.  **Summary:** Prints a summary of total files, directories, size, scan time, and scan rate.

## Notes

-   The script handles permission errors and other issues gracefully, printing error messages to the console.
-   The scan can be interrupted by pressing `Ctrl+C`. The script will attempt to save partial results before exiting.
-   The number of worker threads can be adjusted using the `--workers` option.
-   Hidden files and folders (starting with `.`) are excluded by default but can be included using the `--include-hidden` option.

## Requirements

-   Python 3.7 or higher

## Build from Source (macOS)

You can build a standalone executable using PyInstaller:

```bash
# Install PyInstaller
pip install pyinstaller

# Build executable
./build.sh

# The executable will be in dist/folder-sizes
```

Note: The current build configuration is optimized for macOS. For other platforms, modifications to the build script may be needed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Performance Tips

-   **Worker Threads:** The scanner uses multiple threads for parallel processing
    -   Default is 16 workers for optimal performance
    -   Network filesystems: Try 16-32 workers
    -   Local SSDs: 8-16 workers usually optimal
    -   HDDs: 4-8 workers may work better
    -   Adjust using `--workers N` option

-   **Example Performance:**
    ```
    16 workers: ~16,000 entries/sec
    8 workers:  ~7,400 entries/sec
    4 workers:  ~6,000 entries/sec
    ```

