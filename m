Received: from eggs.gnu.org ([2001:4830:134:3::10]:46194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dak6y-0001u8-ST
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dak6v-0002WF-0a
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:50:00 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:37932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dak6u-0002Vs-SI
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:49:56 -0400
Received: by mail-it0-x243.google.com with SMTP id h199so8752813ith.5
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:49:56 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <D04135D2-38B2-41C6-A294-DEA7651B9D86@gmail.com>
Date: Thu, 27 Jul 2017 10:49:54 -0400
Subject: [Qemu-devel] [PATCH 0/2] Add more function key support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

QEMU can only handle up to function key F15. These patches extend QEMU =
to F19.=20

John Arbuckle (2):
  Add more function keys to QEMU
  Add more function keys to cocoa.m

 qapi-schema.json  | 6 +++++-
 ui/cocoa.m        | 4 ++++
 ui/input-keymap.c | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

--=20
2.7.2
