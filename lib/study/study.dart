/*
* /* 반드시 공부해야 할 내용 */
            // GetX에서는 Rx 타입의 값이 변경될 때 자동으로 관련 위젯들을 리빌드. add, remove도 무조건 리빌드를 시킨다. 그게 싫으면 아래처럼 .value로 하자
            // controller.selectedNoDate.remove(selectedDate); --> 이렇게 쓰면 바로바로 리빌드 됨.
            if (widget.selectedDate != null) {
              if (widget.controller.noReserveDate.contains(widget.selectedDate)) {
                widget.controller.noReserveDate.value.remove(widget.selectedDate);
              } else {
                widget.controller.noReserveDate.value.add(widget.selectedDate!);
              }
            }

            // upsert : true 없으면 만들고 있으면 덮어씀 파베에서 set
            final WriteResult? result =
                await QuizAppDatabaseService.I.getConnection()?.collection('noReserveDate').updateOne(
                      where.eq('_id', 'noReserveDate'),
                      modify.set('noReserveDate', widget.controller.noReserveDate),
                      upsert: true,
                    );
            final noReserveDateDoc = await QuizAppDatabaseService.I
                .getConnection()
                ?.collection('noReserveDate')
                .findOne(where.eq('_id', 'noReserveDate'));
            final noReserveDateListUtc = noReserveDateDoc!['noReserveDate'] as List<dynamic>;
            final noReserveDateList = noReserveDateListUtc.map((e) => e.toLocal()).toList();
            // 이게 가능한 이유는 RxList -> List -> Iterable 이런식으로 되기 때문이다
            widget.controller.noReserveDate.value = List.from(noReserveDateList);
            debugPrint('result : ${result!.document.toString()}');*/