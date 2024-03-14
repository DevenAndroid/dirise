import 'package:get/get.dart';

import '../product_model/model_product_element.dart';

class ModelDirectOrderResponse {
  bool? status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  dynamic total;
  dynamic discount;
  List<ShippingType>? shippingType;
  RxString shippingOption = "".obs;
  int quantity = 1;
  dynamic vendorCountryId;
  ReturnData? returnData;
  ProductElement? prodcutData;
  List<FedexShipping>? fedexShipping;
  RxString fedexShippingOption = "".obs;

  ModelDirectOrderResponse(
      {this.status,
      this.message,
      this.subtotal,
      this.shipping,
      this.total,
      this.fedexShipping,
      this.discount,
      this.vendorCountryId,
      this.returnData,
      this.shippingType,
      this.prodcutData});

  ModelDirectOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    total = json['total'];
    discount = json['discount'];
    shipping = json['shipping'];
    vendorCountryId = json['vendor_country_id'];
    // if (json['shipping_types'] != null) {
    //   shippingType = <ShippingType>[];
    //   json['shipping_types'].forEach((v) {
    //     shippingType!.add(ShippingType.fromJson(v));
    //   });
    // }
    if (json['shipping_type'] != null) {
      shippingType = <ShippingType>[];
      json['shipping_type'].forEach((v) { shippingType!.add(ShippingType.fromJson(v)); });
    }
    if (json['fedex_shipping'] != null) {
      fedexShipping = <FedexShipping>[];
      json['fedex_shipping'].forEach((v) { fedexShipping!.add(FedexShipping.fromJson(v)); });
    }
    returnData = json['return_data'] != null ? ReturnData.fromJson(json['return_data']) : null;
    prodcutData = json['prodcut_data'] != null ? ProductElement.fromJson(json['prodcut_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['subtotal'] = subtotal;
    data['shipping'] = shipping;
    data['total'] = total;
    data['discount'] = discount;
    data['vendor_country_id'] = vendorCountryId;
    if (shippingType != null) {
      data['shipping_type'] = shippingType!.map((v) => v.toJson()).toList();
    }
    if (fedexShipping != null) {
      data['fedex_shipping'] = fedexShipping!.map((v) => v.toJson()).toList();
    }
    if (returnData != null) {
      data['return_data'] = returnData!.toJson();
    }
    if (prodcutData != null) {
      data['prodcut_data'] = prodcutData!.toJson();
    }
    return data;
  }
}


class FedexShipping {
  dynamic transactionId;
  Output? output;

  FedexShipping({this.transactionId, this.output});

  FedexShipping.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    output = json['output'] != null ? new Output.fromJson(json['output']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = transactionId;
    if (output != null) {
      data['output'] = output!.toJson();
    }
    return data;
  }
}

class Output {
  List<Alerts>? alerts;
  List<RateReplyDetails>? rateReplyDetails;
  dynamic quoteDate;
  bool? encoded;

  Output({this.alerts, this.rateReplyDetails, this.quoteDate, this.encoded});

  Output.fromJson(Map<String, dynamic> json) {
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) { alerts!.add(Alerts.fromJson(v)); });
    }
    if (json['rateReplyDetails'] != null) {
      rateReplyDetails = <RateReplyDetails>[];
      json['rateReplyDetails'].forEach((v) { rateReplyDetails!.add(RateReplyDetails.fromJson(v)); });
    }
    quoteDate = json['quoteDate'];
    encoded = json['encoded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (alerts != null) {
      data['alerts'] = alerts!.map((v) => v.toJson()).toList();
    }
    if (rateReplyDetails != null) {
      data['rateReplyDetails'] = rateReplyDetails!.map((v) => v.toJson()).toList();
    }
    data['quoteDate'] = quoteDate;
    data['encoded'] = encoded;
    return data;
  }
}

class Alerts {
  dynamic code;
  dynamic message;
  dynamic alertType;

  Alerts({this.code, this.message, this.alertType});

  Alerts.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    alertType = json['alertType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['alertType'] = alertType;
    return data;
  }
}

