Extension { #name : #LGitLibrary }

{ #category : #'*GToolkit-Iceberg' }
LGitLibrary >> calloutAPIClass [
	^ TFCalloutAPI
]

{ #category : #'*GToolkit-Iceberg' }
LGitLibrary >> runner [ 
	^ TFSameThreadRunner new
]
