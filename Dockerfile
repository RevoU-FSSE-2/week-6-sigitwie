# Gunakan Node.js sebagai base image
FROM node:14

# Buat direktori kerja di dalam container
WORKDIR /usr/src/app

# Salin package.json dan package-lock.json ke dalam container
COPY package*.json ./

# Install dependencies
RUN npm install

# Salin seluruh kode aplikasi ke dalam container
COPY . .

# Tentukan port yang akan digunakan oleh aplikasi
EXPOSE 3001

# Jalankan aplikasi ketika container dijalankan
CMD ["node", "app.js"]
