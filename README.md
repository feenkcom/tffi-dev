# tffi-dev

Temporary repository while we get Pharo 8 working with Threaded FFI.


## Load in Pharo8 with headless vm

The latest version may be retrieved with zeroconf:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Replace `libPThreadedPlugin.so` with the single `callbackStack` version - available on request. :-)

Download `gt-tffi.st` (in this repository) to the same directory as your Pharo image.

Load Gtoolkit, TFFI and extensions:

```
./pharo Pharo.image eval --save "'gt-tffi.st' asFileReference fileIn."
```

Note: loading should be performed in headless mode (as above) to prevent UI code from attempting to use [T]FFI while it is being modified.


## Running Gtoolkit with native windows

To then run Pharo with Bloc graphics:

```
./pharo Pharo.image eval --interactive --no-quit "GtWorld open."
```


## Running Gtoolkit with the old morphic interface

To run Pharo with the old Morphic world:

1. Disable the suppression of the old morphic windowing system:

Start pharo using a standard VM (available with `curl get.pharo.org/64/vm80 | bash`).

```
BlNullWorldRenderer disable.
```

save the image.

2. Start the image with the old morphic windowing system:

```
./pharo-ui Pharo.image
```
