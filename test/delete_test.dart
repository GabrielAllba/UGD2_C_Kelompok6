import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ugd2_c_kelompok6/client/PemesananClient.dart';

import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';

// Mock class for PemesananClient
class MockPemesananClient extends Mock implements PemesananClient {
  @override
  Future<void> destroy(int id) async {}

  @override
  Future<void> refresh() async {}
}

void main() {
  testWidgets('Delete Widget Test', (WidgetTester tester) async {
    // Mock PemesananClient
    final mockClient = MockPemesananClient();

    // Build our app and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Pemesanan(id_user: 1),
      ),
    );

    // Trigger delete button tap
    final deleteButtonFinder = find.byKey(Key('delete_button'));
    await tester.tap(deleteButtonFinder);

    // Wait for animations and async tasks to complete
    await tester.pumpAndSettle();

    // Verify that PemesananClient.destroy was called
    verify(mockClient.destroy(1)).called(1);

    // Verify that the refresh method was called after deletion
    verify(mockClient.refresh()).called(1);

    // Validate that the item is removed from the list
    expect(find.text('Standard Room'), findsNothing);
  });
}
