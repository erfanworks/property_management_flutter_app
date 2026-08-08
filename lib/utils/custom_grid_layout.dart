import 'package:flutter/material.dart';

double getResponsiveAspectRatio({
  required BuildContext context,
  double ratioAdjuster = 0.0,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Utilize common mobile pixel widths for more granular control
  if (screenWidth < 320) {
    // Extra Small Devices (e.g., old iPhones, very compact Androids)
    return screenWidth / 600 + ratioAdjuster;
  } else if (screenWidth < 375) {
    // Small Devices (e.g., iPhone SE, some compact Androids - 360-374px range)
    return screenWidth / 680 + ratioAdjuster;
  } else if (screenWidth < 414) {
    // Medium Devices (e.g., standard iPhones, many Androids - 375-413px range)
    return screenWidth / 790 + ratioAdjuster;
  } else if (screenWidth < 480) {
    // Larger Phone Devices (e.g., iPhone Plus/Max, larger Androids - 414-479px range)
    return screenWidth / 850 + ratioAdjuster;
  } else if (screenWidth < 600) {
    // Small Tablets / Foldable Phone Inner Screens (portrait)
    return screenWidth / 900 + ratioAdjuster;
  } else if (screenWidth < 768) {
    // Medium Tablets (e.g., iPad Mini - portrait)
    return screenWidth / 1000 + ratioAdjuster;
  } else if (screenWidth < 1024) {
    // Large Tablets (e.g., iPad - portrait, many laptops)
    return screenWidth / 1200 + ratioAdjuster;
  } else {
    // Desktops and very Large Tablets (landscape)
    return screenWidth / 1400 + ratioAdjuster;
  }
}

double getResponsiveCrossAxisSpacing({
  required BuildContext context,
  double baseSpacing = 15, // A sensible default base value
  double spacingAdjuster = 0.0,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 320) {
    // Extra Small Devices
    return baseSpacing * 0.4 + spacingAdjuster;
  } else if (screenWidth < 375) {
    // Small Devices
    return baseSpacing * 0.75 + spacingAdjuster;
  } else if (screenWidth < 414) {
    // Medium Devices (standard phones)
    return baseSpacing + spacingAdjuster;
  } else if (screenWidth < 480) {
    // Larger Phone Devices
    return baseSpacing * 1.05 + spacingAdjuster;
  } else if (screenWidth < 600) {
    // Small Tablets / Foldable Phone Inner Screens (portrait)
    return baseSpacing * 1.5 + spacingAdjuster;
  } else if (screenWidth < 768) {
    // Medium Tablets (e.g., iPad Mini - portrait)
    return baseSpacing * 2.0 + spacingAdjuster;
  } else if (screenWidth < 1024) {
    // Large Tablets (e.g., iPad - portrait)
    return baseSpacing * 2.5 + spacingAdjuster;
  } else if (screenWidth < 1440) {
    // Desktop screens
    return baseSpacing * 3.0 + spacingAdjuster;
  } else if (screenWidth < 1920) {
    // Large desktop screens (HD)
    return baseSpacing * 3.5 + spacingAdjuster;
  } else {
    // Very Large desktops (4K)
    return baseSpacing * 4.0 + spacingAdjuster;
  }
}

// REFINED: Custom function for responsive mainAxisSpacing
double getResponsiveMainAxisSpacing({
  required BuildContext context,
  double baseSpacing = 24.0, // A sensible default base value
  double spacingAdjuster = 0.0,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 320) {
    // Extra Small Devices
    return baseSpacing * 0.5 + spacingAdjuster;
  } else if (screenWidth < 375) {
    // Small Devices
    return baseSpacing * 0.8 + spacingAdjuster;
  } else if (screenWidth < 414) {
    // Medium Devices (standard phones)
    return baseSpacing + spacingAdjuster;
  } else if (screenWidth < 480) {
    // Larger Phone Devices
    return baseSpacing * 1.1 + spacingAdjuster;
  } else if (screenWidth < 600) {
    // Small Tablets / Foldable Phone Inner Screens (portrait)
    return baseSpacing * 1.4 + spacingAdjuster;
  } else if (screenWidth < 768) {
    // Medium Tablets (e.g., iPad Mini - portrait)
    return baseSpacing * 1.8 + spacingAdjuster;
  } else if (screenWidth < 1024) {
    // Large Tablets (e.g., iPad - portrait)
    return baseSpacing * 2.2 + spacingAdjuster;
  } else if (screenWidth < 1440) {
    // Desktop screens
    return baseSpacing * 2.6 + spacingAdjuster;
  } else if (screenWidth < 1920) {
    // Large desktop screens (HD)
    return baseSpacing * 3.0 + spacingAdjuster;
  } else {
    // Very Large desktops (4K)
    return baseSpacing * 3.4 + spacingAdjuster;
  }
}

double getResponsiveScale({
  required BuildContext context,
  double baseScale =
      1.0, // The default scale for 'medium' devices (e.g., 400px wide)
  double scaleAdjuster = 0.0, // For fine-tuning if needed
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 320) {
    // Extra Small Devices (e.g., old iPhones, very compact Androids)
    return baseScale * 0.85 + scaleAdjuster; // Scale down significantly
  } else if (screenWidth < 375) {
    // Small Devices (e.g., iPhone SE, some compact Androids - 360-374px range)
    return baseScale * 0.98 + scaleAdjuster; // Slightly smaller than base
  } else if (screenWidth < 414) {
    // Medium Devices (e.g., standard iPhones, many Androids - 375-413px range)
    return baseScale +
        scaleAdjuster; // This is typically your ideal design scale (1.0)
  } else if (screenWidth < 480) {
    // Larger Phone Devices (e.g., iPhone Plus/Max, larger Androids - 414-479px range)
    return baseScale * 1.0 + scaleAdjuster; // Slightly larger than base
  } else if (screenWidth < 600) {
    // Small Tablets / Foldable Phone Inner Screens (portrait)
    return baseScale * 1.10 + scaleAdjuster; // Moderate scaling up
  } else if (screenWidth < 768) {
    // Medium Tablets (e.g., iPad Mini - portrait)
    return baseScale * 1.15 + scaleAdjuster; // More scaling up
  } else if (screenWidth < 1024) {
    // Large Tablets (e.g., iPad - portrait, many laptops)
    return baseScale * 1.20 + scaleAdjuster; // Significant scaling up
  } else {
    // Desktops and very Large Tablets (landscape)
    return baseScale * 1.25 + scaleAdjuster; // Max scaling
  }
}
