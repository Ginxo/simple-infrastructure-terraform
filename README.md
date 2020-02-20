# simple-infrastructure-terraform

To execute terraform prepare your .env file in the root project folder based in the env.example file.
 
In order to use terraform, you should execute:
```
yarn terraform init <module_path>
```

In order to show and validate the plan:
```
yarn terraform plan <module_path>
```

In order to apply the plan:
```
yarn terraform apply <module_path>
```

In order to enter in terraform console:
```
yarn terraform console <module_path>
```
