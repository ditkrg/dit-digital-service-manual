# Application Decisions

## Be Careful with Class Variables

Be careful with using class variable for checking a condition in threaded environments and resort to instance attributes to do so. Consider the following case:

```ruby
def update_without_logging(resource_id)
  Audit.disable_logging
  
  @resource = Audit.find(resource_id)
  @resource.update(some_field: 'some value')

  Audit.enable_logging
end
```



This design will eventually fall for race conditions since some other requests may be processed on the same instance of the application while `Audit.disable_logging`, which is unintended. This happens because class variables are static and are not subjected to garbage collection. The effect of this action will be extended to any other instance of the class `Audit` that is outside of the scope of the method `update_without_logging`.

To resolve this, use an instance variable:

```ruby
def update_without_logging(resource_id)
  @resource = Audit.find(resource_id)
  @resource.disable_logging
  @resource.update(some_field: 'some value')
end
```