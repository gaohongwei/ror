 put 'person/:person_trust', 
 to: 'person#person_trust', 
 as: :person_trust, 
 constraints: { person_trust: /trusted|untrusted|unmark/ }