class RateReplyDetails {
  dynamic serviceType;
  dynamic serviceName;
  dynamic packagingType;
  Commit? commit;
  List<CustomerMessages>? customerMessages;
  List<RatedShipmentDetails>? ratedShipmentDetails;
  OperationalDetail? operationalDetail;
  dynamic signatureOptionType;
  ServiceDescription? serviceDescription;
  dynamic deliveryStation;

  RateReplyDetails({this.serviceType, this.serviceName, this.packagingType, this.commit, this.customerMessages, this.ratedShipmentDetails, this.operationalDetail, this.signatureOptionType, this.serviceDescription, this.deliveryStation});

  RateReplyDetails.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    serviceName = json['serviceName'];
    packagingType = json['packagingType'];
    commit = json['commit'] != null ? new Commit.fromJson(json['commit']) : null;
    if (json['customerMessages'] != null) {
      customerMessages = <CustomerMessages>[];
      json['customerMessages'].forEach((v) { customerMessages!.add(new CustomerMessages.fromJson(v)); });
    }
    if (json['ratedShipmentDetails'] != null) {
      ratedShipmentDetails = <RatedShipmentDetails>[];
      json['ratedShipmentDetails'].forEach((v) { ratedShipmentDetails!.add(new RatedShipmentDetails.fromJson(v)); });
    }
    operationalDetail = json['operationalDetail'] != null ? new OperationalDetail.fromJson(json['operationalDetail']) : null;
    signatureOptionType = json['signatureOptionType'];
    serviceDescription = json['serviceDescription'] != null ? new ServiceDescription.fromJson(json['serviceDescription']) : null;
    deliveryStation = json['deliveryStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceType'] = serviceType;
    data['serviceName'] = serviceName;
    data['packagingType'] = packagingType;
    if (commit != null) {
      data['commit'] = commit!.toJson();
    }
    if (customerMessages != null) {
      data['customerMessages'] = customerMessages!.map((v) => v.toJson()).toList();
    }
    if (ratedShipmentDetails != null) {
      data['ratedShipmentDetails'] = ratedShipmentDetails!.map((v) => v.toJson()).toList();
    }
    if (operationalDetail != null) {
      data['operationalDetail'] = operationalDetail!.toJson();
    }
    data['signatureOptionType'] = signatureOptionType;
    if (serviceDescription != null) {
      data['serviceDescription'] = serviceDescription!.toJson();
    }
    data['deliveryStation'] = deliveryStation;
    return data;
  }
}

class Commit {
  DateDetail? dateDetail;
  dynamic commodityName;
  List<DelayDetails>? delayDetails;
  List<String>? deliveryMessages;
  List<String>? requiredDocuments;
  DerivedOriginDetail? derivedOriginDetail;
  DerivedDestinationDetail? derivedDestinationDetail;
  bool? saturdayDelivery;

  Commit({this.dateDetail, this.commodityName, this.delayDetails, this.deliveryMessages, this.requiredDocuments, this.derivedOriginDetail, this.derivedDestinationDetail, this.saturdayDelivery});

  Commit.fromJson(Map<String, dynamic> json) {
    dateDetail = json['dateDetail'] != null ? new DateDetail.fromJson(json['dateDetail']) : null;
    commodityName = json['commodityName'];
    if (json['delayDetails'] != null) {
      delayDetails = <DelayDetails>[];
      json['delayDetails'].forEach((v) { delayDetails!.add(new DelayDetails.fromJson(v)); });
    }
    deliveryMessages = json['deliveryMessages'].cast<String>();
    requiredDocuments = json['requiredDocuments'].cast<String>();
    derivedOriginDetail = json['derivedOriginDetail'] != null ? new DerivedOriginDetail.fromJson(json['derivedOriginDetail']) : null;
    derivedDestinationDetail = json['derivedDestinationDetail'] != null ? new DerivedDestinationDetail.fromJson(json['derivedDestinationDetail']) : null;
    saturdayDelivery = json['saturdayDelivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (dateDetail != null) {
      data['dateDetail'] = dateDetail!.toJson();
    }
    data['commodityName'] = commodityName;
    if (delayDetails != null) {
      data['delayDetails'] = delayDetails!.map((v) => v.toJson()).toList();
    }
    data['deliveryMessages'] = deliveryMessages;
    data['requiredDocuments'] = requiredDocuments;
    if (derivedOriginDetail != null) {
      data['derivedOriginDetail'] = derivedOriginDetail!.toJson();
    }
    if (derivedDestinationDetail != null) {
      data['derivedDestinationDetail'] = derivedDestinationDetail!.toJson();
    }
    data['saturdayDelivery'] = saturdayDelivery;
    return data;
  }
}

