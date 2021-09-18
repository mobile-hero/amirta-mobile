import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/repository/pengaduan_repository.dart';

class PanicNewBloc extends ComplaintListBloc {
  PanicNewBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.panic,
          ComplaintStatus.newItem,
        );
}

class PanicRejectedBloc extends ComplaintListBloc {
  PanicRejectedBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.panic,
          ComplaintStatus.rejected,
        );
}

class PanicInProcessBloc extends ComplaintListBloc {
  PanicInProcessBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.panic,
          ComplaintStatus.inProcess,
        );
}

class PanicCompletedBloc extends ComplaintListBloc {
  PanicCompletedBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.panic,
          ComplaintStatus.completed,
        );
}
