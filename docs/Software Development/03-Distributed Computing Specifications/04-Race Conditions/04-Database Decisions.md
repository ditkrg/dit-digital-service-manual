# Database Decisions

## Uniqueness

Always place a unique index on columns are that supposed to contain unique values. This goes hand in hand with the previously described situations of race conditions. Applications that only check uniqueness on application level through 'check-then-act' will fall victim to race conditions and end up having inconsistent, non-unique data that is assumed to be valid. 

## Versioning

It is always a good practice to version records so that is can also comply with the Optimistic Concurrency Control model. This requirement is not forced but it is highly recommended. 

The version column must be atomically incremented. 