class DateDetail {
  dynamic dayOfWeek;
  dynamic dayFormat;

  DateDetail({this.dayOfWeek, this.dayFormat});

  DateDetail.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    dayFormat = json['dayFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOfWeek'] = dayOfWeek;
    data['dayFormat'] = dayFormat;
    return data;
  }
}

class DelayDetails {
  dynamic date;
  dynamic dayOfWeek;
  dynamic level;
  dynamic point;
  dynamic type;
  dynamic description;

  DelayDetails({this.date, this.dayOfWeek, this.level, this.point, this.type, this.description});

  DelayDetails.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dayOfWeek = json['dayOfWeek'];
    level = json['level'];
    point = json['point'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = date;
    data['dayOfWeek'] = dayOfWeek;
    data['level'] = level;
    data['point'] = point;
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}

class DerivedOriginDetail {
  dynamic countryCode;
  dynamic postalCode;
  dynamic serviceArea;
  dynamic locationId;
 dynamic locationNumber;

  DerivedOriginDetail({this.countryCode, this.postalCode, this.serviceArea, this.locationId, this.locationNumber});

  DerivedOriginDetail.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    postalCode = json['postalCode'];
    serviceArea = json['serviceArea'];
    locationId = json['locationId'];
    locationNumber = json['locationNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['postalCode'] = postalCode;
    data['serviceArea'] = serviceArea;
    data['locationId'] = locationId;
    data['locationNumber'] = locationNumber;
    return data;
  }
}

class DerivedDestinationDetail {
  dynamic countryCode;
  dynamic stateOrProvinceCode;
  dynamic postalCode;
  dynamic serviceArea;
  dynamic locationId;
 dynamic locationNumber;
  dynamic airportId;

  DerivedDestinationDetail({this.countryCode, this.stateOrProvinceCode, this.postalCode, this.serviceArea, this.locationId, this.locationNumber, this.airportId});

  DerivedDestinationDetail.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    stateOrProvinceCode = json['stateOrProvinceCode'];
    postalCode = json['postalCode'];
    serviceArea = json['serviceArea'];
    locationId = json['locationId'];
    locationNumber = json['locationNumber'];
    airportId = json['airportId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['stateOrProvinceCode'] = stateOrProvinceCode;
    data['postalCode'] = postalCode;
    data['serviceArea'] = serviceArea;
    data['locationId'] = locationId;
    data['locationNumber'] = locationNumber;
    data['airportId'] = airportId;
    return data;
  }
}

class CustomerMessages {
  dynamic code;
  dynamic message;

  CustomerMessages({this.code, this.message});

