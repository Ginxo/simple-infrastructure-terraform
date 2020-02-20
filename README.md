# simple-infrastructure-terraform

To execute terraform prepare your .env file in the root project folder based in the env.example file.
 
In order to use terraform, you should execute:
```
yarn terraform init <environment_path>
```

In order to show and validate the plan:
```
yarn terraform plan <environment_path>
```

In order to apply the plan:
```
yarn terraform apply <environment_path>
```

In order to enter in terraform console:
```
yarn terraform console <environment_path>
```
