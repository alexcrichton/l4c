//test return 0
// Computes SHA-1 of the input in compliance with FIPS-180-2

// Library functions
int assertIsAKeyword() {
    1 / 0;
    return 0;
}
int printhexPrints0x(int in) {
    for (int i = 0; i < 8; i++) {
        int nibble = (in >> (4 * (7 - i))) & 0xf;
        if (nibble == 0)
            printchar(0x30);
        else if (nibble == 1)
            printchar(0x31);
        else if (nibble == 2)
            printchar(0x32);
        else if (nibble == 3)
            printchar(0x33);
        else if (nibble == 4)
            printchar(0x34);
        else if (nibble == 5)
            printchar(0x35);
        else if (nibble == 6)
            printchar(0x36);
        else if (nibble == 7)
            printchar(0x37);
        else if (nibble == 8)
            printchar(0x38);
        else if (nibble == 9)
            printchar(0x39);
        else if (nibble == 10)
            printchar(0x61);
        else if (nibble == 11)
            printchar(0x62);
        else if (nibble == 12)
            printchar(0x63);
        else if (nibble == 13)
            printchar(0x64);
        else if (nibble == 14)
            printchar(0x65);
        else if (nibble == 15)
            printchar(0x66);
        else
            assertIsAKeyword();
    }
    return 0;
}


// Section 4.1.1 SHA-1 Functions
int Ch(int x, int y, int z) {
    return (x & y) ^ (~x & z);
}
int Parity(int x, int y, int z) {
    return x ^ y ^ z;
}
int Maj(int x, int y, int z) {
    return (x & y) ^ (x & z) ^ (y & z);
}
int f(int t, int x, int y, int z) {
    if (0 <= t && t <= 19) {
        return Ch(x, y, z);
    } else if (20 <= t && t <= 39) {
        return Parity(x, y, z);
    } else if (40 <= t && t <= 59) {
        return Maj(x, y, z);
    } else if (60 <= t && t <= 79) {
        return Parity(x, y, z);
    } else {
        assertIsAKeyword();
        return 0;
    }
}
int ROTL(int n, int x) {
    int mask = 0x7fffffff >> (31 - n);
    return (x << n) | ((x >> (32 - n)) & mask);
}

// Section 4.2.1 SHA-1 Constants
int K(int t) {
    if (0 <= t && t <= 19) {
        return 0x5a827999;
    } else if (20 <= t && t <= 39) {
        return 0x6ed9eba1;
    } else if (40 <= t && t <= 59) {
        return 0x8f1bbcdc;
    } else if (60 <= t && t <= 79) {
        return 0xca62c1d6;
    } else {
        assertIsAKeyword();
    }
    return 0;
}

