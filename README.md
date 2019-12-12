# tffi-dev

tffi-dev contains the extensions to core Pharo to get Iceberg working with Threaded FFI.


## Using Gtoolkit with Threaded FFI

As of 13 December 2019 Gtoolkit loads Threaded FFI automatically, however it is initially disabled (since changing a library from using Squeak FFI to Threaded FFI requires the image be restarted).

Ensure you have the current headless VM:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Replace `libPThreadedPlugin.so` with the single `callbackStack` version - available on request. :-)

Load Gtoolkit following the instructions to load the latest alpha code in Pharo 8.0 at: https://gtoolkit.com/install/

Save the image and quit.

Enable Threaded FFI:

```
pharo Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI"
```

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


## Enabling Threaded FFI in a standard Pharo image

Ensure you have the current headless VM:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Replace `libPThreadedPlugin.so` with the single `callbackStack` version - available on request. :-)

To load Threaded FFI in a standard image:

```
EpMonitor disableDuring:
[ 
Metacello new
	baseline: 'GtThreadedFFIDev';
	repository: 'github://feenkcom/tffi-dev/src';
	load.
].
```
Save the image and quit.

Enable Threaded FFI:

```
pharo Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI"
```
