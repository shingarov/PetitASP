Extension { #name : #Dictionary }

{ #category : #'*PetitASP' }
Dictionary >> lookupSymbol: aString ifAbsent: aBlockClosure [ 
	^self at: aString ifAbsent: aBlockClosure
]
