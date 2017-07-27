Received: from eggs.gnu.org ([2001:4830:134:3::10]:55411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dal1H-0004zb-TT
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dal1E-0004DU-Nm
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dal1E-0004D5-HF
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:08 -0400
Message-ID: <1501170486.9298.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 17:48:06 +0200
In-Reply-To: <20170727141120.4970-1-berrange@redhat.com>
References: <20170727141120.4970-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

  Hi,

> Changed in v3:
>=20
> =C2=A0- Treat entire '0xe1 0x1d 0x45 0xe1 0x9d 0xc5' as make code,
> =C2=A0=C2=A0=C2=A0there is no break code for PAUSE.

Peter just pulled, can you send this as incremetal against v2?

thanks,
  Gerd