  CustomerMessages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class RatedShipmentDetails {
  dynamic rateType;
  dynamic ratedWeightMethod;
  dynamic totalDiscounts;
  dynamic totalBaseCharge;
  dynamic totalNetCharge;
 dynamic totalVatCharge;
  dynamic totalNetFedExCharge;
 dynamic totalDutiesAndTaxes;
  dynamic totalNetChargeWithDutiesAndTaxes;
 dynamic totalDutiesTaxesAndFees;
 dynamic totalAncillaryFeesAndTaxes;
  ShipmentRateDetail? shipmentRateDetail;
  dynamic currency;

  RatedShipmentDetails({this.rateType, this.ratedWeightMethod, this.totalDiscounts, this.totalBaseCharge, this.totalNetCharge, this.totalVatCharge, this.totalNetFedExCharge, this.totalDutiesAndTaxes, this.totalNetChargeWithDutiesAndTaxes, this.totalDutiesTaxesAndFees, this.totalAncillaryFeesAndTaxes, this.shipmentRateDetail, this.currency});

  RatedShipmentDetails.fromJson(Map<String, dynamic> json) {
    rateType = json['rateType'];
    ratedWeightMethod = json['ratedWeightMethod'];
    totalDiscounts = json['totalDiscounts'];
    totalBaseCharge = json['totalBaseCharge'];
    totalNetCharge = json['totalNetCharge'];
    totalVatCharge = json['totalVatCharge'];
    totalNetFedExCharge = json['totalNetFedExCharge'];
    totalDutiesAndTaxes = json['totalDutiesAndTaxes'];
    totalNetChargeWithDutiesAndTaxes = json['totalNetChargeWithDutiesAndTaxes'];
    totalDutiesTaxesAndFees = json['totalDutiesTaxesAndFees'];
    totalAncillaryFeesAndTaxes = json['totalAncillaryFeesAndTaxes'];
    shipmentRateDetail = json['shipmentRateDetail'] != null ? new ShipmentRateDetail.fromJson(json['shipmentRateDetail']) : null;
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateType'] = rateType;
    data['ratedWeightMethod'] = ratedWeightMethod;
    data['totalDiscounts'] = totalDiscounts;
    data['totalBaseCharge'] = totalBaseCharge;
    data['totalNetCharge'] = totalNetCharge;
    data['totalVatCharge'] = totalVatCharge;
    data['totalNetFedExCharge'] = totalNetFedExCharge;
    data['totalDutiesAndTaxes'] = totalDutiesAndTaxes;
    data['totalNetChargeWithDutiesAndTaxes'] = totalNetChargeWithDutiesAndTaxes;
    data['totalDutiesTaxesAndFees'] = totalDutiesTaxesAndFees;
    data['totalAncillaryFeesAndTaxes'] = totalAncillaryFeesAndTaxes;
    if (shipmentRateDetail != null) {
      data['shipmentRateDetail'] = shipmentRateDetail!.toJson();
    }
    data['currency'] = currency;
    return data;
  }
}

class ShipmentRateDetail {
  dynamic rateZone;
 dynamic dimDivisor;
 dynamic fuelSurchargePercent;
  dynamic totalSurcharges;
  dynamic totalFreightDiscount;
  List<FreightDiscount>? freightDiscount;
  List<SurCharges>? surCharges;
  dynamic pricingCode;
  CurrencyExchangeRate? currencyExchangeRate;
  TotalBillingWeight? totalBillingWeight;
  dynamic dimDivisorType;
  dynamic currency;
  dynamic rateScale;
  TotalBillingWeight? totalRateScaleWeight;

  ShipmentRateDetail({this.rateZone, this.dimDivisor, this.fuelSurchargePercent, this.totalSurcharges, this.totalFreightDiscount, this.freightDiscount, this.surCharges, this.pricingCode, this.currencyExchangeRate, this.totalBillingWeight, this.dimDivisorType, this.currency, this.rateScale, this.totalRateScaleWeight});

