Extension { #name : #GLMTextualPresentation }

{ #category : #'*PetitASP-Pharo' }
GLMTextualPresentation >> highlightSolveAndDo: aBlock [
	self announce: (GLMSolveASP new action: aBlock)
]
