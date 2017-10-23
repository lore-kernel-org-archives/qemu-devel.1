Received: from eggs.gnu.org ([2001:4830:134:3::10]:58135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6YMm-0004AT-Eg
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6YMi-00019V-Js
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:45:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6YMi-00019E-Dx
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73FC6C0587CD
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:45:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 10:45:37 +0200
Message-Id: <20171023084538.18210-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Usb 20171023 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e822e81e350825dd94f41ee2538ff1432b812e=
b9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-10-20 15:04:00 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20171023-pull-request

for you to fetch changes up to 31bd59db446de48eb985b4e1c0e31dae10fc35f8:

  usb-ccid: remove needless migration state code (2017-10-23 10:05:28 +02=
00)

----------------------------------------------------------------
usb: ccid fix.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  usb-ccid: remove needless migration state code

 hw/usb/dev-smartcard-reader.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

--=20
2.9.3
