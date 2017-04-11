Received: from eggs.gnu.org ([2001:4830:134:3::10]:39884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cxyuc-0001yc-Lx
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cxyuY-0008UC-JY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:45:02 -0400
Received: from mail-oln040092254075.outbound.protection.outlook.com
	([40.92.254.75]:55296
	helo=APC01-PU1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Prerna.Garg@live.com>)
	id 1cxyuX-0008Sx-Se
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:44:58 -0400
From: Prerna Garg <Prerna.Garg@live.com>
Date: Tue, 11 Apr 2017 16:44:33 +0000
Message-ID: <BM1PR01MB0722F734DE63EB1274B3132B84000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<BM1PR01MB07224A0D4D1815F66D26EB7C84010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>,
	<20170411075348.GA4516@noname.str.redhat.com>,
	<BM1PR01MB0722AC7132DBFA648D3732A084000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BM1PR01MB0722AC7132DBFA648D3732A084000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_BM1PR01MB0722F734DE63EB1274B3132B84000BM1PR01MB0722INDP_"
MIME-Version: 1.0
Subject: [Qemu-devel] Fw: First contribution - Interested in Outreachy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

--_004_BM1PR01MB0722F734DE63EB1274B3132B84000BM1PR01MB0722INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Prerna Garg
Sent: Tuesday, April 11, 2017 9:57 PM
To: Kevin Wolf
Subject: Re: First contribution - Interested in Outreachy


Hello,


I am having difficulties sending the email through command line. So as a la=
st resort I am sending the patch as an attachment.


Prerna


________________________________
From: Kevin Wolf <kwolf@redhat.com>
Sent: Tuesday, April 11, 2017 1:23 PM
To: Prerna Garg
Cc: qemu-devel@nongnu.org; stefanha@redhat.com; Alberto Garcia
Subject: Re: First contribution - Interested in Outreachy

Hi Prerna,

Am 10.04.2017 um 21:59 hat Prerna Garg geschrieben:
> The previous patch was incorrect. Sorry for the inconvenience. Please con=
sider
> this as my first contribution.

Please read this wiki page about how to submit patches to QEMU:

    http://wiki.qemu-project.org/Contribute/SubmitAPatch
Contribute/SubmitAPatch - QEMU<http://wiki.qemu-project.org/Contribute/Subm=
itAPatch>
wiki.qemu-project.org
QEMU welcomes contributions of code (either fixing bugs or adding new funct=
ionality). However, we get a lot of patches, and so we have some guidelines=
 about ...




The most important point that is missing from your patch is the
Signed-off-by line, without which a patch cannot be accepted.

You should also try to have a commit message (including the subject
line) that describes the change that your patch is making, and include
[PATCH] in your subject line. If you use 'git format-patch' to create
the email, the [PATCH] is added automatically.

Kevin

--_004_BM1PR01MB0722F734DE63EB1274B3132B84000BM1PR01MB0722INDP_
Content-Type: text/x-patch;
	name="0001-Changed-malloc-to-g_malloc-in-block-iscsi.c-file.patch"
Content-Description: 0001-Changed-malloc-to-g_malloc-in-block-iscsi.c-file.patch
Content-Disposition: attachment;
	filename="0001-Changed-malloc-to-g_malloc-in-block-iscsi.c-file.patch";
	size=1175; creation-date="Tue, 11 Apr 2017 16:27:16 GMT";
	modification-date="Tue, 11 Apr 2017 16:27:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkN2FhOWUxNjU5Y2VkZmYzNmU3YmVkMTQ4ZmQwYTNlYmFlNjNlMjU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmVybmEgR2FyZyA8cHJlcm5hLmdhcmdAbGl2ZS5jb20+CkRh
dGU6IFR1ZSwgMTEgQXByIDIwMTcgMjE6NTA6MjkgKzA1MzAKU3ViamVjdDogW1BBVENIXSBDaGFu
Z2VkIG1hbGxvYyB0byBnX21hbGxvYyBpbiBibG9jay9pc2NzaS5jIGZpbGUKClNpZ25lZC1vZmYt
Ynk6IFByZXJuYSBHYXJnIDxwcmVybmEuZ2FyZ0BsaXZlLmNvbT4KLS0tCiBibG9jay9pc2NzaS5j
IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2lzY3NpLmMgYi9ibG9jay9pc2NzaS5jCmluZGV4IDcxNmU3
NGEuLmI5MjZlZDQgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2lzY3NpLmMKKysrIGIvYmxvY2svaXNjc2ku
YwpAQCAtMTAzNCw3ICsxMDM0LDcgQEAgc3RhdGljIEJsb2NrQUlPQ0IgKmlzY3NpX2Fpb19pb2N0
bChCbG9ja0RyaXZlclN0YXRlICpicywKICAgICAgICAgcmV0dXJuIE5VTEw7CiAgICAgfQogCi0g
ICAgYWNiLT50YXNrID0gbWFsbG9jKHNpemVvZihzdHJ1Y3Qgc2NzaV90YXNrKSk7CisgICAgYWNi
LT50YXNrID0gZ19tYWxsb2Moc2l6ZW9mKHN0cnVjdCBzY3NpX3Rhc2spKTsKICAgICBpZiAoYWNi
LT50YXNrID09IE5VTEwpIHsKICAgICAgICAgZXJyb3JfcmVwb3J0KCJpU0NTSTogRmFpbGVkIHRv
IGFsbG9jYXRlIHRhc2sgZm9yIHNjc2kgY29tbWFuZC4gJXMiLAogICAgICAgICAgICAgICAgICAg
ICAgaXNjc2lfZ2V0X2Vycm9yKGlzY3NpKSk7CkBAIC0xMzk4LDcgKzEzOTgsNyBAQCBzdGF0aWMg
dm9pZCBpc2NzaV9yZWFkY2FwYWNpdHlfc3luYyhJc2NzaUx1biAqaXNjc2lsdW4sIEVycm9yICoq
ZXJycCkKICAgICBzdHJ1Y3Qgc2NzaV90YXNrICp0YXNrID0gTlVMTDsKICAgICBzdHJ1Y3Qgc2Nz
aV9yZWFkY2FwYWNpdHkxMCAqcmMxMCA9IE5VTEw7CiAgICAgc3RydWN0IHNjc2lfcmVhZGNhcGFj
aXR5MTYgKnJjMTYgPSBOVUxMOwotICAgIGludCByZXRyaWVzID0gSVNDU0lfQ01EX1JFVFJJRVM7
IAorICAgIGludCByZXRyaWVzID0gSVNDU0lfQ01EX1JFVFJJRVM7CiAKICAgICBkbyB7CiAgICAg
ICAgIGlmICh0YXNrICE9IE5VTEwpIHsKLS0gCjIuNy40Cgo=

--_004_BM1PR01MB0722F734DE63EB1274B3132B84000BM1PR01MB0722INDP_--
