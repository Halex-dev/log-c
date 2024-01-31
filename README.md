# Log Library

This is a versatile and customizable logging library designed for speed and thread safety. It provides the flexibility to choose whether to enable thread safety, and allows customization of log levels, colors, and console output.

## License

This library is distributed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Features

- **Thread Safety:** The library supports thread safety, and you can choose whether to enable it by setting the `thread_safe` configuration.
  
- **Customizable Log Levels:** Customize log levels, colors, console output, and file output to tailor the logging experience to your needs.

- **Timestamped Logs:** Log entries include timestamps for better traceability.

## Configuration

Before using the library, you can configure its behavior through the `log_config` structure. Modify the `config.thread_safe` field to enable or disable thread safety.

## Log Levels

The library supports the following log levels:

- `STATS`
- `DEBUG`
- `INFO`
- `WARN`
- `ERROR`
- `FATAL`

## Customization

### Set Log Color

```c
log_setColor(LOG_LEVEL, "COLOR_CODE");
```

Customize the color associated with a specific log level using ANSI color codes. Note that this feature requires ANSI color support in the terminal.

### Set Console Output
```c
log_setConsole(LOG_LEVEL, true_or_false);
```
Enable or disable console output for a specific log level.

### Set Write Line
```c
log_setWriteLine(LOG_LEVEL, true_or_false);
```
Enable or disable writing the line number in log entries for a specific log level.

## Usage

1. **Initialize the log file:**

    ```c
    init_log_file("LOG_PATH", "MODE");
    ```

    This function initializes the log file, creating it if necessary. Provide the log path and file mode (e.g., "w" for write).

2. **Log entries:**

    ```c
    mylog(LOG_LEVEL, "FILE_NAME", LINE_NUMBER, "FORMAT_STRING", ...);
    ```

    Use the `mylog` function to create log entries. Specify the log level, file name, line number, and format string along with any additional arguments.

    For example:

    ```c
    mylog(INFO, "main.c", 42, "Processing data: %s", data);
    ```

    This logs an informational message at line 42 of the "main.c" file with a custom format string.

3. **Thread Safety:**

    To ensure thread safety, use the following function:

    ```c
    log_threadsafe(true_or_false);
    ```

    Set the argument to `true` to enable thread safety and `false` to disable it.

4. **Cleanup:**

    Don't forget to close the logger when done:

    ```c
    close_logger();
    ```

    This function destroys the mutex and closes the log file.

Feel free to customize this logging library according to your project's requirements. Enjoy fast and customizable logging!
