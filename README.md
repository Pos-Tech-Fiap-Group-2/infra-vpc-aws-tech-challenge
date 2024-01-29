# infra-vpc-aws-tech-challenge

### Descrição
Este projeto visa automatizar a criação de um [Amazon Virtual Private Cloud (Amazon VPC)](https://aws.amazon.com/pt/vpc/) usando [GitHub Workflow](https://docs.github.com/pt/actions) em uma conta AWS utilizando o terraform. 
 Oferece controle total sobre seu ambiente de redes virtual, incluindo posicionamento de recursos, conectividade e segurança. Comece a usar configurando sua VPC no console de serviço AWS. Em seguida, adicione recursos a ela, como instâncias do Amazon Elastic Compute Cloud (EC2) e Amazon Relational Database Service (RDS). Por fim, defina como suas VPCs se comunicam entre si, entre contas, zonas de disponibilidade (AZs) ou Regiões da AWS.

## Membros do Grupo 2
- [Danilo Monteiro](https://github.com/dmonteirosouza)
- [Marcel Cozono](https://github.com/macozono)
- [Viviane Scarlatti](https://github.com/viviane-scarlatti)
- [Vinicius Furin](https://github.com/VFurin)
- [Vitor Walcker](https://github.com/VitorWalcker)

## Configuração

1. **Pré-requisitos:**
    - Conta ativa na AWS.
    - Conhecimento básico de GitHub Actions.
    - Ter o [terraform](https://developer.hashicorp.com/terraform/downloads) instalado.
    - Ter o [AWS CLI](https://aws.amazon.com/pt/cli/) instalado.
  
2. **Configuração inicial:**
    - Após fazer o clone do projeto você já consegue executar os comando locais do terraform
    - Configure as [credenciais de acesso no GitHub](https://docs.github.com/pt/actions/security-guides/using-secrets-in-github-actions) para fazer o deploy em uma conta exclusiva.
  
## Estrutura do Projeto

A estrutura do projeto está composta da seguinte maneira, na pasta .github encontramos os arquivos do workflow responsavel por acionar a esteira e executar os steps, já a pasta infra estão todos os arquivos utilizado para gerar os recursos de infra estrutura. 

```
projeto/
  ├── .github/
  │   ├── workflows/
  │   │   └── infra-vpc-aws.yml
  ├── infra_vpc/
      ├── lb.tf
      ├── locals.tf
      ├── main.tf
      ├── providers.tf
      ├── variables.tf      
```
## Fluxo de Trabalho

O fluxo do workflow usando neste projeto é o seguinte:

1. Ele executa o checkout do repositorio;
2. Faz todo o setup para utilizar o Terraform;
3. Executa a configuração das Credencias da AWS;
4. Faz o step do terraform Format;
5. Faz o step do terraform Init;
6. Faz o step do terraform Validate;
7. Faz o step do terraform Plan;
8. Faz o step do terraform Apply;
9. Faz o step do Clean do arquivo do Plan;