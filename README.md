# simple-infrastructure-terraform

To execute terraform prepare your .env file in the root project folder based in the env.example file.
 
In order to use terraform, you should execute
```
env-cmd terraform init
```

In order to show and validate the plan
```
env-cmd terraform validate
```

In order to apply the plan
```
env-cmd terraform apply
```