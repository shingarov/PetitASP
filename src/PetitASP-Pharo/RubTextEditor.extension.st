Extension { #name : #RubTextEditor }

{ #category : #'*PetitASP-Pharo' }
RubTextEditor >> highlightAspAndDo: aBlock [
	self highlightAndEmptyCheck: [ ^ '' ].
	^ self 
		solveASP: self highlightedTextAsStream
		andDo: [:result | aBlock value: result]
]
