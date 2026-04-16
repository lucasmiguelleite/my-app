# Etapa 1: build
FROM node:18-alpine AS builder

WORKDIR /app

# Copia arquivos de dependências
COPY package.json package-lock.json* ./

# Instala dependências
RUN npm install

# Copia o restante do projeto
COPY . .

# Build da aplicação
RUN npm run build

# Etapa 2: runtime
FROM node:18-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Copia apenas o necessário do build
COPY --from=builder /app ./

# Expor porta padrão do Next
EXPOSE 3000

# Inicia o app
CMD ["npm", "start"]
