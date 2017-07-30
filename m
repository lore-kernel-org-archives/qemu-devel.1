Received: from eggs.gnu.org ([2001:4830:134:3::10]:33019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dbuhH-0002Ka-TC
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dbuhE-0005tq-PI
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:20:19 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:37824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dbuhE-0005tj-Ij
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:20:16 -0400
Received: by mail-it0-x244.google.com with SMTP id 77so15280489itj.4
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 13:20:16 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <18FAE494-62D2-462D-B672-8E1085982F56@gmail.com>
Date: Sun, 30 Jul 2017 16:20:13 -0400
Subject: [Qemu-devel] [PATCH v2 0/2] Add more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

QEMU can only handle up to function key F15. These patches extend QEMU =
to F24.

John Arbuckle (2):
  Add more function keys to QEMU
  Add more function keys to cocoa.m

 qapi-schema.json  | 13 ++++++++++++-
 ui/cocoa.m        |  5 +++++
 ui/input-keymap.c |  9 +++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

--=20
2.7.2
