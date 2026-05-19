pipeline {
    agent any

    environment {
        VAULT_ADDR = 'https://pronteff-vault.com:8200'
        VAULT_SKIP_VERIFY = 'true'
    }

    stages {

        stage('Fetch Secrets') {

            steps {

                withCredentials([
                    string(credentialsId: 'vault-role-id', variable: 'ROLE_ID'),
                    string(credentialsId: 'vault-secret-id', variable: 'SECRET_ID')
                ]) {

                    sh '''
                    VAULT_TOKEN=$(vault write -field=token auth/approle/login \
                        role_id="$ROLE_ID" \
                        secret_id="$SECRET_ID")

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
}
