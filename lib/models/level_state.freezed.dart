// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LevelState {

 Round? get currentRound; int get roundIndex; int get correctlyAnswered; int get totalRounds; LevelPhase get state; int get remainingSeconds; Tonality? get tonality;
/// Create a copy of LevelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelStateCopyWith<LevelState> get copyWith => _$LevelStateCopyWithImpl<LevelState>(this as LevelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelState&&const DeepCollectionEquality().equals(other.currentRound, currentRound)&&(identical(other.roundIndex, roundIndex) || other.roundIndex == roundIndex)&&(identical(other.correctlyAnswered, correctlyAnswered) || other.correctlyAnswered == correctlyAnswered)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.state, state) || other.state == state)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&const DeepCollectionEquality().equals(other.tonality, tonality));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentRound),roundIndex,correctlyAnswered,totalRounds,state,remainingSeconds,const DeepCollectionEquality().hash(tonality));

@override
String toString() {
  return 'LevelState(currentRound: $currentRound, roundIndex: $roundIndex, correctlyAnswered: $correctlyAnswered, totalRounds: $totalRounds, state: $state, remainingSeconds: $remainingSeconds, tonality: $tonality)';
}


}

/// @nodoc
abstract mixin class $LevelStateCopyWith<$Res>  {
  factory $LevelStateCopyWith(LevelState value, $Res Function(LevelState) _then) = _$LevelStateCopyWithImpl;
@useResult
$Res call({
 Round? currentRound, int roundIndex, int correctlyAnswered, int totalRounds, LevelPhase state, int remainingSeconds, Tonality? tonality
});




}
/// @nodoc
class _$LevelStateCopyWithImpl<$Res>
    implements $LevelStateCopyWith<$Res> {
  _$LevelStateCopyWithImpl(this._self, this._then);

  final LevelState _self;
  final $Res Function(LevelState) _then;

/// Create a copy of LevelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentRound = freezed,Object? roundIndex = null,Object? correctlyAnswered = null,Object? totalRounds = null,Object? state = null,Object? remainingSeconds = null,Object? tonality = freezed,}) {
  return _then(_self.copyWith(
currentRound: freezed == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as Round?,roundIndex: null == roundIndex ? _self.roundIndex : roundIndex // ignore: cast_nullable_to_non_nullable
as int,correctlyAnswered: null == correctlyAnswered ? _self.correctlyAnswered : correctlyAnswered // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as LevelPhase,remainingSeconds: null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,tonality: freezed == tonality ? _self.tonality : tonality // ignore: cast_nullable_to_non_nullable
as Tonality?,
  ));
}

}


/// Adds pattern-matching-related methods to [LevelState].
extension LevelStatePatterns on LevelState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelState value)  $default,){
final _that = this;
switch (_that) {
case _LevelState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelState value)?  $default,){
final _that = this;
switch (_that) {
case _LevelState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Round? currentRound,  int roundIndex,  int correctlyAnswered,  int totalRounds,  LevelPhase state,  int remainingSeconds,  Tonality? tonality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelState() when $default != null:
return $default(_that.currentRound,_that.roundIndex,_that.correctlyAnswered,_that.totalRounds,_that.state,_that.remainingSeconds,_that.tonality);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Round? currentRound,  int roundIndex,  int correctlyAnswered,  int totalRounds,  LevelPhase state,  int remainingSeconds,  Tonality? tonality)  $default,) {final _that = this;
switch (_that) {
case _LevelState():
return $default(_that.currentRound,_that.roundIndex,_that.correctlyAnswered,_that.totalRounds,_that.state,_that.remainingSeconds,_that.tonality);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Round? currentRound,  int roundIndex,  int correctlyAnswered,  int totalRounds,  LevelPhase state,  int remainingSeconds,  Tonality? tonality)?  $default,) {final _that = this;
switch (_that) {
case _LevelState() when $default != null:
return $default(_that.currentRound,_that.roundIndex,_that.correctlyAnswered,_that.totalRounds,_that.state,_that.remainingSeconds,_that.tonality);case _:
  return null;

}
}

}

/// @nodoc


class _LevelState implements LevelState {
  const _LevelState({required this.currentRound, required this.roundIndex, required this.correctlyAnswered, required this.totalRounds, required this.state, required this.remainingSeconds, this.tonality});
  

@override final  Round? currentRound;
@override final  int roundIndex;
@override final  int correctlyAnswered;
@override final  int totalRounds;
@override final  LevelPhase state;
@override final  int remainingSeconds;
@override final  Tonality? tonality;

/// Create a copy of LevelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelStateCopyWith<_LevelState> get copyWith => __$LevelStateCopyWithImpl<_LevelState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelState&&const DeepCollectionEquality().equals(other.currentRound, currentRound)&&(identical(other.roundIndex, roundIndex) || other.roundIndex == roundIndex)&&(identical(other.correctlyAnswered, correctlyAnswered) || other.correctlyAnswered == correctlyAnswered)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.state, state) || other.state == state)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&const DeepCollectionEquality().equals(other.tonality, tonality));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentRound),roundIndex,correctlyAnswered,totalRounds,state,remainingSeconds,const DeepCollectionEquality().hash(tonality));

@override
String toString() {
  return 'LevelState(currentRound: $currentRound, roundIndex: $roundIndex, correctlyAnswered: $correctlyAnswered, totalRounds: $totalRounds, state: $state, remainingSeconds: $remainingSeconds, tonality: $tonality)';
}


}

/// @nodoc
abstract mixin class _$LevelStateCopyWith<$Res> implements $LevelStateCopyWith<$Res> {
  factory _$LevelStateCopyWith(_LevelState value, $Res Function(_LevelState) _then) = __$LevelStateCopyWithImpl;
@override @useResult
$Res call({
 Round? currentRound, int roundIndex, int correctlyAnswered, int totalRounds, LevelPhase state, int remainingSeconds, Tonality? tonality
});




}
/// @nodoc
class __$LevelStateCopyWithImpl<$Res>
    implements _$LevelStateCopyWith<$Res> {
  __$LevelStateCopyWithImpl(this._self, this._then);

  final _LevelState _self;
  final $Res Function(_LevelState) _then;

/// Create a copy of LevelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentRound = freezed,Object? roundIndex = null,Object? correctlyAnswered = null,Object? totalRounds = null,Object? state = null,Object? remainingSeconds = null,Object? tonality = freezed,}) {
  return _then(_LevelState(
currentRound: freezed == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as Round?,roundIndex: null == roundIndex ? _self.roundIndex : roundIndex // ignore: cast_nullable_to_non_nullable
as int,correctlyAnswered: null == correctlyAnswered ? _self.correctlyAnswered : correctlyAnswered // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as LevelPhase,remainingSeconds: null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,tonality: freezed == tonality ? _self.tonality : tonality // ignore: cast_nullable_to_non_nullable
as Tonality?,
  ));
}


}

// dart format on
