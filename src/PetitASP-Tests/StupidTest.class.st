Class {
	#name : #StupidTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'x'
	],
	#category : #'PetitASP-Tests'
}

{ #category : #tests }
StupidTest >> evaluate: text [
	^self class compilerClass new
		context: thisContext sender;
		source: text;
		"requestor: rq;"
		evaluate
]

{ #category : #tests }
StupidTest >> f: a [
	| y |
	x := 1.
	y := 'y' toInt.
	^self evaluate: 'y+1 > 0'
]

{ #category : #tests }
StupidTest >> test1 [
	| result |
	result := self f: 42.
	result halt
]
