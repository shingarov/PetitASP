Class {
	#name : #AnswerSet,
	#superclass : #Object,
	#instVars : [
		'trueAtoms',
		'falseAtoms',
		'constraintAssignments'
	],
	#category : #'PetitASP-ASP'
}

{ #category : #'instance creation' }
AnswerSet class >> from: aModel [
	| constants trueAtoms falseAtoms ints |
	constants := aModel constantsASTs.
	trueAtoms := constants select: [ :anAST | anAST == Bool true ].
	trueAtoms := trueAtoms keys select: [ :anAtom | self isGoodVarName: anAtom ].
	falseAtoms := constants select: [ :anAST | anAST == Bool false ].
	falseAtoms := falseAtoms keys select: [ :anAtom | self isGoodVarName: anAtom ].
	ints := constants select: [ :anAST | anAST isInt ].
	^self basicNew 
		trueAtoms: trueAtoms;
		falseAtoms: falseAtoms;
		constraintAssignments: ints;
		yourself
]

{ #category : #'as yet unclassified' }
AnswerSet class >> isGoodVarName: aString [ 
	[Integer readFrom: aString. ^false] on: Error do: [ self ].
	(aString beginsWith: 'cspvar') ifTrue: [ ^false ].
	(aString beginsWith: 'cspdomain') ifTrue: [ ^false ].
	(aString beginsWith: 'ezcsp_required') ifTrue: [ ^false ].
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
AnswerSet >> falseAtoms [
	^ falseAtoms
]

{ #category : #accessing }
AnswerSet >> falseAtoms: anObject [
	falseAtoms := anObject
]

{ #category : #GT }
AnswerSet >> gtInspectorExtendedIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite fastTable
		title: 'Extended';
		display: [ self constraintAssignments associations ];
			column: 'Key' evaluated: [ :each | each key ];
			column: 'Value' evaluated: [ :each | each value ]
]

{ #category : #GT }
AnswerSet >> gtInspectorTrueIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastList
		title: 'True atoms';
		display: [ self trueAtoms ]
]

{ #category : #accessing }
AnswerSet >> trueAtoms [
	^ trueAtoms
]

{ #category : #accessing }
AnswerSet >> trueAtoms: anObject [
	trueAtoms := anObject
]
