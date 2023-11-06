class ApplyPostRequest {
  final num post;
  final num cv;
  final String introduction;

  ApplyPostRequest({
    required this.post,
    required this.cv,
    required this.introduction,
  });

  Map<String, dynamic> toJson() => {
        'post': post,
        'cv': cv,
        'introduction': introduction,
      };
}

class GetCandidateApplied {
  final num page;
  final num pageSize;
  final String search;

  const GetCandidateApplied({
    required this.page,
    required this.pageSize,
    required this.search,
  });
}

class CreateContractModel {
  final num contract;
  final String title;
  final String content;
  final num salary;

  const CreateContractModel({
    required this.contract,
    required this.title,
    required this.content,
    required this.salary,
  });

  Map<String, dynamic> toJson() => {
        'contract': contract,
        'title': title,
        'content': content,
        'salary': salary,
      };
}

class GetContractWaitingSign {
  final num page;
  final num pageSize;
  final String search;
  final bool isBusiness;

  const GetContractWaitingSign({
    required this.page,
    required this.pageSize,
    required this.search,
    required this.isBusiness,
  });
}

class GetContractSigned {
  final num page;
  final num pageSize;
  final String search;
  final bool isBusiness;

  const GetContractSigned({
    required this.page,
    required this.pageSize,
    required this.search,
    required this.isBusiness,
  });
}
