Received: from eggs.gnu.org ([2001:4830:134:3::10]:50255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1d9lc8-0002wj-MT
	for qemu-devel@nongnu.org; Sun, 14 May 2017 00:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1d9lc5-0002KY-Jb
	for qemu-devel@nongnu.org; Sun, 14 May 2017 00:58:40 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:40986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <4345099@qq.com>) id 1d9lc4-0002Fb-Tv
	for qemu-devel@nongnu.org; Sun, 14 May 2017 00:58:37 -0400
From: "=?ISO-8859-1?B?aGVhdnliaXJk?=" <4345099@qq.com>
Mime-Version: 1.0
Date: Sun, 14 May 2017 12:58:23 +0800
Message-ID: <tencent_5A038239424655CD059BD858@qq.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] errors which can't backing storage for guest RAM with
 -mem-path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?= <peter.maydell@linaro.org>
Cc: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>

SGkgUGV0ZXINCg0KSSBmb3VuZCBpdCBjYW4ndCBiYWNrdXAgdGhlIGd1ZXN0IFJBTSB3aGVu
IGkgcnVuIHNpbXBsZSByYW0gdGVzdCBjb2RlIHdpdGggDQoNCmVycm9ycyB3aGljaCBjYW4n
dCBiYWNraW5nIHN0b3JhZ2UgZm9yIGd1ZXN0IFJBTSB3aXRoIGludGVncmF0b3JjcCwgdGhl
IGNvbW1hbmRlciBpczoNCg0KcWVtdS1zeXN0ZW0tYXJtIC1NIGludGVncmF0b3JjcCAtbSAx
IC1zZW1paG9zdGluZyAtbm9ncmFwaGljIC1tZW0tcGF0aCBtZW0udHh0IC1rZXJuZWwgYnVp
bGQvZW11X3JhbV90ZXN0LmVsZg0KDQppIHdyb3RlIHRoZSBwYXR0ZXIgIjB4NTUiIHRvIGFs
bCBvZiB0aGUgcmVzdCBvZiBSQU0gaW4gbXkgdGVzdCwgYWZ0ZXIgcnVuIG15IHRlc3QgY29k
ZSwgaXQganVzdCBnZW5lcmF0ZSB0aGUgMTA0ODU3NiBCeXRlcyBmaWxlLCBpIHNwbGl0IHRo
ZXNlIGZpbGUgaW50byAya0IsIG1vc3Qgb2Ygc3BsaXQgZmlsZSBpcyBibGFjaywgc29tZSBv
ZiB0aGVtIGp1c3QgZGlzcGxheSBcMDAgYWZ0ZXIgb3BlbiB3aXRoIGdlZGl0Lg0KDQppIGRv
bid0IGtub3cgd2hldGhlciBteSBjb21tYW5kZXIgaXMgaW5jb3JyZWN0LCBhbnlvbmUgY2Fu
IGNvbmZpcm0gaXQgZm9yIG1lPyBpIGp1c3Qgd2FudCB0byB3cml0ZSB0aGUgZ3Vlc3QgUkFN
IGFuZCByZWFkIGl0IGZyb20gaG9zdCBkdXJpbmcgdGhlIGd1ZXN0IGNvZGUgaXMgcnVubmlu
Zy4gYnV0IG15IGd1ZXN0IGp1c3QgaGFzIHNpbXBsZSBvcyB3aXRob3V0IGZpbGUgc3lzdGVt
IGFuZCBuZXR3b3JrLiBzbyBpIHdhbnQgdG8gdHJ5IHdpdGggdGhpcyBiYWNrZW5kIFJBTSB3
YXlzLg0KDQp0aGFua3MuDQpqcw==
