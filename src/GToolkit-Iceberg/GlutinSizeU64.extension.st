Extension { #name : #GlutinSizeU64 }

{ #category : #'*GToolkit-Iceberg' }
GlutinSizeU64 class >> externalNew [
	| created |

	created := self primCreate.
	created class = self ifTrue: [ ^created ].
	^ self basicNew setHandle: created
]
