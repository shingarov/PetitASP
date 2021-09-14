Class {
	#name : #AnswerSet,
	#superclass : #Object,
	#instVars : [
		'trueAtoms',
		'constraintAssignments'
	],
	#category : #PetitASP
}

{ #category : #'instance creation' }
AnswerSet class >> from: aModel [
	| trueAtoms ints |
	trueAtoms := aModel constantsASTs select: [ :anAST | anAST == Bool true ].
	trueAtoms := trueAtoms keys select: [ :anAtom | self isGoodVarName: anAtom ].	
	ints := aModel constantsASTs select: [ :anAST | anAST isInt ].
	^self basicNew 
		trueAtoms: trueAtoms;
		constraintAssignments: ints;
		yourself
]

{ #category : #'as yet unclassified' }
AnswerSet class >> isGoodVarName: aString [ 
	[Integer readFrom: aString. ^false] on: Error do: [ self ].
	(aString beginsWith: 'cspvar') ifTrue: [ ^false ].
	(aString beginsWith: 'cspdomain') ifTrue: [ ^false ].
	(aString beginsWith: 'required') ifTrue: [ ^false ].
	^true
]

{ #category : #accessing }
AnswerSet >> constraintAssignments [
	^ constraintAssignments
]

{ #category : #accessing }
AnswerSet >> constraintAssignments: anObject [
	constraintAssignments := anObject
]

{ #category : #accessing }
AnswerSet >> trueAtoms [
	^ trueAtoms
]

{ #category : #accessing }
AnswerSet >> trueAtoms: anObject [
	trueAtoms := anObject
]
