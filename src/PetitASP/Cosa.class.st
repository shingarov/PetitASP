Class {
	#name : #Cosa,
	#superclass : #TartagliaTerm,
	#instVars : [
		'name'
	],
	#category : #'PetitASP-CardanoTartaglia'
}

{ #category : #'instance creation' }
Cosa class >> named: aString [ 
	^ self basicNew name: aString
]

{ #category : #'instance creation' }
Cosa class >> new [
	self shouldNotImplement 
]

{ #category : #accessing }
Cosa >> name [
	^ name
]

{ #category : #accessing }
Cosa >> name: anObject [
	name := anObject
]

{ #category : #printing }
Cosa >> printEzCsp [
	^self name
]

{ #category : #printing }
Cosa >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
Cosa >> substCosas: anEnvironment [
	(self name beginsWith: 'ezsmt_levelrank_') ifTrue: [ 
		"special level-ranking var in EZSMTplus"
		^self name toInt ].
	^anEnvironment
		lookupSymbol: self name 
		ifAbsent: [ (VariableNotDeclared new variableNode: self) signal ]
]

{ #category : #accessing }
Cosa >> variables [ 
	^Set with: self name
]
