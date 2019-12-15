# tffi-dev

tffi-dev contains the extensions to core Pharo to get Iceberg / LibGit working with Threaded FFI.

The code relies on a modified version of `libPThreadedPlugin.so` with a single `callbackStack`.

While the code can be loaded, it will not function until the modified library is present.

## Build a base Threaded FFI enabled Pharo 8 Image

Ensure you have the current headless VM:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Replace `libPThreadedPlugin.so` with the single `callbackStack` version - available on request. :-)

Copy the following in to a script, e.g. `tffi.st`:

```
"Load Threaded FFI and the extensions for LibGit"
EpMonitor disableDuring:
[ 
Metacello new
	baseline: 'GtThreadedFFIDev';
	repository: 'github://feenkcom/tffi-dev/src';
	load.
].

"Alien callbacks and Threaded FFI callbacks may not be used in the same session.
The following message send must be the last thing executed before saving the image and quitting."
ThreadedFFIMigration enableThreadedFFI.
```

Run the script with the following:

```
pharo Pharo.image ../tffi.st --save --quit
```


## Using Gtoolkit with Threaded FFI

As of 13 December 2019 Gtoolkit loads Threaded FFI automatically, so the equivalent script may be used

Ensure you have the current headless VM:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Replace `libPThreadedPlugin.so` with the single `callbackStack` version - available on request. :-)

```
EpMonitor disableDuring:
[ 
  Metacello new
    baseline: 'GToolkit';
    repository: 'github://feenkcom/gtoolkit/src';
    load.

].

"Alien callbacks and Threaded FFI callbacks may not be used in the same session.
The following message send must be the last thing executed before saving the image and quitting."
ThreadedFFIMigration enableThreadedFFI.
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
