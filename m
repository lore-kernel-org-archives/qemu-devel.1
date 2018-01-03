Received: from eggs.gnu.org ([2001:4830:134:3::10]:37652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eWqpz-0002Kw-Hb
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eWqpw-0007wh-VY
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:44:39 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:45930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eWqpw-0007wO-Qc
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:44:36 -0500
Received: by mail-it0-x243.google.com with SMTP id z6so127074iti.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:44:36 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.15762.1515014732.27992.qemu-devel@nongnu.org>
Date: Wed, 3 Jan 2018 16:44:33 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <34798C74-612D-4484-9781-A3CFB261C383@gmail.com>
References: <mailman.15762.1515014732.27992.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/25] SDCard: housekeeping, improve 	SPI,
 introduce new Specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, m.olbrich@pengutronix.de, Andrzej Zaborowski <balrogg@gmail.com>, "Cc: Philippe Mathieu-Daud?" <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, pjp@fedoraproject.org, crosthwaite.peter@gmail.com, Paul Brook <paul@codesourcery.com>, Marc-Andr? Lureau <marcandre.lureau@redhat.com>


> On Jan 3, 2018, at 4:25 PM, qemu-devel-request@nongnu.org wrote:
>=20
> Message: 10
> Date: Wed,  3 Jan 2018 18:24:11 -0300
> From: Philippe Mathieu-Daud? <f4bug@amsat.org>
> To: Alistair Francis <alistair.francis@xilinx.com>,	Peter Maydell
> 	<peter.maydell@linaro.org>,	Igor Mitsyanko =
<i.mitsyanko@gmail.com>,
> 	Andrew Baumann <Andrew.Baumann@microsoft.com>,	Olbrich
> 	<m.olbrich@pengutronix.de>, Andrzej Zaborowski =
<balrogg@gmail.com>
> Cc: Philippe Mathieu-Daud? <f4bug@amsat.org>,	qemu-devel@nongnu.org,
> 	"Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,	Prasad J =
Pandit
> 	<pjp@fedoraproject.org>,	Peter Crosthwaite
> 	<crosthwaite.peter@gmail.com>,	Paul Brook =
<paul@codesourcery.com>,
> 	Marc-Andr? Lureau <marcandre.lureau@redhat.com>
> Subject: [Qemu-devel] [PATCH v2 00/25] SDCard: housekeeping, improve
> 	SPI, introduce new Specs
> Message-ID: <20180103212436.15762-1-f4bug@amsat.org>
> Content-Type: text/plain; charset=3DUTF-8
>=20
> Hi,
>=20
> This series intends to simplify the sdcard device:
> - add trace points,
> - have a more robust SD mode,
> - improve the SPI mode,
> - introduce the MMC mode (split for a later series)
>=20
> 3 patches as tagged RFC as I need to fix few XXX comments,
> checking back the specs.
>=20
> Since v1:
> - rewrote mostly all patches to keep it simpler.
>=20
> Regards,
>=20
> Phil.

Is there a way to make this SD card reader work with Mac OS X or Windows =
guests?=
