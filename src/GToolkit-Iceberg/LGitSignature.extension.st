Extension { #name : #LGitSignature }

{ #category : #'*GToolkit-Iceberg' }
LGitSignature >> prim_name [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle asExternalAddress pointerAt: OFFSET_PRIM_NAME) type: ExternalType char asPointerType
]
