"
GToolkit-Iceberg is a temporary repository for making the changes to Iceberg to support Threaded FFI (and the new headless VM).

"
Class {
	#name : #ManifestGToolkitIceberg,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Iceberg-Manifest'
}

{ #category : #'code-critics' }
ManifestGToolkitIceberg class >> ruleRBEqualsTrueRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'ThreadedFFIMigration class' #threadedFFIAvailable #true)) #'2019-11-08T09:00:01.901475+01:00') )
]