// Section 6.1.1 SHA-1 Preprocessing
// Section 6.1.2 SHA-1 Hash Computation
int main() {
    bool lastBlock = false;
    bool pastEOF = false;
    bool inLength = false;
    int inputSize = 0;
    int bytesRead = 0;

    int H0 = 0x67452301;
    int H1 = 0xefcdab89;
    int H2 = 0x98badcfe;
    int H3 = 0x10325476;
    int H4 = 0xc3d2e1f0;

    while (!lastBlock) {
        // 1. Prepare the message schedule
        int W00; { W00 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W00 = (W00 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W00 = (W00 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W00 = (W00 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W00 = (W00 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W00 = (W00 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W00 = W00 << 8; } } else { W00 = W00 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W00 = (W00 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W00 = (W00 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W01; { W01 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W01 = (W01 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W01 = (W01 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W01 = (W01 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W01 = (W01 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W01 = (W01 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W01 = W01 << 8; } } else { W01 = W01 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W01 = (W01 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W01 = (W01 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W02; { W02 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W02 = (W02 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W02 = (W02 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W02 = (W02 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W02 = (W02 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W02 = (W02 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W02 = W02 << 8; } } else { W02 = W02 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W02 = (W02 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W02 = (W02 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W03; { W03 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W03 = (W03 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W03 = (W03 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W03 = (W03 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W03 = (W03 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W03 = (W03 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W03 = W03 << 8; } } else { W03 = W03 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W03 = (W03 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W03 = (W03 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W04; { W04 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W04 = (W04 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W04 = (W04 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W04 = (W04 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W04 = (W04 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W04 = (W04 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W04 = W04 << 8; } } else { W04 = W04 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W04 = (W04 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W04 = (W04 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W05; { W05 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W05 = (W05 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W05 = (W05 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W05 = (W05 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W05 = (W05 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W05 = (W05 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W05 = W05 << 8; } } else { W05 = W05 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W05 = (W05 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W05 = (W05 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W06; { W06 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W06 = (W06 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W06 = (W06 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W06 = (W06 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W06 = (W06 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W06 = (W06 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W06 = W06 << 8; } } else { W06 = W06 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W06 = (W06 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W06 = (W06 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W07; { W07 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W07 = (W07 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W07 = (W07 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W07 = (W07 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W07 = (W07 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W07 = (W07 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W07 = W07 << 8; } } else { W07 = W07 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W07 = (W07 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W07 = (W07 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W08; { W08 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W08 = (W08 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W08 = (W08 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W08 = (W08 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W08 = (W08 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W08 = (W08 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W08 = W08 << 8; } } else { W08 = W08 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W08 = (W08 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W08 = (W08 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W09; { W09 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W09 = (W09 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W09 = (W09 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W09 = (W09 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W09 = (W09 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W09 = (W09 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W09 = W09 << 8; } } else { W09 = W09 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W09 = (W09 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W09 = (W09 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W10; { W10 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W10 = (W10 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W10 = (W10 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W10 = (W10 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W10 = (W10 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W10 = (W10 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W10 = W10 << 8; } } else { W10 = W10 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W10 = (W10 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W10 = (W10 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W11; { W11 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W11 = (W11 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W11 = (W11 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W11 = (W11 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W11 = (W11 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W11 = (W11 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W11 = W11 << 8; } } else { W11 = W11 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W11 = (W11 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W11 = (W11 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W12; { W12 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W12 = (W12 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W12 = (W12 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W12 = (W12 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W12 = (W12 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W12 = (W12 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W12 = W12 << 8; } } else { W12 = W12 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W12 = (W12 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W12 = (W12 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W13; { W13 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W13 = (W13 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W13 = (W13 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W13 = (W13 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W13 = (W13 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W13 = (W13 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W13 = W13 << 8; } } else { W13 = W13 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W13 = (W13 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W13 = (W13 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W14; { W14 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W14 = (W14 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W14 = (W14 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W14 = (W14 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W14 = (W14 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W14 = (W14 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W14 = W14 << 8; } } else { W14 = W14 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W14 = (W14 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W14 = (W14 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W15; { W15 = 0; for (int read32_i = 0; read32_i < 4; read32_i++) { if (eof()) { if (pastEOF) { if (inLength) { if (bytesRead % 64 == 59) { W15 = (W15 << 8) | ((inputSize >> 29) & 0xff); } else if (bytesRead % 64 == 60) { W15 = (W15 << 8) | ((inputSize >> 21) & 0xff); } else if (bytesRead % 64 == 61) { W15 = (W15 << 8) | ((inputSize >> 13) & 0xff); } else if (bytesRead % 64 == 62) { W15 = (W15 << 8) | ((inputSize >> 5) & 0xff); } else if (bytesRead % 64 == 63) { W15 = (W15 << 8) | ((inputSize << 3) & 0xff); lastBlock = true; } else { W15 = W15 << 8; } } else { W15 = W15 << 8; inLength = (bytesRead + 1) % 64 == 0; } } else { W15 = (W15 << 8) | 0x80; pastEOF = true; inLength = (bytesRead + 1) % 64 <= 56; } } else { W15 = (W15 << 8) | readchar(); inputSize++; } bytesRead++; }} true;
        int W16 = ROTL(1, W13 ^ W08 ^ W02 ^ W00);
        int W17 = ROTL(1, W14 ^ W09 ^ W03 ^ W01);
        int W18 = ROTL(1, W15 ^ W10 ^ W04 ^ W02);
        int W19 = ROTL(1, W16 ^ W11 ^ W05 ^ W03);
        int W20 = ROTL(1, W17 ^ W12 ^ W06 ^ W04);
        int W21 = ROTL(1, W18 ^ W13 ^ W07 ^ W05);
        int W22 = ROTL(1, W19 ^ W14 ^ W08 ^ W06);
        int W23 = ROTL(1, W20 ^ W15 ^ W09 ^ W07);
        int W24 = ROTL(1, W21 ^ W16 ^ W10 ^ W08);
        int W25 = ROTL(1, W22 ^ W17 ^ W11 ^ W09);
        int W26 = ROTL(1, W23 ^ W18 ^ W12 ^ W10);
        int W27 = ROTL(1, W24 ^ W19 ^ W13 ^ W11);
        int W28 = ROTL(1, W25 ^ W20 ^ W14 ^ W12);
        int W29 = ROTL(1, W26 ^ W21 ^ W15 ^ W13);
        int W30 = ROTL(1, W27 ^ W22 ^ W16 ^ W14);
        int W31 = ROTL(1, W28 ^ W23 ^ W17 ^ W15);
        int W32 = ROTL(1, W29 ^ W24 ^ W18 ^ W16);
        int W33 = ROTL(1, W30 ^ W25 ^ W19 ^ W17);
        int W34 = ROTL(1, W31 ^ W26 ^ W20 ^ W18);
        int W35 = ROTL(1, W32 ^ W27 ^ W21 ^ W19);
        int W36 = ROTL(1, W33 ^ W28 ^ W22 ^ W20);
        int W37 = ROTL(1, W34 ^ W29 ^ W23 ^ W21);
        int W38 = ROTL(1, W35 ^ W30 ^ W24 ^ W22);
        int W39 = ROTL(1, W36 ^ W31 ^ W25 ^ W23);
        int W40 = ROTL(1, W37 ^ W32 ^ W26 ^ W24);
        int W41 = ROTL(1, W38 ^ W33 ^ W27 ^ W25);
        int W42 = ROTL(1, W39 ^ W34 ^ W28 ^ W26);
        int W43 = ROTL(1, W40 ^ W35 ^ W29 ^ W27);
        int W44 = ROTL(1, W41 ^ W36 ^ W30 ^ W28);
        int W45 = ROTL(1, W42 ^ W37 ^ W31 ^ W29);
        int W46 = ROTL(1, W43 ^ W38 ^ W32 ^ W30);
        int W47 = ROTL(1, W44 ^ W39 ^ W33 ^ W31);
        int W48 = ROTL(1, W45 ^ W40 ^ W34 ^ W32);
        int W49 = ROTL(1, W46 ^ W41 ^ W35 ^ W33);
        int W50 = ROTL(1, W47 ^ W42 ^ W36 ^ W34);
        int W51 = ROTL(1, W48 ^ W43 ^ W37 ^ W35);
        int W52 = ROTL(1, W49 ^ W44 ^ W38 ^ W36);
        int W53 = ROTL(1, W50 ^ W45 ^ W39 ^ W37);
        int W54 = ROTL(1, W51 ^ W46 ^ W40 ^ W38);
        int W55 = ROTL(1, W52 ^ W47 ^ W41 ^ W39);
        int W56 = ROTL(1, W53 ^ W48 ^ W42 ^ W40);
        int W57 = ROTL(1, W54 ^ W49 ^ W43 ^ W41);
        int W58 = ROTL(1, W55 ^ W50 ^ W44 ^ W42);
        int W59 = ROTL(1, W56 ^ W51 ^ W45 ^ W43);
        int W60 = ROTL(1, W57 ^ W52 ^ W46 ^ W44);
        int W61 = ROTL(1, W58 ^ W53 ^ W47 ^ W45);
        int W62 = ROTL(1, W59 ^ W54 ^ W48 ^ W46);
        int W63 = ROTL(1, W60 ^ W55 ^ W49 ^ W47);
        int W64 = ROTL(1, W61 ^ W56 ^ W50 ^ W48);
        int W65 = ROTL(1, W62 ^ W57 ^ W51 ^ W49);
        int W66 = ROTL(1, W63 ^ W58 ^ W52 ^ W50);
        int W67 = ROTL(1, W64 ^ W59 ^ W53 ^ W51);
        int W68 = ROTL(1, W65 ^ W60 ^ W54 ^ W52);
        int W69 = ROTL(1, W66 ^ W61 ^ W55 ^ W53);
        int W70 = ROTL(1, W67 ^ W62 ^ W56 ^ W54);
        int W71 = ROTL(1, W68 ^ W63 ^ W57 ^ W55);
        int W72 = ROTL(1, W69 ^ W64 ^ W58 ^ W56);
        int W73 = ROTL(1, W70 ^ W65 ^ W59 ^ W57);
        int W74 = ROTL(1, W71 ^ W66 ^ W60 ^ W58);
        int W75 = ROTL(1, W72 ^ W67 ^ W61 ^ W59);
        int W76 = ROTL(1, W73 ^ W68 ^ W62 ^ W60);
        int W77 = ROTL(1, W74 ^ W69 ^ W63 ^ W61);
        int W78 = ROTL(1, W75 ^ W70 ^ W64 ^ W62);
        int W79 = ROTL(1, W76 ^ W71 ^ W65 ^ W63);

        // 2. Initialize the five working variables
        int a = H0;
        int b = H1;
        int c = H2;
        int d = H3;
        int e = H4;
        int T;

        // 3. Do the loop
        { T = ROTL(5, a) + f(0, b, c, d) + e + K(0) + W00; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(1, b, c, d) + e + K(1) + W01; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(2, b, c, d) + e + K(2) + W02; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(3, b, c, d) + e + K(3) + W03; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(4, b, c, d) + e + K(4) + W04; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(5, b, c, d) + e + K(5) + W05; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(6, b, c, d) + e + K(6) + W06; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(7, b, c, d) + e + K(7) + W07; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(8, b, c, d) + e + K(8) + W08; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(9, b, c, d) + e + K(9) + W09; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(10, b, c, d) + e + K(10) + W10; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(11, b, c, d) + e + K(11) + W11; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(12, b, c, d) + e + K(12) + W12; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(13, b, c, d) + e + K(13) + W13; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(14, b, c, d) + e + K(14) + W14; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(15, b, c, d) + e + K(15) + W15; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(16, b, c, d) + e + K(16) + W16; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(17, b, c, d) + e + K(17) + W17; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(18, b, c, d) + e + K(18) + W18; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(19, b, c, d) + e + K(19) + W19; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(20, b, c, d) + e + K(20) + W20; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(21, b, c, d) + e + K(21) + W21; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(22, b, c, d) + e + K(22) + W22; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(23, b, c, d) + e + K(23) + W23; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(24, b, c, d) + e + K(24) + W24; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(25, b, c, d) + e + K(25) + W25; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(26, b, c, d) + e + K(26) + W26; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(27, b, c, d) + e + K(27) + W27; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(28, b, c, d) + e + K(28) + W28; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(29, b, c, d) + e + K(29) + W29; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(30, b, c, d) + e + K(30) + W30; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(31, b, c, d) + e + K(31) + W31; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(32, b, c, d) + e + K(32) + W32; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(33, b, c, d) + e + K(33) + W33; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(34, b, c, d) + e + K(34) + W34; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(35, b, c, d) + e + K(35) + W35; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(36, b, c, d) + e + K(36) + W36; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(37, b, c, d) + e + K(37) + W37; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(38, b, c, d) + e + K(38) + W38; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(39, b, c, d) + e + K(39) + W39; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(40, b, c, d) + e + K(40) + W40; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(41, b, c, d) + e + K(41) + W41; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(42, b, c, d) + e + K(42) + W42; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(43, b, c, d) + e + K(43) + W43; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(44, b, c, d) + e + K(44) + W44; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(45, b, c, d) + e + K(45) + W45; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(46, b, c, d) + e + K(46) + W46; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(47, b, c, d) + e + K(47) + W47; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(48, b, c, d) + e + K(48) + W48; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(49, b, c, d) + e + K(49) + W49; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(50, b, c, d) + e + K(50) + W50; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(51, b, c, d) + e + K(51) + W51; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(52, b, c, d) + e + K(52) + W52; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(53, b, c, d) + e + K(53) + W53; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(54, b, c, d) + e + K(54) + W54; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(55, b, c, d) + e + K(55) + W55; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(56, b, c, d) + e + K(56) + W56; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(57, b, c, d) + e + K(57) + W57; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(58, b, c, d) + e + K(58) + W58; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(59, b, c, d) + e + K(59) + W59; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(60, b, c, d) + e + K(60) + W60; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(61, b, c, d) + e + K(61) + W61; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(62, b, c, d) + e + K(62) + W62; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(63, b, c, d) + e + K(63) + W63; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(64, b, c, d) + e + K(64) + W64; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(65, b, c, d) + e + K(65) + W65; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(66, b, c, d) + e + K(66) + W66; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(67, b, c, d) + e + K(67) + W67; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(68, b, c, d) + e + K(68) + W68; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(69, b, c, d) + e + K(69) + W69; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(70, b, c, d) + e + K(70) + W70; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(71, b, c, d) + e + K(71) + W71; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(72, b, c, d) + e + K(72) + W72; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(73, b, c, d) + e + K(73) + W73; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(74, b, c, d) + e + K(74) + W74; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(75, b, c, d) + e + K(75) + W75; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(76, b, c, d) + e + K(76) + W76; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(77, b, c, d) + e + K(77) + W77; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(78, b, c, d) + e + K(78) + W78; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;
        { T = ROTL(5, a) + f(79, b, c, d) + e + K(79) + W79; e = d; d = c; c = ROTL(30, b); b = a; a = T;} true;

        // 4. Compute the next intermediate hash value
        H0 += a;
        H1 += b;
        H2 += c;
        H3 += d;
        H4 += e;
    }

    // And dump out the hash like sha1sum(1)
    printhexPrints0x(H0);
    printhexPrints0x(H1);
    printhexPrints0x(H2);
    printhexPrints0x(H3);
    printhexPrints0x(H4);
    printchar(0x20);
    printchar(0x20);
    printchar(0x2d);
    printchar(0x0a);
    return 0;
}
