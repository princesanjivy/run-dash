enum PlayerAction {
  left,
  right,
}

extension PlayerActionExtension on PlayerAction {
  double get value {
    switch (this) {
      case PlayerAction.left:
        return -1;
      case PlayerAction.right:
        return 1;
    }
  }
}
