class AllProjectResponseModel {
  int? id;
  String? startDate;
  String? endDate;
  int? startDayOfYear;
  int? endDayOfYear;
  String? projectName;
  String? projectUpdate;
  String? assignedEngineer;
  String? assignedTechnician;
  int? duration;

  AllProjectResponseModel(
      {this.id,
        this.startDate,
        this.endDate,
        this.startDayOfYear,
        this.endDayOfYear,
        this.projectName,
        this.projectUpdate,
        this.assignedEngineer,
        this.assignedTechnician,
        this.duration});

  AllProjectResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startDayOfYear = json['start_day_of_year'];
    endDayOfYear = json['end_day_of_year'];
    projectName = json['project_name'];
    projectUpdate = json['project_update'];
    assignedEngineer = json['assigned_engineer'];
    assignedTechnician = json['assigned_technician'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_day_of_year'] = startDayOfYear;
    data['end_day_of_year'] = endDayOfYear;
    data['project_name'] = projectName;
    data['project_update'] = projectUpdate;
    data['assigned_engineer'] = assignedEngineer;
    data['assigned_technician'] = assignedTechnician;
    data['duration'] = duration;
    return data;
  }
}
