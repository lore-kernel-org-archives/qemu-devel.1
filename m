Received: from eggs.gnu.org ([2001:4830:134:3::10]:47186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fSc8q-0000cz-5I
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fSc8n-0004wQ-1Y
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:46:52 -0400
Received: from smtp65.cstnet.cn ([159.226.251.65]:58234 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fSc8m-0004sH-D5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:46:48 -0400
Date: Tue, 12 Jun 2018 13:46:34 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <20180611135507.GF17756@stefanha-x1.localdomain>
References: <20180609163252.27506-1-stefanha@redhat.com>
	<6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
	<20180611135507.GF17756@stefanha-x1.localdomain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <36e0277e.1c637.163f28815e3.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefan hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de

CkkgZG8gaGF2ZSB0aW1lLCB0aGUgZnVuY3Rpb24gbWVudGlvbmVkIGluIGxhc3QgY29tbWVudHMg
aXNuJ3QgZGlmZmljdWx0IHRvCmltcGxlbWVudCwgYnV0IEkgd29uZGVyIGhvdyB0byB3cml0ZSBj
b3JyZXNwb25kaW5nIHF0ZXN0LWNhc2UgZm9yIGNvcnRleC1tMy4gWW91Cmtub3csIGJlY3Vhc2Ug
I2N1cnJlbnQjIFFFTVUgZG9lc24ndCBzdXJwcG9ydCB0aGUgY29ydGV4LW0zIGluc3RydWN0aW9u
LCBJIGRvbid0Cmtub3cgaG93IHRvIHByb3ZlIGNvcnJlY3RuZXNzIG9mIGhleCBsb2FkZXIuIEZv
ciBleGFtcGxlLCBpbiBteSBwYXN0IHBhdGNoCnNlcmlhcywgIkhlbGxvIFdvcmxkISIgd2lsbCBi
ZSBwcmludGVkIG91dCwgaWYgSGV4IEZpbGUgZ2V0IHN1Y2Nlc3NmdWxseSBsb2FkZWQuCgpKdWxp
YSBoYXMgdG9sZCBtZSBhIG1ldGhvZCwgSSBoYXZlbid0IHRyaWVkIGl0LiBJIHdpbGwgZG8gaXQg
YXMgcXVpY2sgYXMgSQpjb3VsZC4KCkJlc3QsClN1IEhhbmcKCgo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZXMtLS0tLQo+IEZyb206ICJTdGVmYW4gSGFqbm9jemkiIDxzdGVmYW5oYUByZWRoYXQuY29t
Pgo+IFNlbnQgVGltZTogMjAxOC0wNi0xMSAyMTo1NTowNyAoTW9uZGF5KQo+IFRvOiAiU3UgSGFu
ZyIgPHN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+Cj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZywganVzdWFsQG1haWwucnUsIGppbUBncm9rbGVhcm5pbmcuY29tLCBqb2VsQGptcy5pZC5hdSwg
cWVtdS5tbEBzdGVmZmVuLWdvZXJ0ei5kZQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGxvYWRlcjog
aW1wbGVtZW50IFNUQVJUX1NFR19BRERSX1JFQ09SRAo+IAo+IE9uIFN1biwgSnVuIDEwLCAyMDE4
IGF0IDEwOjA0OjMyQU0gKzA4MDAsIFN1IEhhbmcgd3JvdGU6Cj4gPiBTdXJlLCBUaGFua3MgZm9y
IHJlbWluZCBtZSBvZiB0aGlzLgo+ID4gT25lIHRoaW5nIEkgbXVzdCBwb2ludCBvdXQsIGluIGN1
cnJlbnQgY29kZSBsb2dpYywgaWYgIlNUQVJUX1NFR19BRERSX1JFQ09SRCIKPiA+IG9jY3VyZWQg
bXVsdGlwbGUgdGltZXMsIG9ubHkgdGhlIGxhc3Qgb25lIHdvcmtzLiBJIGRvbid0IGtub3cgd2hl
dGhlciBHTlUKPiA+IGJpbnV0aWxzIHdvdWxkIGVtaXQgJ1RoZSBSZWNvcmQnIG1hbnkgdGltZXMu
Cj4gCj4gSXQgZG9lcyBub3QuICBUaGUgYmVoYXZpb3IgeW91IGRlc2NyaWJlZCBzZWVtcyBmaW5l
Lgo+IAo+IERvIHlvdSBoYXZlIHRpbWUgdG8gc2VuZCBhIG5ldyByZXZpc2lvbiBvZiB5b3VyIHBh
dGNoIHNlcmllcyBhZGRyZXNzaW5nCj4gdGhlIGNvbW1lbnRzIGZyb20gbGFzdCB0aW1lPwo+IAo+
IFRoYW5rcywKPiBTdGVmYW4K
