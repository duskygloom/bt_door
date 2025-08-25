class Configuration {
  static const doorService = ['d78a7130-f933-45f2-91ba-12682b2b0e94'];

  static const doorCharacteristics = {
    '59c38ef3-0ce7-4bbb-b9a4-3b6b66c2ad9c': {
      'name': 'Receiver',
      'type': 'READ',
    },
    '22c46df2-58e0-4982-97d7-b6ce6f4fb707': {'name': 'Sender', 'type': 'WRITE'},
  };

  static const timeoutDur = Duration(seconds: 4);
}
