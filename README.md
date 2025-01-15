# Folder Size Scanner

A high-performance directory size analyzer. This tool scans a specified directory, calculates the size of each folder, and generates a CSV report. It uses multithreading to speed up the scanning process, making it suitable for large directories.

## Features

-   **Fast Scanning:** Utilizes multithreading to scan directories quickly.
-   **Detailed Output:** Generates a CSV report with folder paths and their sizes.
-   **Human-Readable Sizes:** Displays sizes in a human-friendly format (e.g., KB, MB, GB, TB).
-   **Progress Tracking:** Shows the number of files processed during the scan.
-   **Handles Errors:** Gracefully handles permission errors and other issues during scanning.
-   **Customizable:** Allows specifying the number of worker threads and whether to include hidden files.
-   **Interruptible:** Supports graceful interruption via `Ctrl+C`, saving partial results.

## Usage

```bash
./folder_sizes.py --mount-point /path/to/scan [options]
```

### Options

-   `--mount-point PATH`: Root directory path to scan (required).
-   `--output FILE`: Output CSV file path (default: `folder_sizes.csv`).
-   `--include-hidden`: Include hidden files and folders starting with ".".
-   `--workers N`: Number of scanner threads (default: 8).

### Examples

```bash
# Basic scan of a directory
./folder_sizes.py --mount-point /data

# Scan with custom output file
./folder_sizes.py --mount-point /data --output sizes.csv

# Include hidden files and use 16 worker threads
./folder_sizes.py --mount-point /data --include-hidden --workers 16
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

## How It Works

1.  **Initialization:** The script takes the mount point, output file, and other options as command-line arguments.
2.  **Parallel Scanning:** It uses a queue and multiple worker threads to scan the directory tree in parallel.
3.  **Size Calculation:** Each worker thread calculates the size of the files and directories it encounters.
4.  **Progress Tracking:** The main thread monitors the progress and prints the number of files processed.
5.  **Cumulative Sizes:** After scanning, the script calculates the cumulative size of each directory by summing the sizes of its subdirectories.
6.  **CSV Report:** Finally, it writes the folder paths and their sizes to a CSV file.
7.  **Summary:** Prints a summary of total files, directories, size, scan time, and scan rate.

## Notes

-   The script handles permission errors and other issues gracefully, printing error messages to the console.
-   The scan can be interrupted by pressing `Ctrl+C`. The script will attempt to save partial results before exiting.
-   The number of worker threads can be adjusted using the `--workers` option.
-   Hidden files and folders (starting with `.`) are excluded by default but can be included using the `--include-hidden` option.

## Requirements

-   Python 3.7 or higher

## Installation

No installation is required. Simply download the `folder_sizes.py` script and run it.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

