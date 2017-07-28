Received: from eggs.gnu.org ([2001:4830:134:3::10]:45468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <toshi.kani@hpe.com>) id 1dbBjl-0002rq-Mt
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <toshi.kani@hpe.com>) id 1dbBji-0004XB-F5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:19:53 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:53228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <toshi.kani@hpe.com>) id 1dbBji-0004OQ-6w
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:19:50 -0400
From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Date: Fri, 28 Jul 2017 20:19:15 +0000
Message-ID: <1501272590.2042.91.camel@hpe.com>
References: <20170728180446.GA31104@linux.intel.com>
	<CAPcyv4i5YWK6RHYEkH6C1oPWwhPLOD-atmkMVXDXc-qdv_0hgw@mail.gmail.com>
	<20170728194543.GA20726@linux.intel.com>
In-Reply-To: <20170728194543.GA20726@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <75AF5876A80935459CC26B6A26E3417D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] QEMU NVDIMM as type 7 in e820 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>
Cc: "guangrong.xiao@gmail.com" <guangrong.xiao@gmail.com>, "haozhong.zhang@intel.com" <haozhong.zhang@intel.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Knippers, Linda" <linda.knippers@hpe.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>

T24gRnJpLCAyMDE3LTA3LTI4IGF0IDEzOjQ1IC0wNjAwLCBSb3NzIFp3aXNsZXIgd3JvdGU6DQo+
IE9uIEZyaSwgSnVsIDI4LCAyMDE3IGF0IDExOjExOjEwQU0gLTA3MDAsIERhbiBXaWxsaWFtcyB3
cm90ZToNCj4gPiBPbiBGcmksIEp1bCAyOCwgMjAxNyBhdCAxMTowNCBBTSwgUm9zcyBad2lzbGVy
DQo+ID4gPHJvc3Muendpc2xlckBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KIDoNCj4gPiBEbyB5
b3UgbmVlZCB0aGF0IGluZm9ybWF0aW9uaW4gZTgyMD8gTGludXggZWZmZWN0aXZlbHkgaWdub3Jl
cw0KPiA+IHR5cGUtNy4gQXMgbG9uZyBhcyB0aGUgcmFuZ2UgaXMgdHJlYXRlZCBhcyByZXNlcnZl
ZCBpdCdzIG5vdCBjbGVhcg0KPiA+IHRoYXQgeW91IG5lZWQgdGhlIGU4MjAgZW50cnkuIFdlIGFs
c28gaW5mZWN0IHRoZSBwZXJzaXN0ZW50IHR5cGUNCj4gPiBiYWNrIGludG8gdGhlIG1lbW9yeSBt
YXAgd2hlbiB0aGUgTkZJVCBkcml2ZXIgbG9hZHMuIC9wcm9jL2lvbWVtDQo+ID4gc2hvdWxkIHNo
b3cgdGhlIHJpZ2h0IGRhdGEuDQo+IA0KPiBbIEFkZGluZyBMaW5kYSAmIFRvc2hpIHRvIHNlZSBp
ZiB0aGV5IGhhdmUgYW4gb3Bpbmlvbi4gXQ0KPiANCj4gSSBndWVzcyBtYXliZSB3ZSBkb24ndCBu
ZWVkIGl0LsKgwqBZZXAsIC9wcm9jL2lvbWVtIGxvb2tzIGdvb2Q6DQo+IA0KPiDCoCAjIGNhdCAv
cHJvYy9pb21lbQ0KPiDCoCAwMDAwMDAwMC0wMDAwMGZmZiA6IFJlc2VydmVkDQo+IMKgIDAwMDAx
MDAwLTAwMDlmYmZmIDogU3lzdGVtIFJBTQ0KPiDCoCAuLi4NCj4gwqAgMTAwMDAwMDAwLTIzZmZm
ZmZmZiA6IFN5c3RlbSBSQU0NCj4gwqAgMjQwMDAwMDAwLWEzZmZmZmZmZiA6IFBlcnNpc3RlbnQg
TWVtb3J5DQo+IMKgwqDCoMKgMjQwMDAwMDAwLWEzZmZmZmZmZiA6IG5hbWVzcGFjZTAuMA0KPiAN
Cj4gSSB3YXMganVzdCB3b3JyaWVkIHRoYXQgdGhpcyB3YXMgYW4gaW5jb25zaXN0ZW5jeSBiZXR3
ZWVuIHRoZSB3YXkNCj4gdGhhdCB2aXJ0dWFsIE5WRElNTXMgYXJlIHByZXNlbnRlZCB2cyB0aGUg
d2F5IHRoYXQgdGhleSB3aWxsIGJlDQo+IHByZXNlbnRlZCBvbiBiYXJlIG1ldGFsLsKgwqBJIGF0
IGxlYXN0IGxvb2sgYXQgdGhlIGU4MjAgdGFibGUgdG8gZ2V0IG15DQo+IGJlYXJpbmdzIG9mIGhv
dyBtZW1vcnkgaXMgbGFpZCBvdXQgLSBtYXliZSBJIGp1c3QgbmVlZCB0byBsb29rIGF0DQo+IC9w
cm9jL2lvbWVtIGluc3RlYWQ/DQoNCkZXIHNob3VsZCBwcmVzZW50IGEgcGVyc2lzdGVudCBtZW1v
cnkgcmFuZ2UgaW4gZTgyMCBvciBVRUZJIG1lbW9yeQ0KZGVzY3JpcHRvciB0YWJsZS4gIFNvLCBp
dCdzIGEgZ29vZCBwcmFjdGljZSBmb3IgUUVNVSB0byBkbyBpdCBhcyB3ZWxsLg0KDQpUaGF0IHNh
aWQsIHRoZSBORklUIGRyaXZlciBpbnNlcnRzIGEgcGVyc2lzdGVudCBtZW1vcnkgcmFuZ2UgdG8g
dGhlDQprZXJuZWwgSU8gcmVzb3VyY2UgdGFibGUgZnJvbSBORklULCBzbyB3ZSBhcmUgT0sgd2l0
aG91dCB0aGlzIGluZm8uIA0KWWVzLCAvcHJvYy9pb21lbSBzaG93cyBob3cgdGhlIHJlc291cmNl
cyBhcmUgbWFuYWdlZCBieSB0aGUga2VybmVsLg0KDQpUaGFua3MsDQotVG9zaGkNCg==
