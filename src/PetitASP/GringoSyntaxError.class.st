Class {
	#name : #GringoSyntaxError,
	#superclass : #Error,
	#instVars : [
		'srcName',
		'line',
		'column',
		'severity',
		'errorMessage'
	],
	#category : #PetitASP
}

{ #category : #exceptioninstantiator }
GringoSyntaxError class >> signal: aString [
	| fields ex |
	fields := $: split: aString.
	ex := self new 
		srcName: fields first;
		line: fields second;
		column: fields third;
		severity: fields fourth;
		errorMessage: fields fifth.
	ex signal
]

{ #category : #accessing }
GringoSyntaxError >> column [
	^ column
]

{ #category : #accessing }
GringoSyntaxError >> column: anObject [
	column := anObject
]

{ #category : #accessing }
GringoSyntaxError >> errorMessage [
	^ errorMessage
]

{ #category : #accessing }
GringoSyntaxError >> errorMessage: anObject [
	errorMessage := anObject
]

{ #category : #accessing }
GringoSyntaxError >> line [
	^ line
]

{ #category : #accessing }
GringoSyntaxError >> line: anObject [
	line := anObject
]

{ #category : #accessing }
GringoSyntaxError >> severity [
	^ severity
]

{ #category : #accessing }
GringoSyntaxError >> severity: anObject [
	severity := anObject
]

{ #category : #accessing }
GringoSyntaxError >> srcName [
	^ srcName
]

{ #category : #accessing }
GringoSyntaxError >> srcName: anObject [
	srcName := anObject
]
