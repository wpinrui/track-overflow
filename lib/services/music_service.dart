import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:track_overflow/firebase_options.dart';

class MusicService {
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  static final MusicService _instance = MusicService._internal();

  factory MusicService() {
    return _instance;
  }

  MusicService._internal();

  Future<void> _init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
  }

  /// Fetch all music metadata from Firestore
  Future<List<Map<String, dynamic>>> fetchAllMusicMetadata() async {
    try {
      final querySnapshot = await _firestore.collection('music_metadata').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching music metadata: $e');
      return [];
    }
  }

  /// Upload a music file to Firebase Storage and save metadata in Firestore
  Future<void> uploadMusic(String title, String artist, String filePath) async {
    try {
      // Upload the file to Cloud Storage
      final fileName = filePath.split('/').last;
      final storageRef = _storage.ref('music_files/$fileName');
      await storageRef.putFile(File(filePath));

      // Get the file's download URL
      final downloadUrl = await storageRef.getDownloadURL();

      // Save metadata to Firestore
      await _firestore.collection('music_metadata').add({
        'title': title,
        'artist': artist,
        'file_url': downloadUrl,
        'uploaded_at': DateTime.now().toIso8601String(),
      });

      print('Music uploaded successfully');
    } catch (e) {
      print('Error uploading music: $e');
    }
  }

  /// Fetch playback statistics for a given song
  Future<Map<String, dynamic>?> fetchPlaybackStats(String songId) async {
    try {
      final doc =
          await _firestore.collection('playback_stats').doc(songId).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('Error fetching playback stats: $e');
      return null;
    }
  }

  /// Update playback statistics
  Future<void> updatePlaybackStats(
      String songId, Map<String, dynamic> stats) async {
    try {
      final docRef = _firestore.collection('playback_stats').doc(songId);
      await docRef.set(stats, SetOptions(merge: true));
      print('Playback stats updated');
    } catch (e) {
      print('Error updating playback stats: $e');
    }
  }

  /// Delete a music file and its metadata
  Future<void> deleteMusic(String musicId, String fileUrl) async {
    try {
      // Delete file from Cloud Storage
      final fileRef = _storage.refFromURL(fileUrl);
      await fileRef.delete();

      // Delete metadata from Firestore
      await _firestore.collection('music_metadata').doc(musicId).delete();

      print('Music deleted successfully');
    } catch (e) {
      print('Error deleting music: $e');
    }
  }
}
