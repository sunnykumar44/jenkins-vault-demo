pipeline {
    agent any

    environment {
        VAULT_ADDR = 'https://pronteff-vault.com:8200'
        VAULT_SKIP_VERIFY = 'true'
    }

    stages {

        stage('Fetch Secrets') {

            steps {

                sh '''
                JWT_TOKEN=$(python3 - <<EOF
import jwt,time

payload = {
    "sub": "jenkins",
    "iat": int(time.time()),
    "exp": int(time.time()) + 300
}

with open("/opt/jenkins-jwt/jwt-private.pem") as f:
    key = f.read()

print(jwt.encode(payload,key,algorithm="RS256"))
EOF
)

                VAULT_TOKEN=$(vault write -field=token \
                    auth/jwt/login \
                    role="jenkins-jwt" \
                    jwt="$JWT_TOKEN")

                export VAULT_TOKEN

                DB_USER=$(vault kv get -field=username secret/db)
                DB_PASS=$(vault kv get -field=password secret/db)
                DB_HOST=$(vault kv get -field=host secret/db)
                DB_NAME=$(vault kv get -field=database secret/db)

                export DB_USER
                export DB_PASS
                export DB_HOST
                export DB_NAME

                sed -i 's/\r$//' deploy.sh

                chmod +x deploy.sh
                ./deploy.sh
                '''
            }
        }
    }
}
