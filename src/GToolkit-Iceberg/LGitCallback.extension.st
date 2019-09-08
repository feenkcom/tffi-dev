Extension { #name : #LGitCallback }

{ #category : #'*GToolkit-Iceberg' }
LGitCallback >> calloutAPIClass [
	^ TFCalloutAPI
]

{ #category : #'*GToolkit-Iceberg' }
LGitCallback class >> ffiLibraryName [
	^ LGitLibrary
]

{ #category : #'*GToolkit-Iceberg' }
LGitCallback >> ffiLibraryName [
	^ self class ffiLibraryName
]

{ #category : #'*GToolkit-Iceberg' }
LGitCallback class >> null [
	^ ExternalAddress null
]
