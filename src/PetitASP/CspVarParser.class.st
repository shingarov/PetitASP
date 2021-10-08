Class {
	#name : #CspVarParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'v',
		'bounds'
	],
	#category : #'PetitASP-ASP'
}

{ #category : #accessing }
CspVarParser >> bounds [
	^$, asParser,
		#digit asParser star flatten,
		$, asParser,
		#digit asParser star flatten ==> [ :x | x second asInteger @ x fourth asInteger ]
]

{ #category : #accessing }
CspVarParser >> start [
	^('cspvar(' asParser, v, ')' asParser) end
	==> [ :x | x second ]
]

{ #category : #accessing }
CspVarParser >> v [
	^#word asParser star flatten, bounds optional
]
