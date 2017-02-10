Received: from eggs.gnu.org ([2001:4830:134:3::10]:34490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cc5nK-0000S4-AA
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cc5nH-0003p5-8P
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:39:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cc5nH-0003oz-3L
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:38:59 -0500
Message-ID: <1486712330.2446.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Feb 2017 08:38:50 +0100
In-Reply-To: <alpine.GSO.2.00.1702100115320.15492@dmz.c-home.cz>
References: <1486104705-13761-1-git-send-email-kraxel@redhat.com>
	<alpine.GSO.2.00.1702031147000.5901@dmz.c-home.cz>
	<alpine.GSO.2.00.1702100115320.15492@dmz.c-home.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xhci: fix event queue IRQ handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Cerveny <M.Cerveny@computer.org>
Cc: qemu-devel@nongnu.org

On Fr, 2017-02-10 at 01:17 +0100, Martin Cerveny wrote:
> Hello.
>=20
> Ok. Not more bugs. The problem was in qemu-xen-4.8 missing "usb-redir: al=
locate buffers before waking up the host adapter"

Ah cool.  Thanks for the notice.

cheers,
  Gerd