  ShipmentRateDetail.fromJson(Map<String, dynamic> json) {
    rateZone = json['rateZone'];
    dimDivisor = json['dimDivisor'];
    fuelSurchargePercent = json['fuelSurchargePercent'];
    totalSurcharges = json['totalSurcharges'];
    totalFreightDiscount = json['totalFreightDiscount'];
    if (json['freightDiscount'] != null) {
      freightDiscount = <FreightDiscount>[];
      json['freightDiscount'].forEach((v) { freightDiscount!.add(new FreightDiscount.fromJson(v)); });
    }
    if (json['surCharges'] != null) {
      surCharges = <SurCharges>[];
      json['surCharges'].forEach((v) { surCharges!.add(new SurCharges.fromJson(v)); });
    }
    pricingCode = json['pricingCode'];
    currencyExchangeRate = json['currencyExchangeRate'] != null ? new CurrencyExchangeRate.fromJson(json['currencyExchangeRate']) : null;
    totalBillingWeight = json['totalBillingWeight'] != null ? new TotalBillingWeight.fromJson(json['totalBillingWeight']) : null;
    dimDivisorType = json['dimDivisorType'];
    currency = json['currency'];
    rateScale = json['rateScale'];
    totalRateScaleWeight = json['totalRateScaleWeight'] != null ? new TotalBillingWeight.fromJson(json['totalRateScaleWeight']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateZone'] = rateZone;
    data['dimDivisor'] = dimDivisor;
    data['fuelSurchargePercent'] = fuelSurchargePercent;
    data['totalSurcharges'] = totalSurcharges;
    data['totalFreightDiscount'] = totalFreightDiscount;
    if (freightDiscount != null) {
      data['freightDiscount'] = freightDiscount!.map((v) => v.toJson()).toList();
    }
    if (surCharges != null) {
      data['surCharges'] = surCharges!.map((v) => v.toJson()).toList();
    }
    data['pricingCode'] = pricingCode;
    if (currencyExchangeRate != null) {
      data['currencyExchangeRate'] = currencyExchangeRate!.toJson();
    }
    if (totalBillingWeight != null) {
      data['totalBillingWeight'] = totalBillingWeight!.toJson();
    }
    data['dimDivisorType'] = dimDivisorType;
    data['currency'] = currency;
    data['rateScale'] = rateScale;
    if (totalRateScaleWeight != null) {
      data['totalRateScaleWeight'] = totalRateScaleWeight!.toJson();
    }
    return data;
  }
}

class FreightDiscount {
  dynamic type;
  dynamic description;
  dynamic amount;
 dynamic percent;

  FreightDiscount({this.type, this.description, this.amount, this.percent});

  FreightDiscount.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    amount = json['amount'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['description'] = description;
    data['amount'] = amount;
    data['percent'] = percent;
    return data;
  }
}

class SurCharges {
  dynamic type;
  dynamic description;
  dynamic level;
  dynamic amount;

  SurCharges({this.type, this.description, this.level, this.amount});

  SurCharges.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    level = json['level'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['description'] = description;
    data['level'] = level;
    data['amount'] = amount;
    return data;
  }
}

class CurrencyExchangeRate {
  dynamic fromCurrency;
  dynamic intoCurrency;
 dynamic rate;

  CurrencyExchangeRate({this.fromCurrency, this.intoCurrency, this.rate});

  CurrencyExchangeRate.fromJson(Map<String, dynamic> json) {
    fromCurrency = json['fromCurrency'];
    intoCurrency = json['intoCurrency'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromCurrency'] = fromCurrency;
    data['intoCurrency'] = intoCurrency;
    data['rate'] = rate;
    return data;
  }
}

class TotalBillingWeight {
  dynamic units;
 dynamic value;

  TotalBillingWeight({this.units, this.value});

  TotalBillingWeight.fromJson(Map<String, dynamic> json) {
    units = json['units'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['units'] = units;
    data['value'] = value;
    return data;
  }
}

class OperationalDetail {
  List<String>? originLocationIds;
  List<int>? originLocationNumbers;
  List<String>? originServiceAreas;
  List<String>? destinationLocationIds;
  List<int>? destinationLocationNumbers;
  List<String>? destinationServiceAreas;
  List<String>? destinationLocationStateOrProvinceCodes;
  dynamic deliveryDate;
  dynamic deliveryDay;
  dynamic commitDate;
  List<String>? commitDays;
  bool? ineligibleForMoneyBackGuarantee;
  dynamic astraDescription;
  List<String>? originPostalCodes;
  List<String>? countryCodes;
  dynamic airportId;
  dynamic serviceCode;
  dynamic destinationPostalCode;

  OperationalDetail({this.originLocationIds, this.originLocationNumbers, this.originServiceAreas, this.destinationLocationIds, this.destinationLocationNumbers, this.destinationServiceAreas, this.destinationLocationStateOrProvinceCodes, this.deliveryDate, this.deliveryDay, this.commitDate, this.commitDays, this.ineligibleForMoneyBackGuarantee, this.astraDescription, this.originPostalCodes, this.countryCodes, this.airportId, this.serviceCode, this.destinationPostalCode});

