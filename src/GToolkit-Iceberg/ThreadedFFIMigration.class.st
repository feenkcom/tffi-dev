"
ThreadedFFIMigration provides a number of methods to allow code to be written that can be used in both Squeak only FFI and Threaded FFI environments.

It is expected that once the migration to Threaded FFI is complete, automatic re-write rules using the deprecation framework will be introduced to remove all references to ThreadedFFIMigration, which will then be removed.


Public API and Key Messages

- threadedFFIAvailable   answer a boolean indicating whether the threaded FFI functionality is currently available.

 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ThreadedFFIMigration,
	#superclass : #Object,
	#classVars : [
		'ThreadedFFIAvailable'
	],
	#category : #'GToolkit-Iceberg'
}

{ #category : #private }
ThreadedFFIMigration class >> getThreadedFFIAvailable [
	"Determine whether threaded ffi is available and set the flag"

	| libcPID tffiPID runner function result |

	result := false.
	[ 
		libcPID := LibC uniqueInstance currentProcessId.
		runner := TFWorker default.
		function := TFExternalFunction
			name: 'getpid'
			moduleName: 'libc.so.6'
			definition:
				(TFFunctionDefinition
					parameterTypes: {}
					returnType: TFBasicType uint).
		tffiPID := runner invokeFunction: function.
		result := tffiPID = libcPID. ]
			on: Error 
			do: [ ].
	^result
]

{ #category : #'class initialization' }
ThreadedFFIMigration class >> initialize [ 

	SessionManager default
		registerSystemClassNamed: self name
		atPriority: 20
]

{ #category : #initialization }
ThreadedFFIMigration class >> reset [ 

	ThreadedFFIAvailable := nil.
]

{ #category : #'system startup' }
ThreadedFFIMigration class >> shutDown: quitting [
	"Force to detect Threaded FFI Availability if the VM may change"

	self reset
]

{ #category : #'system startup' }
ThreadedFFIMigration class >> startUp: resuming [
	"Force to detect Threaded FFI Availability if the VM may have changed"

	self reset
]

{ #category : #accesing }
ThreadedFFIMigration class >> threadedFFIAvailable [

	^ThreadedFFIAvailable ifNil: [ ThreadedFFIAvailable := self getThreadedFFIAvailable ]
]
