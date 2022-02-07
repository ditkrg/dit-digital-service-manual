# Version Control and Repository Management
All code must be controlled using Git. The code bases must be stored in independent repository in a single-application-per-repository fashion on GitHub. No repository shall contain more than one software component. 

#### Git

All software code bases must have a branch named `main` that acts as the default branch. Changing the default branch to be something else is not regularly permissible unless authorized by the Head of DevOps. 

##### Branching

Conventionally, each code base must also have a branch that corresponds to an identical deployment environment. For example, the branch `dev` corresponds to codes running in a `dev` environment, `staging` to `staging`, `pre-prod` to `pre-prod`, and `main` to `production`. 

All code bases must have a branch that corresponds to a major version. For example branch `v1.x.x` must contain all initial codes. The next major release must also get its own branch `v2.x.x` which is typically created off `main`.  (Edge cases must be explicitly authorized by the Head of Digital Development or DevOps). 

The order from which branches are merged generally takes the following form:

`major version branch` -> `dev` -> `staging` -> `pre-prod` -> `main`

An example:

`v1.x.x` -> `dev` -> `staging` -> `pre-prod` -> `main`

All the minor releases and patches within the same version follows the same flow. However, in the next major release, it takes the next form:

From `main` create `next version branch` -> `dev` -> `staging` -> `pre-prod` -> `main`

An example:

From `main` create `v2.x.x` -> `dev` -> `staging` -> `pre-prod` -> `main`

##### Merging and Pushing

All developers are free to push to the release branch and `dev` whenever they would like to. However, pushing to any other branch requires a Pull Request that needs review and approval. 

Below is an overview of the policies:

| Branch Name              | Authorized Parties                                           | Review Policy                             |
| ------------------------ | ------------------------------------------------------------ | ----------------------------------------- |
| Release / Feature Branch | No restriction                                               | No review required                        |
| dev                      | No restriction                                               | No review required                        |
| staging                  | Authorized by Head of Digital Development or DevOps  <br />Team Leads | No review required                        |
| pre-prod                 | Authorized by Head of Digital Development or DevOps          | At least 1 review by Head of DD or DevOps |
| main                     | Only Head of DevOps                                          | At least 1 review by Head of DD           |

##### Secrets

#### GitHub

All repositories must be hosted on the [KRG's main GitHub organization](https://github.com/ditkrg). All members of the Digital Development Team and the DevOps Team are eligible to receive a free seat on the organization. Contractors' collaborators must be added as external collaborators. 

All members of the organization are required to use:

1. SSH Keys for authentication.
2. GPG to sign their commits. 

Unverified/unsigned commits are not going to be allowed. 

Please refer to [this guide](https://docs.github.com/en/authentication/managing-commit-signature-verification) to setup GPG keys. 
