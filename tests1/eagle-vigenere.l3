//test return 0
int keychar(int index) {
  if (index % 7 == 0)
    return 100;
  else if (index % 7 == 1)
    return 105;
  else if (index % 7 == 2)
    return 99;
  else if (index % 7 == 3)
    return 107;
  else if (index % 7 == 4)
    return 101;
  else if (index % 7 == 5)
    return 110;
  else
    return 115;
}

int main() {
  int key_index = 0;
  /* Read the input and decrypt it as we get it */
  while (!eof()) {
    int c = readchar();
    if (c < 97 || c > 122) {
      printchar(c);
      continue;
    }

    int offset = (c - 97) + 26 - (keychar(key_index) - 97);
    offset %= 26;
    printchar(offset + 97);
    key_index++;
  }

  return 0;
}

