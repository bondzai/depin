FROM kylemanna/bitcoind:latest

# Install Lightning Network Daemon (LND)
RUN mkdir -p /lnd
WORKDIR /lnd
RUN git clone https://github.com/lightningnetwork/lnd.git .
RUN make && make install

# Expose LND ports
EXPOSE 9735 10009

# Start LND
CMD ["lnd"]
