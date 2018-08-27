Received: from eggs.gnu.org ([2001:4830:134:3::10]:33626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lightn1ngstr1ke@protonmail.com>) id 1fuI5n-0002pc-DA
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lightn1ngstr1ke@protonmail.com>) id 1fuHtk-0008CW-7n
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:49:44 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:52049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lightn1ngstr1ke@protonmail.com>)
	id 1fuHtj-0008CB-PY
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:49:40 -0400
Date: Mon, 27 Aug 2018 13:49:22 +0000
From: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Reply-To: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Message-ID: <CSjEdwPfIMyBPsRNM1KZG7ugmTMLh2leLbHEBEQ2o0UjHftEBoh98TcX-xoHTgjDAW7Vn1psMATSN_4IS68-sdTWKkd32SL-HGN5A5-pqz0=@protonmail.com>
In-Reply-To: <20180827101609.p2blhd7ka7gkqqtq@sirius.home.kraxel.org>
References: <petKSachdmuxWMgY2EXHzES3PpUCAUwQacKEaIU9PHykNXfsah1sP3OaVuDLz0VBYJM7qtJsWSrv3U9bkb_2LT_itBxDbAYKIHlEJJXtEiE=@protonmail.com>
	<20180827101609.p2blhd7ka7gkqqtq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] input-linux: toggle for lock keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SSBwZXJzb25hbGx5IHVzZSB0aGUgU2Nyb2xsIExvY2sga2V5LiBPbiBMaW51eCwgU2Nyb2xsIExv
Y2sgKGFsb25nIHdpdGggYWxsIHRoZSBvdGhlciBsb2NrIGtleXMpIGlzIGVhc3kgdG8gZGlzYWJs
ZSB3aXRoIGFuIHhtb2RtYXAgY29tbWFuZC4gT24gV2luZG93cyAob3IsIEknZCBhc3N1bWUsIG90
aGVyIGd1ZXN0cyksIGl0IHJlcXVpcmVzIHRoaXJkIHBhcnR5IHNvZnR3YXJlLCB3aGljaCBpcyB3
aHkgaXQncyBsaWtlbHkgZWFzaWVyIHRvIGp1c3QgZmlsdGVyIHRoZW0gb3V0IGZyb20gUUVNVS4K
LS0tLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLS0tLQpPbiBBdWcgMjcsIDIwMTgsIDY6MTYg
QU0sIGtyYXhlbEByZWRoYXQuY29tIHdyb3RlOgoKPiBPbiBUaHUsIEF1ZyAyMywgMjAxOCBhdCAw
MToyMzoyMEFNICswMDAwLCBSeWFuIEVsIEtvY2h0YSB3cm90ZToKPj4gVGhpcyBwYXRjaCBpbnRy
b2R1Y2VzIHRocmVlIG5ldyBvcHRpb25zIG9uIHRoZSBpbnB1dC1saW51eCBjb21tYW5kbGluZToK
Pj4KPj4gKGEpIGlnbm9yZV9jYXBzX2xvY2s9W29ufG9mZl0KPj4gKGIpIGlnbm9yZV9udW1fbG9j
az1bb258b2ZmXQo+PiAoYykgaWdub3JlX3Njcm9sbF9sb2NrPVtvbnxvZmZdCj4+Cj4+IElmIGVu
YWJsZWQsIHRoZSBrZXkgd2lsbCBiZSBkaXNhYmxlZCBhbmQgbm90IGZvcndhcmRlZCB0byB0aGUg
Z3Vlc3QuCj4+IFRoZXJlIGFyZSB0d28gbWFpbiByZWFzb25zIGZvciB0aGlzOgo+Pgo+PiAoYSkg
V2l0aG91dCBrZXlib2FyZCBMRURzLCBpdCBjYW4gYmUgZGlmZmljdWx0IHRvIHRlbGwgd2hldGhl
ciBpdCBpcwo+PiBlbmFibGVkIG9yIG5vdAo+PiAoYikgUHJlcGFyYXRpb24gZm9yIGFub3RoZXIg
cGF0Y2ggd2hpY2ggd2lsbCBhbGxvdyBjaGFuZ2luZyB0aGUga2V5cwo+PiB1c2VkIHRvIHRvZ2ds
ZSB0aGUgaW5wdXQgZGV2aWNlJ3MgZ3JhYi4gSWYgeW91IHNldCB0aGUga2V5IHRvCj4+IEtFWV9T
Q1JPTExMT0NLIGZvciBleGFtcGxlLCBpdCBjYW4gYmUgZnJ1c3RyYXRpbmcgZGlzYWJsaW5nIHNj
cm9sbCBsb2NrCj4+IGluIHRoZSBndWVzdCwgYXMgaXQgd2lsbCByZXF1aXJlIHByZXNzaW5nIHRo
ZSBrZXkgbW9yZSB0aGFuIHR3aWNlLgo+Cj4gSG1tLiBZb3UgaGF2ZSB0aGUgc2FtZSBpc3N1ZSBv
biB0aGUgaG9zdCwgcmlnaHQ/Cj4KPiBGb3IgdGhlIGd1ZXN0IHdlIGNhbiBlYXNpbHkgZmlsdGVy
IG91dCB0aGUga2V5IGV2ZW50cy4KPiBGb3IgdGhlIGhvc3Qgd2UgY2FuJ3QuIFRoaXMgaXMgdGhl
IHJlYXNvbiBJIHBpY2tlZCBhCj4ga2V5IGNvbWJpbmF0aW9uIHdoaWNoIGhhcyBubyBzaWRlIGVm
ZmVjdHMgdG8gc3dpdGNoCj4gYmV0d2VlbiBob3N0IGFuZCBndWVzdC4gQW5kIGZvciB0aGUgc2Ft
ZSByZWFzb24gSSBkb24ndAo+IHRoaW5rIGl0IGlzIHVzZWZ1bCB0byBhbGxvdyB0aGUgdXNlciB0
byBzcGVjaWZ5IGFyYml0cmFyeQo+IGtleSBjb21iaW5hdGlvbnMuCj4KPiBXaGljaCBjb21iaW5h
dGlvbiBkbyB5b3Ugd2FudCB1c2UgaW5zdGVhZCBvZiBsZWZ0c2hpZnQgKyByaWdodHNoaWZ0Pwo+
Cj4gY2hlZXJzLAo+IEdlcmQ=
