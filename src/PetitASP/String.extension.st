Extension { #name : #String }

{ #category : #'*PetitASP' }
String >> cosa [
	^ Cosa named: self
]

{ #category : #'*PetitASP' }
String >> ezEscape [
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: 'ezcsp_escape_'.
	self do: [ :c | c codePoint printOn: stream base: 16 nDigits: 4 ].
	^stream contents
]
