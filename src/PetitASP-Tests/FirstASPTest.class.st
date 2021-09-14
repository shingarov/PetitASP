Class {
	#name : #FirstASPTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'PetitASP-Tests'
}

{ #category : #tests }
FirstASPTest >> getAllModelsFrom: solver [
	| model answerSet negations |
	solver check ifFalse: [^OrderedCollection new].
	model := solver getModel.
	answerSet := AnswerSet from: model.
	negations := answerSet trueAtoms collect: [ :anAtom | (Bool var: anAtom) not ].
	solver assert: (Bool or: negations).
	^(self getAllModelsFrom: solver) add: answerSet; yourself

]

{ #category : #tests }
FirstASPTest >> test1 [ 
	| fs smt2 solver answerSets |
	smt2 := (FileReference / '/home/boris/work/EZSMT/SMT1') readStream contents.
	fs := Z3ASTVector parseSmtlib2String: smt2.
	
	solver := Z3Solver for: 'QF_LIA'.  "QF_BV"
	
	fs assertIn: solver.
	
	answerSets := self getAllModelsFrom: solver.
	answerSets halt
]

{ #category : #tests }
FirstASPTest >> testCallLibEzSMT [
	| cnf answerSets dimacs |
	
	cnf := LibEzSMT uniqueInstance ezsmt: 'a :- b'.
	dimacs := DIMACS parseText: cnf.
	answerSets := self getAllModelsFrom: dimacs solver.
	answerSets halt

]

{ #category : #tests }
FirstASPTest >> testParseDIMACS [
	| answerSets dimacs |
	dimacs := DIMACS parseFile: '/home/boris/work/EZSMT/dimacs-completion989063435.out'.
	answerSets := self getAllModelsFrom: dimacs solver.
	answerSets halt
]
