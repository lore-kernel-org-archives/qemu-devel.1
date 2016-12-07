Received: from eggs.gnu.org ([2001:4830:134:3::10]:60399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEZ5H-0007jL-6F
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEZ5C-0001cK-8f
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:04:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cEZ5C-0001c9-2e
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:04:14 -0500
Message-ID: <1481105051.11413.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 07 Dec 2016 11:04:11 +0100
In-Reply-To: <e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
References: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
	<e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] ui/egl-helpers.c license and reuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Frediano Ziglio <fziglio@redhat.com>, Qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, Cole Robinson <crobinso@redhat.com>

  Hi,

> "IANAL,"
>=20
> Looks like the file was authored by four people with no explicit
> license, so it defaulted to GPL2.
>=20
> Cole Robinson, Gerd Hoffman, Gonglei, and Peter Maydell.
>=20
> Maybe you can get explicit permission from these four.

I'm fine with relicensing the file.

I'd suggest you send a patch explicitly licensing the file to LGPLv2,
Cc'ing anyone who touched the file.  I'll go collect the ACKS and merge
the patch once we got them all.

cheers,
  Gerd
