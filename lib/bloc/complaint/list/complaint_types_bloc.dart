import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/repository/pengaduan_repository.dart';

class ComplaintNewBloc extends ComplaintListBloc {
  ComplaintNewBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.complaint,
          ComplaintStatus.newItem,
        );
}

class ComplaintRejectedBloc extends ComplaintListBloc {
  ComplaintRejectedBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.complaint,
          ComplaintStatus.rejected,
        );
}

class ComplaintInProcessBloc extends ComplaintListBloc {
  ComplaintInProcessBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.complaint,
          ComplaintStatus.inProcess,
        );
}

class ComplaintCompletedBloc extends ComplaintListBloc {
  ComplaintCompletedBloc(PengaduanRepository pengaduanRepository)
      : super(
          pengaduanRepository,
          ComplaintType.complaint,
          ComplaintStatus.completed,
        );
}
