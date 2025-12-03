local s = require 'say'

s:set_namespace('en')

s:set('assertion.between.positive', 'Expected value to be between %s and %s.\nPassed in:\n%s')
s:set('assertion.between.negative', 'Expected value to not be between %s and %s.\nPassed in:\n%s')

s:set('assertion.greater.positive', 'Expected value to be greater than %s.\nPassed in:\n%s')
s:set('assertion.greater.negative', 'Expected value to not be greater than %s.\nPassed in:\n%s')

s:set('assertion.greater_or_eq.positive', 'Expected value to be greater than or equal to %s.\nPassed in:\n%s')
s:set('assertion.greater_or_eq.negative', 'Expected value to not be greater than or equal to %s.\nPassed in:\n%s')

s:set('assertion.less.positive', 'Expected value to be less than %s.\nPassed in:\n%s')
s:set('assertion.less.negative', 'Expected value to not be less than %s.\nPassed in:\n%s')

s:set('assertion.less_or_eq.positive', 'Expected value to be less than or equal to %s.\nPassed in:\n%s')
s:set('assertion.less_or_eq.negative', 'Expected value to not be less than or equal to %s.\nPassed in:\n%s')
