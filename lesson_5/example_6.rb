[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end

# line 1
#    Action: method call (select)
#    Object: Array of hashes
#    Side Effect: None
#    Return Value: an array of hashes
#    Return value used: no
#
# line 2
#    Action: Method call (all?)
#    Object: each hash in the original array
#    Side Effect: None
#    Return Value: boolean
#    Return Value Used: Yes, used to determine result of outer block
#
# line 2-4
#    Action: Block Execution (all?)
#    Object: Each key and value in the hash
#    Side Effect: None
#    Return Value: Boolean
#    Return Value used: Yes, used to determine result of inner block
#
# line 3
#    Action: Method Call (==)
#    Object: each key/value pair in the hashes
#    Side Effect: None
#    Return Value: Boolean
#    Return Value Used: Yes, used to determine result of inner block
#
# line 3
#    Action: Method Call (to_s)
#    Object: Each key in the hashes
#    Side Effect: None
#    Return Value: a string
#    Return Value Used: Yes used in comparison
#
# line 3
#    Action: Method Call ([])
#    Object: Each Hash
#    Side Effect: None
#    Return Value: a string
#    Return Value Used: Yes, used in comparison
#
# line 1-5
#    Action: Block Execution (select)
#    Object: The original array of hashes
#    Side Effect: None
#    Return Value: an array of hashes
#    Return value Used: No
#
# Will return [{c: 'cat'}]
