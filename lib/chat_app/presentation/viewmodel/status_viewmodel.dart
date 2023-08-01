import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/get_statueses_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/upload_status_usecase.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/generated/l10n.dart';

final statusViewmodelProvider = Provider(
    (ref) => StatusViewmodel(ref.watch(uploadStatusUseCaseProvider), ref, ref.watch(getStatusUseCaseProvider)));

final getStatusFutureProvider = FutureProvider((ref) => ref.watch(statusRepositoryProvider).getStatuses());
// final addStatusFutureProvider = FutureProvider((ref){
//      ref.watch(userInfoProvider).whenData((data) async {
//       ref.watch(uploadStatusUseCaseProvider)(UploadStatusParams(
//         username: data!.name,
//         profilePic: data.profilePic,
//         phoneNumber: data.phoneNumber,
//         statusImage: file,
//         caption: caption,
//       ));

//     });
//   ref.watch(statusRepositoryProvider).uploadStatus();
// });

class StatusViewmodel {
  final UploadStatusUseCase _uploadStatusUseCase;
  final GetStatusUseCase _getStatusUseCase;
  final Ref _ref;

  StatusViewmodel(this._uploadStatusUseCase, this._ref, this._getStatusUseCase);

  Future<void> addStatus(File file, String caption) async {
    // _ref.watch(userInfoProvider).whenData();

    _ref.watch(userInfoProvider).when(
          data: (data) async {
            // await _uploadStatusUseCase(UploadStatusParams(
            //   username: data!.name,
            //   profilePic: data.profilePic,
            //   phoneNumber: data.phoneNumber,
            //   statusImage: file,
            //   caption: caption,
            // ));
            if (data == null) {
              showSnackBar(content: S.current.somethingWentWrong);

              return;
            }
            final result = await _uploadStatusUseCase(UploadStatusParams(
              username: data.name,
              profilePic: data.profilePic,
              phoneNumber: data.phoneNumber,
              statusImage: file,
              caption: caption,
            ));

            result.fold(
              (fail) {
                showSnackBar(content: fail.message);
              },
              (success) {
                showSnackBar(content: 'Status sent successfully');
              },
            );
          },
          error: (err, st) {
            showSnackBar(content: err.toString());
          },
          loading: () => Loader(),
        );
  }

  Future<List<StatusEntity>> getStatuses() async {
    final result = await _getStatusUseCase(const NoParameters());

    return result.fold((failure) {
      showSnackBar(content: failure.message);
      return [];
    }, (data) {
      return data;
    });
  }
}
