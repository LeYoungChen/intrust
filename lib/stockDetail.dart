import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/widgets/k_chart.dart';

class StockDetail extends StatefulWidget {
  final Stock stock;

  StockDetail({
    Key key,
    @required this.stock
  }) : super (key: key);

  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> with TickerProviderStateMixin {

  final List<String> dDates = ["2019-06-06",
    "2019-06-10", "2019-06-11", "2019-06-12", "2019-06-13", "2019-06-14",
    "2019-06-17", "2019-06-18", "2019-06-19", "2019-06-20", "2019-06-21",
    "2019-06-24", "2019-06-25", "2019-06-26", "2019-06-27", "2019-06-28",
    "2019-07-01", "2019-07-02", "2019-07-03", "2019-07-04", "2019-07-05",
    "2019-07-08", "2019-07-09", "2019-07-10", "2019-07-11", "2019-07-12",
    "2019-07-15", "2019-07-16", "2019-07-17", "2019-07-18", "2019-07-19",
    "2019-07-22", "2019-07-23", "2019-07-24", "2019-07-25", "2019-07-26",
    "2019-07-29", "2019-07-30", "2019-07-31", "2019-08-01", "2019-08-02",
    "2019-08-05", "2019-08-06", "2019-08-07", "2019-08-08",
    "2019-08-12", "2019-08-13", "2019-08-14", "2019-08-15", "2019-08-16",
    "2019-08-19", "2019-08-20", "2019-08-21", "2019-08-22", "2019-08-23",
    "2019-08-26", "2019-08-27", "2019-08-28", "2019-08-29", "2019-08-30",
    "2019-09-02", "2019-09-03", "2019-09-04", "2019-09-05", "2019-09-06",
    "2019-09-09", "2019-09-10", "2019-09-11", "2019-09-12",
    "2019-09-16", "2019-09-17", "2019-09-18", "2019-09-19", "2019-09-20",
    "2019-09-23", "2019-09-24", "2019-09-25", "2019-09-26", "2019-09-27",
    "2019-10-01", "2019-10-02", "2019-10-03", "2019-10-04",
    "2019-10-07", "2019-10-08", "2019-10-09",
    "2019-10-14", "2019-10-15", "2019-10-16", "2019-10-17", "2019-10-18",
    "2019-10-21", "2019-10-22", "2019-10-23", "2019-10-24", "2019-10-25",
    "2019-10-28", "2019-10-29", "2019-10-30", "2019-10-31", "2019-11-01",
    "2019-11-04", "2019-11-05", "2019-11-06", "2019-11-07", "2019-11-08",
    "2019-11-11", "2019-11-12", "2019-11-13", "2019-11-14", "2019-11-15",
    "2019-11-18", "2019-11-19", "2019-11-20", "2019-11-21", "2019-11-22",
    "2019-11-25", "2019-11-26", "2019-11-27", "2019-11-28", "2019-11-29",
    "2019-12-02", "2019-12-03", "2019-12-04", "2019-12-05", "2019-12-06",
    "2019-12-09", "2019-12-10", "2019-12-11", "2019-12-12", "2019-12-13",
    "2019-12-16", "2019-12-17", "2019-12-18", "2019-12-19", "2019-12-20",
    "2019-12-23", "2019-12-24", "2019-12-25", "2019-12-26", "2019-12-27",
    "2019-12-30", "2019-12-31", "2020-01-02", "2020-01-03",
    "2020-01-06", "2020-01-07", "2020-01-08", "2020-01-09", "2020-01-10",
    "2020-01-13", "2020-01-14", "2020-01-15", "2020-01-16", "2020-01-17",
    "2020-01-20",
    "2020-01-30", "2020-01-31",
    "2020-02-03", "2020-02-04", "2020-02-05", "2020-02-06", "2020-02-07",
    "2020-02-10", "2020-02-11", "2020-02-12", "2020-02-13", "2020-02-14",
    "2020-02-17", "2020-02-18", "2020-02-19", "2020-02-20", "2020-02-21",
    "2020-02-24", "2020-02-25", "2020-02-26", "2020-02-27",
    "2020-03-02", "2020-03-03", "2020-03-04", "2020-03-05", "2020-03-06",
    "2020-03-09", "2020-03-10", "2020-03-11", "2020-03-12", "2020-03-13",
    "2020-03-16", "2020-03-17", "2020-03-18", "2020-03-19", "2020-03-20",
    "2020-03-23", "2020-03-24", "2020-03-25", "2020-03-26", "2020-03-27",
    "2020-03-30", "2020-03-31", "2020-04-01",
    "2020-04-06", "2020-04-07", "2020-04-08", "2020-04-09", "2020-04-10",
    "2020-04-13", "2020-04-14", "2020-04-15", "2020-04-16", "2020-04-17",
    "2020-04-20", "2020-04-21", "2020-04-22", "2020-04-23", "2020-04-24",
    "2020-04-27", "2020-04-28", "2020-04-29", "2020-04-30",
    "2020-05-04", "2020-05-05", "2020-05-06", "2020-05-07", "2020-05-08",
    "2020-05-11", "2020-05-12", "2020-05-13", "2020-05-14", "2020-05-15",
    "2020-05-18", "2020-05-19", "2020-05-20", "2020-05-21", "2020-05-22",
    "2020-05-25", "2020-05-26", "2020-05-27", "2020-05-28", "2020-05-29",
    "2020-06-01", "2020-06-02","2020-06-03", "2020-06-04", "2020-06-05"];

  final List<String> wDates = [
    "2019-06-10", "2019-06-17", "2019-06-24", "2019-07-01", "2019-07-08",
    "2019-07-15", "2019-07-22", "2019-07-29", "2019-08-05", "2019-08-12",
    "2019-08-19", "2019-08-26", "2019-09-02", "2019-09-09", "2019-09-16",
    "2019-09-23", "2019-10-07", "2019-10-14", "2019-10-21", "2019-10-28",
    "2019-11-04", "2019-11-11", "2019-11-18", "2019-11-25", "2019-12-02",
    "2019-12-09", "2019-12-16", "2019-12-23", "2019-12-30", "2020-01-06",
    "2020-01-13", "2020-01-20", "2020-02-03", "2020-02-10", "2020-02-17",
    "2020-02-24", "2020-03-02", "2020-03-09", "2020-03-16", "2020-03-23",
    "2020-03-30", "2020-04-06", "2020-04-13", "2020-04-20", "2020-04-27",
    "2020-05-04", "2020-05-11", "2020-05-18", "2020-05-25", "2020-06-01"];

  final List<String> mDates = [
    "2019-07-01", "2019-08-01", "2019-09-02", "2019-10-01", "2019-11-01",
    "2019-12-02", "2020-01-02", "2020-02-03", "2020-03-02", "2020-04-01",
    "2020-05-04", "2020-06-01"];

  final List<List<double>> dStockPrices = [
    [23.45, 23.4, 23.3, 23.6], [23.7, 24.35, 23.7, 24.35], [24.4, 24.9, 24.35, 25.1],
    [25.1, 25.2, 24.7, 25.3], [25.0, 25.35, 25.0, 25.4], [25.5, 25.0, 24.9, 25.95],
    [24.8, 24.95, 24.75, 25.25], [25.1, 24.85, 24.85, 25.2], [25.2, 25.25, 25.15, 25.4],
    [25.5, 25.35, 25.3, 25.55], [25.7, 25.95, 25.65, 26.45], [25.75, 25.8, 25.6, 25.95],
    [25.85, 25.3, 25.3, 25.85], [25.25, 25.35, 25.25, 25.5], [25.6, 26.0, 25.55, 26.0],
    [26.3, 26.05, 26.05, 26.45], [26.8, 26.6, 26.4, 26.85], [26.55, 26.65, 26.35, 26.85],
    [26.85, 26.65, 26.6, 27.0], [26.85, 26.9, 26.7, 26.9], [26.9, 26.7, 26.6, 26.95],
    [26.7, 26.4, 26.4, 26.8], [26.45, 26.2, 26.0, 26.55], [26.35, 26.3, 26.3, 26.6],
    [25.75, 25.95, 25.75, 26.05], [26.2, 27.1, 26.05, 27.15], [27.65, 28.2, 27.4, 28.2],
    [28.4, 28.6, 28.15, 28.8], [28.7, 28.7, 28.4, 28.85], [28.6, 29.05, 28.6, 29.1],
    [29.35, 29.25, 29.0, 30.4], [29.2, 29.0, 28.55, 29.2], [28.3, 28.2, 28.2, 28.8],
    [28.05, 26.35, 26.15, 28.05], [26.4, 27.05, 26.4, 27.2], [26.7, 26.75, 26.35, 26.75],
    [26.8, 26.5, 26.45, 26.9], [26.5, 26.2, 25.8, 26.65], [26.3, 27.0, 26.3, 27.0],
    [26.7, 26.4, 26.35, 26.9], [25.9, 26.0, 25.5, 26.05], [25.8, 25.5, 25.5, 25.95],
    [24.55, 26.25, 24.55, 26.25], [26.5, 26.25, 26.25, 26.7], [26.45, 26.85, 26.4, 27.0],
    [26.95, 26.75, 26.5, 26.95], [26.55, 26.65, 26.1, 26.7], [27.4, 27.5, 27.3, 28.0],
    [27.2, 28.6, 27.1, 29.0], [29.7, 29.5, 29.05, 30.05], [30.2, 29.6, 29.5, 30.2],
    [30.0, 29.1, 28.95, 30.0], [29.35, 30.6, 29.35, 30.6], [31.0, 32.8, 30.85, 33.15],
    [33.0, 32.4, 31.75, 33.1], [31.45, 30.95, 30.9, 31.9], [31.45, 30.8, 30.8, 31.75],
    [31.2, 30.65, 30.55, 31.4], [31.2, 32.15, 31.15, 32.35], [32.65, 32.1, 31.9, 33.2],
    [32.0, 32.5, 31.6, 32.5], [32.75, 32.1, 32.1, 33.1], [32.2, 33.3, 32.2, 33.3],
    [35.0, 36.6, 34.55, 36.6], [37.4, 37.0, 36.85, 38.05], [37.0, 35.55, 35.1, 37.35],
    [36.0, 35.7, 35.1, 36.15], [36.0, 35.55, 35.05, 36.0], [36.0, 35.85, 35.7, 36.3],
    [36.2, 36.25, 35.8, 36.75], [36.4, 36.7, 36.4, 37.2], [36.85, 36.5, 36.1, 37.4],
    [36.85, 36.95, 36.45, 37.25], [37.2, 36.85, 36.8, 37.35], [37.05, 37.5, 37.05, 38.15],
    [37.3, 35.8, 35.8, 37.45], [35.95, 36.1, 35.65, 36.45], [36.35, 35.6, 35.15, 36.6],
    [35.4, 34.75, 33.85, 35.75], [35.25, 35.9, 35.0, 36.0], [35.55, 37.8, 35.4, 37.8],
    [36.95, 37.7, 36.9, 37.7], [37.7, 37.9, 37.15, 38.1], [38.3, 38.15, 38.15, 38.9],
    [38.2, 38.95, 37.75, 39.15], [39.0, 38.6, 38.45, 39.65], [39.35, 41.2, 39.35, 42.45],
    [41.55, 40.75, 40.6, 41.9], [41.0, 41.3, 40.3, 41.8], [41.5, 40.85, 40.55, 41.5],
    [40.95, 41.3, 40.6, 42.1], [41.4, 41.3, 40.95, 41.7], [42.5, 40.95, 40.95, 42.5],
    [41.1, 41.85, 40.95, 41.9], [42.0, 41.5, 41.05, 42.05], [41.4, 40.75, 39.85, 41.4],
    [40.85, 41.8, 40.35, 42.05], [41.95, 40.75, 40.3, 41.95], [40.1, 41.8, 39.65, 42.1],
    [41.5, 42.75, 41.4, 43.35], [42.85, 43.0, 42.5, 43.6], [43.5, 45.0, 43.15, 45.1],
    [44.75, 45.45, 44.5, 45.45], [45.0, 43.9, 43.65, 45.1], [43.4, 43.3, 42.45, 43.85],
    [43.3, 44.7, 43.15, 44.7], [45.9, 47.05, 45.5, 48.45], [48.1, 50.1, 47.05, 50.1],
    [49.4, 50.9, 49.1, 50.9], [50.8, 52.2, 49.8, 52.3], [51.8, 51.0, 51.0, 52.5],
    [51.5, 51.2, 50.7, 52.3], [50.9, 50.6, 50.1, 51.9], [50.4, 50.6, 49.55, 50.8],
    [50.0, 49.5, 49.5, 50.3], [49.5, 49.5, 48.45, 50.5], [50.0, 49.6, 49.6, 50.5],
    [50.2, 50.5, 49.9, 51.2], [50.5, 50.0, 50.0, 51.1], [49.7, 49.4, 49.2, 49.95],
    [49.6, 48.95, 48.5, 49.65], [49.0, 49.9, 46.85, 49.9], [49.35, 48.45, 48.4, 49.4],
    [48.1, 46.9, 46.9, 48.4], [47.55, 47.95, 47.5, 48.25], [48.8, 47.45, 47.3, 48.95],
    [47.85, 47.75, 47.75, 49.1], [47.8, 48.3, 47.4, 48.3], [48.3, 47.7, 47.55, 48.35],
    [48.05, 48.75, 47.75, 48.9], [49.0, 45.8, 45.8, 49.2], [45.8, 47.9, 45.0, 47.9],
    [48.25, 47.9, 47.4, 48.45], [47.6, 46.0, 45.9, 47.65], [46.2, 45.9, 45.75, 46.6],
    [46.3, 46.8, 46.0, 46.85], [46.8, 45.9, 45.5, 46.8], [46.0, 46.25, 45.5, 46.65],
    [46.5, 46.4, 45.9, 46.95], [46.5, 45.15, 45.0, 46.65], [45.2, 45.4, 45.0, 45.65],
    [45.75, 44.9, 44.7, 45.75], [44.95, 45.1, 44.55, 45.4], [45.5, 47.0, 45.4, 47.4],
    [46.7, 43.85, 43.75, 46.9], [43.15, 41.65, 41.45, 43.25], [42.85, 43.2, 42.0, 43.65],
    [42.2, 43.4, 41.7, 43.75], [45.0, 45.2, 44.7, 45.6], [45.5, 45.65, 44.65, 45.7],
    [46.2, 46.35, 46.0, 46.8], [46.3, 46.8, 45.8, 47.0], [46.8, 46.3, 46.2, 47.25],
    [46.45, 45.55, 45.3, 46.65], [45.95, 45.45, 45.45, 46.1], [45.8, 46.45, 45.8, 46.55],
    [43.55, 41.85, 41.85, 44.45], [42.2, 40.9, 39.8, 42.85], [37.8, 40.0, 37.4, 40.65],
    [40.8, 41.3, 40.05, 42.4], [41.65, 41.2, 40.65, 41.65], [41.9, 42.25, 41.6, 42.4],
    [41.7, 41.05, 41.05, 41.7], [39.5, 39.75, 38.55, 40.25], [40.5, 41.85, 40.2, 41.9],
    [41.9, 44.6, 41.55, 44.95], [44.6, 43.2, 43.2, 44.7], [43.25, 43.1, 42.9, 44.1],
    [43.05, 43.25, 42.5, 43.6], [43.5, 43.1, 42.95, 43.7], [43.45, 42.85, 42.8, 43.55],
    [43.2, 44.05, 43.15, 44.2], [44.1, 43.75, 43.6, 44.2], [43.0, 43.65, 42.95, 43.85],
    [43.0, 43.45, 42.7, 43.6], [42.9, 41.35, 41.2, 43.9], [41.8, 39.0, 38.8, 41.9],
    [37.55, 39.0, 37.45, 39.5], [40.7, 39.7, 39.7, 41.0], [39.7, 39.4, 38.8, 39.85],
    [40.2, 40.6, 40.1, 41.15], [40.25, 41.15, 40.1, 41.4], [41.0, 38.9, 38.9, 41.55],
    [38.75, 38.75, 37.4, 39.5], [39.1, 38.5, 38.5, 40.4], [38.5, 34.75, 34.65, 38.55],
    [31.4, 32.05, 31.3, 32.35], [32.6, 29.7, 29.7, 32.95], [28.0, 27.7, 27.7, 30.4],
    [28.25, 26.1, 26.1, 28.5], [25.5, 23.5, 23.5, 25.6], [25.0, 25.85, 24.9, 25.85],
    [24.5, 24.5, 23.5, 25.25], [26.05, 26.75, 25.75, 26.85], [28.4, 29.4, 28.2, 29.4],
    [30.1, 31.3, 28.5, 31.5], [32.5, 30.8, 30.8, 32.85], [29.6, 31.1, 29.5, 31.4],
    [31.6, 31.25, 30.9, 31.95], [31.15, 31.75, 30.7, 31.8], [32.45, 32.65, 31.85, 32.8],
    [33.5, 34.7, 33.5, 35.5], [34.9, 35.2, 34.7, 35.8], [36.0, 34.0, 34.0, 36.25],
    [34.2, 34.2, 33.8, 34.5], [34.0, 33.6, 33.6, 34.4], [33.95, 34.9, 33.8, 35.5],
    [35.85, 34.5, 34.5, 36.1], [33.85, 34.7, 33.85, 35.25], [36.0, 35.4, 34.85, 36.4],
    [36.0, 36.75, 35.55, 36.9], [36.9, 35.7, 35.45, 37.75], [35.0, 35.7, 34.6, 36.05],
    [36.2, 35.35, 35.1, 36.5], [35.15, 35.45, 34.9, 36.1], [35.9, 36.65, 35.65, 36.8],
    [37.0, 36.45, 36.2, 37.3], [36.8, 37.55, 36.75, 38.3], [38.05, 39.95, 38.05, 40.0],
    [38.9, 39.5, 38.7, 39.9], [40.45, 39.1, 38.9, 40.75], [39.5, 39.25, 39.0, 39.9],
    [40.0, 41.0, 39.8, 41.4], [42.4, 41.55, 41.35, 42.5], [42.9, 43.0, 42.25, 43.85],
    [43.2, 44.25, 43.0, 44.55], [44.2, 44.1, 43.55, 44.25], [43.9, 41.95, 41.6, 44.55],
    [43.0, 42.0, 41.2, 43.35], [40.8, 38.85, 38.15, 41.0], [40.4, 39.3, 38.9, 40.8],
    [39.0, 39.15, 38.5, 39.8], [39.95, 41.3, 39.4, 41.35], [40.65, 39.6, 39.5, 40.85],
    [39.65, 40.15, 38.3, 40.35], [40.45, 40.15, 40.05, 41.4], [40.5, 40.95, 40.4, 41.3],
    [41.7, 42.1, 41.65, 43.3], [42.1, 42.0, 41.5, 42.5], [42.3, 43.2, 42.2, 43.6],
    [43.25, 43.2, 42.6, 44.1], [44.05, 44.05, 43.35, 44.25], [44.75, 44.6, 44.3, 45.65],
    [45.0, 44.25, 44.15, 45.35]];

  final List<List<double>> wStockPrices = [
    [23.7, 24.35, 23.7, 24.35], [24.8, 24.95, 24.75, 25.25], [25.75, 25.8, 25.6, 25.95],
    [26.8, 26.6, 26.4, 26.85], [26.7, 26.4, 26.4, 26.8], [27.65, 28.2, 27.4, 28.2],
    [29.2, 29.0, 28.55, 29.2], [26.8, 26.5, 26.45, 26.9], [25.8, 25.5, 25.5, 25.95],
    [26.95, 26.75, 26.5, 26.95], [30.2, 29.6, 29.5, 30.2], [31.45, 30.95, 30.9, 31.9],
    [32.0, 32.5, 31.6, 32.5], [37.0, 35.55, 35.1, 37.35], [36.2, 36.25, 35.8, 36.75],
    [37.05, 37.5, 37.05, 38.15], [38.3, 38.15, 38.15, 38.9], [39.35, 41.2, 39.35, 42.45],
    [41.4, 41.3, 40.95, 41.7], [40.85, 41.8, 40.35, 42.05], [43.5, 45.0, 43.15, 45.1],
    [45.9, 47.05, 45.5, 48.45], [51.5, 51.2, 50.7, 52.3], [50.0, 49.6, 49.6, 50.5],
    [49.0, 49.9, 46.85, 49.9], [47.85, 47.75, 47.75, 49.1], [45.8, 47.9, 45.0, 47.9],
    [46.8, 45.9, 45.5, 46.8], [45.75, 44.9, 44.7, 45.75], [43.15, 41.65, 41.45, 43.25],
    [46.2, 46.35, 46.0, 46.8], [45.8, 46.45, 45.8, 46.55], [37.8, 40.0, 37.4, 40.65],
    [39.5, 39.75, 38.55, 40.25], [43.05, 43.25, 42.5, 43.6], [43.0, 43.65, 42.95, 43.85],
    [37.55, 39.0, 37.45, 39.5], [41.0, 38.9, 38.9, 41.55], [32.6, 29.7, 29.7, 32.95],
    [24.5, 24.5, 23.5, 25.25], [29.6, 31.1, 29.5, 31.4], [32.45, 32.65, 31.85, 32.8],
    [34.0, 33.6, 33.6, 34.4], [36.0, 36.75, 35.55, 36.9], [35.9, 36.65, 35.65, 36.8],
    [38.9, 39.5, 38.7, 39.9], [42.9, 43.0, 42.25, 43.85], [40.8, 38.85, 38.15, 41.0],
    [39.65, 40.15, 38.3, 40.35], [42.3, 43.2, 42.2, 43.6]];

  final List<List<double>> mStockPrices = [
    [26.8, 26.6, 26.4, 26.85], [26.7, 26.4, 26.35, 26.9], [32.0, 32.5, 31.6, 32.5],
    [35.25, 35.9, 35.0, 36.0], [42.85, 43.0, 42.5, 43.6], [49.0, 49.9, 46.85, 49.9],
    [45.5, 47.0, 45.4, 47.4], [37.8, 40.0, 37.4, 40.65], [37.55, 39.0, 37.45, 39.5],
    [31.15, 31.75, 30.7, 31.8], [38.9, 39.5, 38.7, 39.9], [42.3, 43.2, 42.2, 43.6]];

  List movingAvg5 = [
    23.37, 23.61,23.92,24.26,24.64,24.96,25.08,25.07,25.08,25.08,25.27,25.44,25.53,25.55,
    25.68,25.7,25.86,26.13,26.39,26.57,26.7,26.66,26.57,26.5,26.31,26.39,26.75,
    27.23,27.71,28.33,28.76,28.92,28.84,28.37,27.97,27.47,26.97,26.57,26.7,26.57,
    26.42,26.22,26.23,26.08,26.17,26.32,26.55,26.8,27.27,27.8,28.37,28.86,29.48,
    30.32,30.9,31.17,31.51,31.52,31.39,31.33,31.64,31.9,32.43,33.32,34.3,34.91,
    35.63,36.08,35.93,35.78,36.01,36.17,36.45,36.65,36.9,36.72,36.64,36.37,35.95,
    35.63,36.03,36.35,36.81,37.49,38.1,38.26,38.96,39.53,40.16,40.54,41.08,41.1,
    41.14,41.25,41.38,41.27,41.37,41.33,41.32,41.57,42.02,42.66,43.6,44.02,44.13,
    44.47,44.88,45.81,47.21,48.99,50.25,51.08,51.18,51.12,50.58,50.28,49.96,49.94,
    49.82,49.8,49.69,49.75,49.34,48.72,48.43,48.13,47.7,47.67,47.83,47.99,47.66,
    47.69,47.61,47.27,46.7,46.9,46.5,46.17,46.25,46.1,45.82,45.62,45.39,45.51,
    45.25,44.5,44.16,43.82,43.46,43.82,44.76,45.48,46.06,46.13,46.09,46.11,45.12,
    44.04,42.93,42.1,41.05,41.13,41.16,41.11,41.22,41.9,42.09,42.5,43.2,43.45,
    43.1,43.27,43.4,43.48,43.55,43.25,42.24,41.29,40.5,39.69,39.54,39.97,39.95,
    39.76,39.58,38.41,36.59,34.75,32.54,30.06,27.81,26.57,25.53,25.34,26.0,
    27.56,28.55,29.87,30.77,31.24,31.51,32.29,33.11,33.66,34.15,34.34,34.38,
    34.24,34.38,34.62,35.25,35.41,35.65,35.78,35.79,35.77,35.92,36.29,37.21,
    38.02,38.51,39.07,39.76,40.08,40.78,41.81,42.78,42.97,43.06,42.23,41.24,
    40.25,40.12,39.64,39.9,40.07,40.43,40.59,41.07,41.68,42.29,42.91,43.41,43.86];

  List movingAvg20 = [23.3175, 23.335, 23.425, 23.51, 23.58, 23.6475, 23.7075, 23.775, 23.8775, 23.9675, 24.08, 24.22, 24.3275, 24.465, 24.6625, 24.825, 24.9975, 25.1625, 25.32, 25.4925, 25.6575, 25.76, 25.825, 25.88, 25.91, 26.015, 26.1775, 26.365, 26.5375, 26.7225, 26.8875, 27.0475, 27.1925, 27.2425, 27.295, 27.33, 27.325, 27.3025, 27.32, 27.295, 27.26, 27.215, 27.2175, 27.215, 27.26, 27.2425, 27.165, 27.11, 27.105, 27.1275, 27.145, 27.15, 27.27, 27.5925, 27.86, 28.07, 28.285, 28.5075, 28.765, 29.05, 29.375, 29.705, 30.0575, 30.575, 31.0825, 31.5225, 31.975, 32.3775, 32.74, 33.0775, 33.4325, 33.8025, 34.12, 34.3225, 34.5775, 34.82, 35.085, 35.3325, 35.4625, 35.6525, 35.9175, 36.1975, 36.4275, 36.505, 36.6025, 36.755, 37.03, 37.29, 37.5625, 37.7925, 38.0225, 38.2625, 38.4625, 38.7125, 38.9125, 39.16, 39.445, 39.7025, 40.055, 40.3975, 40.6575, 41.0225, 41.4, 41.6875, 41.905, 42.21, 42.5025, 42.97, 43.45, 44.0175, 44.5025, 44.9975, 45.48, 45.9175, 46.3175, 46.755, 47.145, 47.6325, 48.0425, 48.375, 48.6725, 48.9175, 49.0675, 49.2175, 49.45, 49.5875, 49.6225, 49.5325, 49.3725, 49.2, 48.94, 48.775, 48.64, 48.41, 48.23, 48.095, 47.91, 47.6975, 47.5175, 47.305, 47.1275, 46.8775, 46.71, 46.715, 46.51, 46.22, 45.9925, 45.7475, 45.6225, 45.4675, 45.495, 45.44, 45.36, 45.3375, 45.315, 45.2975, 45.095, 44.8275, 44.5075, 44.315, 44.105, 43.9725, 43.77, 43.4075, 43.3075, 43.455, 43.455, 43.44, 43.3425, 43.215, 43.04, 42.9025, 42.775, 42.68, 42.58, 42.325, 42.1825, 42.0875, 42.0725, 41.9775, 41.9475, 41.8925, 41.785, 41.735, 41.5675, 41.075, 40.5175, 39.8475, 39.07, 38.22, 37.2525, 36.3425, 35.38, 34.535, 33.8325, 33.33, 32.92, 32.525, 32.1025, 31.72, 31.3225, 31.0, 30.815, 30.5775, 30.3625, 30.305, 30.4475, 30.6875, 31.0375, 31.5025, 32.165, 32.6575, 33.2175, 33.6475, 33.95, 34.2175, 34.5, 34.8225, 35.2575, 35.645, 35.9675, 36.195, 36.485, 36.8625, 37.3025, 37.835, 38.295, 38.6675, 39.0325, 39.205, 39.3325, 39.505, 39.785, 39.9975, 40.2325, 40.4075, 40.6325, 40.86, 40.9625, 41.1475, 41.3525, 41.5925, 41.7725, 41.9075];

  List movingAvg60 = [24.4, 24.4325, 24.4775, 24.5392, 24.5983, 24.6458, 24.6892, 24.7308, 24.775, 24.825, 24.8908, 24.9592, 25.0025, 25.0467, 25.085, 25.0975, 25.1008, 25.1017, 25.095, 25.1025, 25.0992, 25.0925, 25.07, 25.0525, 25.0175, 25.0108, 25.0308, 25.0517, 25.0617, 25.0867, 25.1433, 25.1917, 25.2333, 25.2408, 25.2658, 25.2833, 25.2958, 25.3242, 25.3608, 25.3842, 25.4117, 25.4367, 25.4892, 25.535, 25.5833, 25.635, 25.6833, 25.75, 25.84, 25.9392, 26.0375, 26.1392, 26.2633, 26.4333, 26.6058, 26.7417, 26.8692, 26.9908, 27.135, 27.2792, 27.4308, 27.56, 27.7, 27.89, 28.0842, 28.26, 28.4392, 28.6175, 28.7942, 28.9758, 29.155, 29.3333, 29.5275, 29.7192, 29.9108, 30.0733, 30.2317, 30.3808, 30.5158, 30.6658, 30.8508, 31.0392, 31.2342, 31.4317, 31.6483, 31.84, 32.0567, 32.2592, 32.4692, 32.6658, 32.8667, 33.0717, 33.2842, 33.5425, 33.7833, 34.0167, 34.2717, 34.5142, 34.7608, 35.0333, 35.3167, 35.6417, 35.9617, 36.2558, 36.53, 36.8292, 37.1692, 37.5458, 37.9175, 38.2958, 38.6525, 39.0208, 39.3542, 39.6508, 39.9358, 40.245, 40.5583, 40.8892, 41.1867, 41.475, 41.7492, 42.0458, 42.2983, 42.47, 42.6525, 42.8508, 43.0517, 43.2642, 43.4617, 43.67, 43.8217, 44.0117, 44.1942, 44.3467, 44.4867, 44.67, 44.8333, 45.0108, 45.205, 45.3592, 45.4858, 45.6058, 45.7258, 45.8733, 45.955, 46.0058, 46.0392, 46.0833, 46.1483, 46.2283, 46.3125, 46.4042, 46.4933, 46.555, 46.6208, 46.7158, 46.7167, 46.7192, 46.6892, 46.665, 46.635, 46.5892, 46.5158, 46.4467, 46.4225, 46.4208, 46.3567, 46.24, 46.1125, 45.9608, 45.825, 45.7058, 45.5917, 45.4758, 45.375, 45.2392, 45.0625, 44.8708, 44.6992, 44.5325, 44.3933, 44.2475, 44.0883, 43.9525, 43.795, 43.5833, 43.3217, 43.0117, 42.6783, 42.3008, 41.9292, 41.5617, 41.1717, 40.8508, 40.5758, 40.3175, 40.0658, 39.8133, 39.5608, 39.3375, 39.125, 38.955, 38.79, 38.5733, 38.4125, 38.2783, 38.14, 37.9917, 37.8167, 37.6458, 37.4858, 37.3008, 37.1242, 36.9542, 36.7875, 36.6242, 36.5342, 36.4783, 36.4775, 36.4475, 36.4125, 36.3625, 36.3617, 36.3917, 36.4108, 36.405, 36.42, 36.4008, 36.38, 36.3092, 36.25, 36.1683, 36.1275, 36.06, 36.005, 35.985, 36.0175, 36.0692, 36.1075, 36.1708, 36.2142, 36.2625, 36.3575, 36.4492];

  List dShares = [3190234, 12102578, 18703570, 16053243, 13608938, 38764390, 7562806, 3465972, 11308243, 8456201, 31077999, 6782104, 7470434, 4583440, 16581977, 27723753, 28190894, 12362961, 9648900, 7372415, 6033970, 6770910, 8466804, 9497961, 10172901, 36011086, 36237054, 38750964, 21975493, 28608129, 76202683, 28666529, 71097091, 89427080, 36669449, 17477955, 10495634, 16383714, 20964157, 14332572, 20418513, 10826385, 17071209, 10845362, 14244087, 8144325, 10341735, 34135316, 72562510, 103506659, 47959769, 40824985, 60522212, 134374563, 54282192, 46455399, 30793913, 24299721, 63982149, 91916506, 25426385, 29081754, 40575082, 130239766, 127940064, 86932392, 39394700, 37805162, 34999362, 40419186, 35850656, 39849284, 23866220, 32471586, 46757310, 45047973, 22368075, 26450392, 35946384, 31337640, 54223806, 37727449, 34248465, 40902248, 63726232, 38247639, 73416673, 32329865, 30266285, 20805623, 38976781, 12241281, 30457140, 24909147, 20906821, 34717821, 30806771, 23261995, 47481008, 50951108, 32285643, 49226442, 32695245, 30990038, 20932812, 26349981, 103581867, 93503419, 58448746, 53117451, 37548778, 25116363, 27106590, 23694117, 19845496, 22630261, 13932252, 19823116, 15594296, 13103050, 12359884, 27605324, 25694093, 30466230, 14783842, 18781246, 20258623, 13509198, 13243762, 22242651, 38864042, 37109528, 17598358, 31246571, 18376839, 12726524, 13864850, 12728303, 15131009, 22584788, 11321475, 14974876, 7871472, 37667899, 66258006, 40662500, 40443866, 23020868, 46077670, 21426372, 23459648, 18117965, 18863122, 16702403, 9084278, 9744308, 21147575, 22105363, 24649505, 21947741, 14712475, 13396430, 8711253, 25095742, 15519623, 38585511, 22195417, 14409756, 10930602, 11102158, 8221169, 19868832, 9028613, 6076428, 8358882, 20600514, 25135726, 16509383, 17360648, 11877583, 21683114, 18492479, 26318603, 25610891, 26847249, 30957382, 30388043, 26637814, 30183669, 34696866, 27075139, 47941035, 19363381, 23393147, 33908444, 52693677, 50607348, 32391878, 36689474, 28400165, 30856563, 54826711, 37783307, 43421331, 24700407, 21027951, 40109851, 37651985, 23385517, 49086119, 42558512, 60269808, 28305137, 35076704, 32398151, 27562340, 25029901, 55826064, 63244865, 32556389, 28103611, 18420314, 39872828, 32430111, 47553176, 48489846, 29574542, 45673024, 45488630, 52581909, 40607901, 25165201, 44030064, 30697478, 26054660, 29246381, 29402500, 64183273, 23727329, 33127698, 41188127, 31380116, 36814842, 24560394];

  List wShares = [12102578, 7562806, 6782104, 28190894, 6770910, 36237054, 28666529, 10495634, 10826385, 8144325, 47959769, 46455399, 25426385, 86932392, 40419186, 46757310, 40902248, 73416673, 12241281, 30806771, 49226442, 103581867, 25116363, 13932252, 27605324, 20258623, 37109528, 13864850, 14974876, 40662500, 23459648, 9744308, 24649505, 25095742, 10930602, 6076428, 16509383, 26318603, 26637814, 19363381, 32391878, 30856563, 21027951, 42558512, 27562340, 32556389, 47553176, 52581909, 26054660, 33127698];

  List mShares = [28190894, 14332572, 25426385, 31337640, 32285643, 27605324, 37667899, 24649505, 16509383, 28400165, 32556389, 33127698];

  // fixme: ask Chuni, what to do with the mvAvg lines in week k-chart and month k-chart
  // fixme: wStockPrices and mSrockPrices need to be updated, currently taking the data for that date
  // fixme: wShares and mShares also need to be updated to be the sum of shares within that time range (also check with Chuni whether this is the right column LOL, shouldn't it be volume?)

  String selectedKChartRange = 'd';

  @override
  Widget build(BuildContext context) {

    Map<String, Widget> kCharts = <String, Widget>{
      'd': KChart(
        historicPrices: widget.stock.historicPrice,
        prices: dStockPrices,
        ma_5: movingAvg5,
        ma_20: movingAvg20,
        ma_60: movingAvg60,
        shares: dShares,
      ),
      'w': KChart(
        historicPrices: widget.stock.historicPrice,
        prices: wStockPrices,
        ma_5: [],
        ma_20: [],
        ma_60: [],
        shares: wShares,
      ),
      'm': KChart(
        historicPrices: widget.stock.historicPrice,
        prices: mStockPrices,
        ma_5: [],
        ma_20: [],
        ma_60: [],
        shares: mShares,
      )
    };

    return Scaffold(
      resizeToAvoidBottomPadding: false, 
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 239, 242, 1.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(widget.stock.name + " (" + widget.stock.idNumber + ")"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // fixme: use Stack and Positioned to overlap the segmented control and the KChart
                // https://stackoverflow.com/questions/49838021/how-do-i-stack-widgets-overlapping-each-other-in-flutter
                // https://api.flutter.dev/flutter/widgets/Stack-class.html
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: CupertinoSlidingSegmentedControl(
                    groupValue: selectedKChartRange,
                    children: {
                      'd': Text(' D '),
                      'w': Text(' W '),
                      'm': Text(' M '),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        selectedKChartRange = value;
                      });
                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 300,
                        width: double.infinity,
                        child: kCharts[selectedKChartRange]
                      ),
                    ],
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
