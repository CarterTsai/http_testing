http_testing
============

http testing with ruby

### Example 

```
require './lib'

uri = URI("http://localhost")

res, json = MHTTP.post(uri, {'name'=>'google', 'password'=>'123'})
```

