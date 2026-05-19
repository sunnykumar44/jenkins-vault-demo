pipeline {
    agent any

    stages {

        stage('Fetch Secrets') {
            steps {

                sh '''
                export VAULT_ADDR=https://pronteff-vault.com:8200
                export VAULT_SKIP_VERIFY=true

                VAULT_TOKEN=$(vault write -field=token auth/approle/login \
                    role_id="ROLE_ID" \
                    secret_id="SECRET_ID")

                export VAULT_TOKEN

                DB_USER=$(vault kv get -field=username secret/db)
                DB_PASS=$(vault kv get -field=password secret/db)

                export DB_USER
                export DB_PASS

                chmod +x deploy.sh
                ./deploy.sh
                '''
            }
        }
    }
}
