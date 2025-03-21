class AppealStatusHelper {
  static Map<String, AppealStatus> appealStatusMap = {
    "В ожидании приема": AppealStatus.waiting,
    "Исполнено": AppealStatus.completed,
    "Отклонено": AppealStatus.rejected,
    "Назначен прием": AppealStatus.appoinment,
  };

  static Map<AppealStatus, Color> statusColors = {
    AppealStatus.waiting: ColorStyles.lightBlueColor.withValues(alpha: 0.15),
    AppealStatus.completed: const Color(0xff02BA18).withValues(alpha: 0.15),
    AppealStatus.rejected: const Color(0xffD90707).withValues(alpha: 0.15),
    AppealStatus.appoinment: ColorStyles.lightBlueColor.withValues(alpha: 0.15),
  };

  static Map<AppealStatus, Color> textColors = {
    AppealStatus.waiting: ColorStyles.lightBlueColor,
    AppealStatus.completed: const Color(0xff02BA18),
    AppealStatus.rejected: const Color(0xffD90707),
    AppealStatus.appoinment: ColorStyles.lightBlueColor,
  };

  static AppealStatus? getStatus(String status) {
    return appealStatusMap[status];
  }
}
