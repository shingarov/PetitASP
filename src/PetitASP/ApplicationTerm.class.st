Class {
	#name : #ApplicationTerm,
	#superclass : #TartagliaTerm,
	#instVars : [
		'message',
		'receiver'
	],
	#category : #'PetitASP-CardanoTartaglia'
}

{ #category : #'*PetitASP' }
ApplicationTerm >> printEzCsp [
	| stream |
	stream := WriteStream on: String new.
	stream
		nextPutAll: 'ezcsp_appl(';
		nextPutAll: (message selector asString ezEscape);
		nextPut: $,;
		nextPutAll: receiver printEzCsp.
	message arguments do: [ :arg |
		stream nextPut: $,;
			nextPutAll: arg printEzCsp ].
	stream nextPut: $).
	^stream contents
]
