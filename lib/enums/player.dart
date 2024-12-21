enum PlayerAction {
  left,
  right,
  jump,
}

extension PlayerActionExtension on PlayerAction {
  double get value {
    switch (this) {
      case PlayerAction.left:
        return -1;
      case PlayerAction.right:
        return 1;
      case PlayerAction.jump:
        return 99; // 99 refers to jump
    }
  }
}
