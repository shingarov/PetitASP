Class {
	#name : #EzSMT,
	#superclass : #Object,
	#category : #'PetitASP-ASP'
}

{ #category : #clausification }
EzSMT >> clausify: anAspProgramString [
	| ez cnf errorString |
	ez := LibEzSMT uniqueInstance ezsmt_mk.
	cnf := LibEzSMT uniqueInstance ezsmt_clausify: ez _: anAspProgramString.
	cnf isNil ifFalse: [ ^cnf ].
	errorString := LibEzSMT uniqueInstance ezsmt_get_error: ez.
	LibEzSMT uniqueInstance ezsmt_del: ez.
	GringoSyntaxError signal: errorString
]

{ #category : #solving }
EzSMT >> getAllModelsFrom: solver [
	| one answerSet negations |
	one := self getOneModelFrom: solver.
	one isEmpty ifTrue: [^one].
	answerSet := one first.
	negations := (answerSet trueAtoms  collect: [ :anAtom | (Bool var: anAtom) not ]),
	             (answerSet falseAtoms collect: [ :anAtom |  Bool var: anAtom      ]).
	solver assert: (Bool or: negations).
	^(self getAllModelsFrom: solver) add: answerSet; yourself
]

{ #category : #solving }
EzSMT >> getOneModelFrom: solver [
	| model answerSet |
	solver check ifFalse: [^OrderedCollection new].
	model := solver getModel.
	answerSet := AnswerSet from: model.
	^OrderedCollection with: answerSet
]

{ #category : #clausification }
EzSMT >> preparse: source [
	| leftBracket rightBracket numDigits stream text expr |
	leftBracket := source indexOf: $«.
	leftBracket = 0 ifTrue: [ ^source ].
	rightBracket := source indexOf: $».
	text := source copyFrom: leftBracket+1 to: rightBracket-1.
	expr := TartagliaContext evaluate: text.
	^(source copyFrom: 1 to: leftBracket-1),
		'ezcsp_required(',
		(expr printEzCsp),
		')',
		(self preparse: (source copyFrom: rightBracket+1 to: source size))
]

{ #category : #solving }
EzSMT >> solveProgram: anAspProgramString [ 
	^ self solveProgram: anAspProgramString in: thisContext sender
]

{ #category : #solving }
EzSMT >> solveProgram: anAspProgramString in: aContext [
	| cnf dimacs |
	cnf := self clausify: (self preparse: anAspProgramString).
	dimacs := DIMACS parseText: cnf in: aContext.
	^ self getAllModelsFrom: dimacs solver.

]

{ #category : #solving }
EzSMT >> solveProgramOnce: anAspProgramString in: aContext [
	| cnf dimacs |
	cnf := self clausify: (self preparse: anAspProgramString).
	dimacs := DIMACS parseText: cnf in: aContext.
	^ self getOneModelFrom: dimacs solver.

]
