Class {
	#name : #TFLGitSafeFFICalloutAPI,
	#superclass : #TFCalloutAPI,
	#category : #'GToolkit-Iceberg'
}

{ #category : #action }
TFLGitSafeFFICalloutAPI >> newBuilder [
	^ TFLGitSafeFFICalloutMethodBuilder calloutAPI: self
]
