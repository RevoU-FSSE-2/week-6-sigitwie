   # Use Node.js as the base image
   FROM node:14

   # Set the working directory inside the container
   WORKDIR /usr/src/app

   # Copy package.json and package-lock.json into the container
   COPY package*.json ./

   # Install dependencies
   RUN npm install

   # Copy the entire application code into the container
   COPY . .

   # Specify the port that the application will use
   EXPOSE 3001

   # Run the application when the container is launched
   CMD ["node", "app.js"]
