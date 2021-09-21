Class {
	#name : #EzCspExpression,
	#superclass : #Object,
	#instVars : [
		'arguments'
	],
	#category : #PetitASP
}

{ #category : #'instance creation' }
EzCspExpression class >> functor: f args: args [
	^ (Smalltalk globals at: ('EZ_',f) asSymbol) basicNew arguments: args; yourself
]

{ #category : #accessing }
EzCspExpression >> arguments [
	^ arguments
]

{ #category : #accessing }
EzCspExpression >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
EzCspExpression >> printOn: aStream [
	aStream nextPutAll: (self class name);
		nextPutAll: '(...)'
]
