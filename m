Received: from eggs.gnu.org ([2001:4830:134:3::10]:59580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4m2L-0001ad-Lx
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4m2H-00075m-Ne
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4m2H-000743-Im
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:57:17 -0400
Message-ID: <1508324232.10073.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 18 Oct 2017 12:57:12 +0200
In-Reply-To: <1508309285.10073.6.camel@redhat.com>
References: <20171015184033.2951-1-martin@schrodt.org>
	<1508309285.10073.6.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Improve audio output quality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

  Hi,

> Which guests did you test with?
>=20
> I did a brief test with Windows 7 and still have sound dropouts, even
> though it seems to not be as bad as before.=C2=A0=C2=A0Didn't investiga=
te yet
> why.

Played around a bit more.  Windows 10 seems to work a bit better.=20
Pushed some incremental patches.

https://www.kraxel.org/cgit/qemu/log/?h=3Dtesting/hda

cheers,
  Gerd