  OperationalDetail.fromJson(Map<String, dynamic> json) {
    originLocationIds = json['originLocationIds'].cast<String>();
    originLocationNumbers = json['originLocationNumbers'].cast<int>();
    originServiceAreas = json['originServiceAreas'].cast<String>();
    destinationLocationIds = json['destinationLocationIds'].cast<String>();
    destinationLocationNumbers = json['destinationLocationNumbers'].cast<int>();
    destinationServiceAreas = json['destinationServiceAreas'].cast<String>();
    destinationLocationStateOrProvinceCodes = json['destinationLocationStateOrProvinceCodes'].cast<String>();
    deliveryDate = json['deliveryDate'];
    deliveryDay = json['deliveryDay'];
    commitDate = json['commitDate'];
    commitDays = json['commitDays'].cast<String>();
    ineligibleForMoneyBackGuarantee = json['ineligibleForMoneyBackGuarantee'];
    astraDescription = json['astraDescription'];
    originPostalCodes = json['originPostalCodes'].cast<String>();
    countryCodes = json['countryCodes'].cast<String>();
    airportId = json['airportId'];
    serviceCode = json['serviceCode'];
    destinationPostalCode = json['destinationPostalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originLocationIds'] = originLocationIds;
    data['originLocationNumbers'] = originLocationNumbers;
    data['originServiceAreas'] = originServiceAreas;
    data['destinationLocationIds'] = destinationLocationIds;
    data['destinationLocationNumbers'] = destinationLocationNumbers;
    data['destinationServiceAreas'] = destinationServiceAreas;
    data['destinationLocationStateOrProvinceCodes'] = destinationLocationStateOrProvinceCodes;
    data['deliveryDate'] = deliveryDate;
    data['deliveryDay'] = deliveryDay;
    data['commitDate'] = commitDate;
    data['commitDays'] = commitDays;
    data['ineligibleForMoneyBackGuarantee'] = ineligibleForMoneyBackGuarantee;
    data['astraDescription'] = astraDescription;
    data['originPostalCodes'] = originPostalCodes;
    data['countryCodes'] = countryCodes;
    data['airportId'] = airportId;
    data['serviceCode'] = serviceCode;
    data['destinationPostalCode'] = destinationPostalCode;
    return data;
  }
}

class ServiceDescription {
  dynamic serviceId;
  dynamic serviceType;
  dynamic code;
  List<Names>? names;
  dynamic serviceCategory;
  dynamic description;
  dynamic astraDescription;

  ServiceDescription({this.serviceId, this.serviceType, this.code, this.names, this.serviceCategory, this.description, this.astraDescription});

  ServiceDescription.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceType = json['serviceType'];
    code = json['code'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) { names!.add(new Names.fromJson(v)); });
    }
    serviceCategory = json['serviceCategory'];
    description = json['description'];
    astraDescription = json['astraDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = serviceId;
    data['serviceType'] = serviceType;
    data['code'] = code;
    if (names != null) {
      data['names'] = names!.map((v) => v.toJson()).toList();
    }
    data['serviceCategory'] = serviceCategory;
    data['description'] = description;
    data['astraDescription'] = astraDescription;
    return data;
  }
}

class Names {
  dynamic type;
  dynamic encoding;
  dynamic value;

  Names({this.type, this.encoding, this.value});

  Names.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    encoding = json['encoding'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['encoding'] = encoding;
    data['value'] = value;
    return data;
  }
}

class ShippingType {
 dynamic id;
  dynamic name;
  dynamic value;
 dynamic vendorId;


  ShippingType({this.id, this.name, this.value, this.vendorId});

  ShippingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['vendor_id'] = vendorId;
    return data;
  }
}
class ReturnData {
  dynamic startDate;
  dynamic timeSloat;
  dynamic sloatEndTime;
  dynamic quantity;

  ReturnData({this.startDate, this.timeSloat, this.sloatEndTime, this.quantity});

  ReturnData.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    timeSloat = json['time_sloat'];
    sloatEndTime = json['sloat_end_time'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['time_sloat'] = timeSloat;
    data['sloat_end_time'] = sloatEndTime;
    data['quantity'] = quantity;
    return data;
  }
}