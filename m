Received: from eggs.gnu.org ([2001:4830:134:3::10]:49190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e7U6T-0003fR-EQ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e7U6Q-0004C3-3L
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:24:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e7U6P-0004Av-QH
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:24:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PMObW5009048
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:24:41 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2du0k273gn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:24:40 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 23:24:36 +0100
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<b04cf5cc-cfb4-1f36-1a8b-99a34933a75c@linux.vnet.ibm.com>
	<bbcf40e2-18a3-bffc-d97c-7dd410e239b7@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 00:24:32 +0200
MIME-Version: 1.0
In-Reply-To: <bbcf40e2-18a3-bffc-d97c-7dd410e239b7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <213b31a8-a485-1281-0fe3-493de8115957@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

DQoNCk9uIDEwLzI1LzIwMTcgMDk6NDkgUE0sIENvbGxpbiBMLiBXYWxsaW5nIHdyb3RlOg0K
Pj4+IC3CoMKgwqDCoHNjY2ItPmgubGVuZ3RowqA9wqBzaXplb2YoV3JpdGVFdmVudERhdGEp
wqArwqBsZW47DQo+Pj4gK8KgwqDCoMKgZm9ywqAocMKgPcKgc3RyO8KgKnA7wqArK3ApwqB7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqBpZsKgKGRhdGFfbGVuwqA+wqBTQ0NCX0RBVEFfTEVO
wqAtwqAxKcKgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm7CoC1FRkJJ
RzsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoH0NCj4+IFdlwqBjb3VsZMKgYWxzb8KgZG/CoGHC
oHBhcnRpYWzCoHdyaXRlwqBvcsKgZG/CoG1vcmXCoHRoYXTCoG9uZQ0KPj4gc2NscF9zZXJ2
aWNlX2NhbGzCoGNhbGxzLg0KPj4NCj4+IEnCoGRvbid0wqB0aGlua8KgRUZCSUfCoGlzwqBl
bnRpcmVsecKgY29ycmVjdMKgaGVyZS7CoEZyb23CoHRoZcKgbWFuwqBwYWdlOg0KPj4gIiIi
DQo+PiDCoMKgwqDCoMKgwqDCoMKgRUZCSUfCoMKgQW7CoGF0dGVtcHTCoHdhc8KgbWFkZcKg
dG/CoHdyaXRlwqBhwqBmaWxlwqB0aGF0wqBleGNlZWRzwqB0aGXCoGltcGxlbWVudGEtDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aW9uLWRlZmluZWTCoG1heGltdW3C
oGZpbGXCoHNpemXCoG9ywqB0aGXCoHByb2Nlc3PigJlzwqBmaWxlwqBzaXplwqBsaW1pdCwN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9ywqB0b8Kgd3JpdGXCoGF0wqBh
wqBwb3NpdGlvbsKgcGFzdMKgdGhlwqBtYXhpbXVtwqBhbGxvd2VkwqBvZmZzZXQuDQo+PiAi
IiINCj4+DQo+PiBUaGF0J3PCoG5vdMKgd2hhdMKgd2XCoGhhdmXCoGhlcmXCoElNSE8uDQo+
IA0KPiANCj4gRnJvbcKgbXnCoHBlcnNwZWN0aXZlLMKgdGhlwqBlcnJvcsKgY29kZcKgd2Fz
wqBhwqB0aWXCoGJldHdlZW7CoEVGQklHwqAoY29uc2lkZXINCj4gbWF4wqBzY2NiwqBzaXpl
wqBhc8KgdGhlwqBtYXhpbXVtwqBhbGxvd2VkwqBvZmZzZXQpwqBhbmTCoEVOT1NQQzoNCj4g
DQo+IA0KPiAiIiINCj4gRU5PU1BDwqBUaGXCoGRldmljZcKgY29udGFpbmluZ8KgdGhlwqBm
aWxlwqByZWZlcnJlZMKgdG/CoGJ5wqAvZmQvaGFzwqBub8Kgcm9vbQ0KPiBmb3LCoHRoZcKg
ZGF0YS4NCj4gIiIiDQo+IA0KDQpGcm9tIHdoZXJlIEkgc3RhbmQsIHRoZSBmaWxlIGJlaGlu
ZCB0aGUgZmQgaXMgdGhlIFZUMjIwIHRlcm1pbmFsIHlvdQ0KdGFsayB0byB2aWEgc2NscF9z
ZXJ2aWNlX2NhbGwoU0NMUF9DTURfV1JJVEVfRVZFTlRfREFUQSwgc2NjYikgLS0geW91DQpj
YW4gY2hlY2sgdGhlIEFSKS4NCg0KSW4gdGhlIGVuZCwgdGhlIHRhcmdldCBzY29wZSAoaW4g
c2Vuc2Ugb2YgZXhwZWN0ZWQgY2xpZW50DQpjb2RlKSBvZiB0aGlzIGZ1bmN0aW9uIHZlcnkg
bGltaXRlZCwgYW5kIEFGQUlVIGRvZXMgbm90IG5lY2Vzc2FyaWx5DQpjYXJlIGFib3V0IGVy
cm9yIGNvZGVzIChzZWUgc2NscF9wcmludCkuIFNvIGJhc2ljYWxseSBhbnl0aGluZyBpcyBm
aW5lDQp3aXRoIG1lLCBiZWNhdXNlIGl0IGRvZXMgbm90IHJlYWxseSBtYXR0ZXIgLS0gYnV0
IGp1c3QgYmVjYXVzZSBpdCBkb2VzDQpub3QgcmVhbGx5IG1hdHRlci4NCg0KSGFsaWwNCj4g
DQo+IChjb25zaWRlcsKgInRoZcKgZmlsZSLCoGFzwqB0aGXCoHNjY2LCoGRhdGHCoGJ1ZmZl
cikNCj4gDQo+IEhvd2V2ZXIswqBJwqBleHRyZW1lbHnCoGRvdWJ0wqB3ZSdsbMKgZXZlcsKg
ZW5jb3VudGVywqBhbsKgb3ZlcmZsb3fCoGZyb20NCj4gcHJpbnRpbmfCoGR1cmluZ8KgdGhl
wqBiaW9zwqAod2h5wqB3b3VsZMKgd2XCoHByaW50wqBzb21ldGhpbmfCoHRoYXTCoGxhcmdl
PykNCj4gLi4uwqBwZXJoYXBzwqB0aGXCoGNoZWNrwqBpc8KgcmVkdW5kYW50Pw0KDQo=
