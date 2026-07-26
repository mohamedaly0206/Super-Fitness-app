import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

part 'exercise_dto.g.dart';

@JsonSerializable()
class ExerciseDto {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "exercise")
  String? exercise;

  @JsonKey(name: "short_youtube_demonstration")
  String? shortYoutubeDemonstration;

  @JsonKey(name: "in_depth_youtube_explanation")
  String? inDepthYoutubeExplanation;

  @JsonKey(name: "difficulty_level")
  String? difficultyLevel;

  @JsonKey(name: "target_muscle_group")
  String? targetMuscleGroup;

  @JsonKey(name: "prime_mover_muscle")
  String? primeMoverMuscle;

  @JsonKey(name: "secondary_muscle")
  String? secondaryMuscle;

  @JsonKey(name: "tertiary_muscle")
  String? tertiaryMuscle;

  @JsonKey(name: "primary_equipment")
  String? primaryEquipment;

  @JsonKey(name: "_primary_items")
  int? primaryItems;

  @JsonKey(name: "secondary_equipment")
  String? secondaryEquipment;

  @JsonKey(name: "_secondary_items")
  int? secondaryItems;

  @JsonKey(name: "posture")
  String? posture;

  @JsonKey(name: "single_or_double_arm")
  String? singleOrDoubleArm;

  @JsonKey(name: "continuous_or_alternating_arms")
  String? continuousOrAlternatingArms;

  @JsonKey(name: "grip")
  String? grip;

  @JsonKey(name: "load_position_ending")
  String? loadPositionEnding;

  @JsonKey(name: "continuous_or_alternating_legs")
  String? continuousOrAlternatingLegs;

  @JsonKey(name: "foot_elevation")
  String? footElevation;

  @JsonKey(name: "combination_exercises")
  String? combinationExercises;

  @JsonKey(name: "movement_pattern_1")
  String? movementPattern1;

  @JsonKey(name: "movement_pattern_2")
  String? movementPattern2;

  @JsonKey(name: "movement_pattern_3")
  String? movementPattern3;

  @JsonKey(name: "plane_of_motion_1")
  String? planeOfMotion1;

  @JsonKey(name: "plane_of_motion_2")
  String? planeOfMotion2;

  @JsonKey(name: "plane_of_motion_3")
  String? planeOfMotion3;

  @JsonKey(name: "body_region")
  String? bodyRegion;

  @JsonKey(name: "force_type")
  String? forceType;

  @JsonKey(name: "mechanics")
  String? mechanics;

  @JsonKey(name: "laterality")
  String? laterality;

  @JsonKey(name: "primary_exercise_classification")
  String? primaryExerciseClassification;

  @JsonKey(name: "short_youtube_demonstration_link")
  String? shortYoutubeDemonstrationLink;

  @JsonKey(name: "in_depth_youtube_explanation_link")
  String? inDepthYoutubeExplanationLink;

  ExerciseDto({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  factory ExerciseDto.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDtoToJson(this);

  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id ?? "",
      exercise: exercise ?? "",
      shortYoutubeDemonstration: shortYoutubeDemonstration ?? "",
      inDepthYoutubeExplanation: inDepthYoutubeExplanation ?? "",
      difficultyLevel: difficultyLevel ?? "",
      targetMuscleGroup: targetMuscleGroup ?? "",
      primeMoverMuscle: primeMoverMuscle ?? "",
      secondaryMuscle: secondaryMuscle ?? "",
      tertiaryMuscle: tertiaryMuscle ?? "",
      primaryEquipment: primaryEquipment ?? "",
      primaryItems: primaryItems ?? 0,
      secondaryEquipment: secondaryEquipment ?? "",
      secondaryItems: secondaryItems ?? 0,
      posture: posture ?? "",
      singleOrDoubleArm: singleOrDoubleArm ?? "",
      continuousOrAlternatingArms: continuousOrAlternatingArms ?? "",
      grip: grip ?? "",
      loadPositionEnding: loadPositionEnding ?? "",
      continuousOrAlternatingLegs: continuousOrAlternatingLegs ?? "",
      footElevation: footElevation ?? "",
      combinationExercises: combinationExercises ?? "",
      movementPattern1: movementPattern1 ?? "",
      movementPattern2: movementPattern2 ?? "",
      movementPattern3: movementPattern3 ?? "",
      planeOfMotion1: planeOfMotion1 ?? "",
      planeOfMotion2: planeOfMotion2 ?? "",
      planeOfMotion3: planeOfMotion3 ?? "",
      bodyRegion: bodyRegion ?? "",
      forceType: forceType ?? "",
      mechanics: mechanics ?? "",
      laterality: laterality ?? "",
      primaryExerciseClassification: primaryExerciseClassification ?? "",
      shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink ?? "",
      inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink ?? "",
    );
  }
}
