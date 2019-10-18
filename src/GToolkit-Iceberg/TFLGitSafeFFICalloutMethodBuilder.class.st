Class {
	#name : #TFLGitSafeFFICalloutMethodBuilder,
	#superclass : #TFCalloutMethodBuilder,
	#category : #'GToolkit-Iceberg'
}

{ #category : #private }
TFLGitSafeFFICalloutMethodBuilder >> generateFFICallout: builder spec: functionSpec [
	"Before the actual ffi call generate a check to see if the object is ready."
	builder 
		pushReceiver;
		send: #signalIfNotReady.
	^ super generateFFICallout: builder spec: functionSpec
]
