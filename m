Received: from eggs.gnu.org ([2001:4830:134:3::10]:36154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecHv8-0004n1-Jk
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecHv4-0008TW-CL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:40:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ecHv3-0008Sx-OZ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:40:22 -0500
References: <20180118204058.5768-1-f4bug@amsat.org>
	<20180118204058.5768-12-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0f29164-f168-0df2-6a9d-399de14ff2c6@redhat.com>
Date: Thu, 18 Jan 2018 15:40:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180118204058.5768-12-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T3uybE4GekAkE8WlXnJhezoO8EA6oVziY"
Subject: Re: [Qemu-devel] [PATCH v7 11/14] sdhci: implement the Host Control
 2 register for the tunning sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org, Sai Pavan Boddu <saipava@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T3uybE4GekAkE8WlXnJhezoO8EA6oVziY
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>
Message-ID: <b0f29164-f168-0df2-6a9d-399de14ff2c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 11/14] sdhci: implement the Host Control 2
 register for the tunning sequence
References: <20180118204058.5768-1-f4bug@amsat.org>
 <20180118204058.5768-12-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 02:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2015.2]

In the subject, did you mean s/tunning/tuning/?



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--T3uybE4GekAkE8WlXnJhezoO8EA6oVziY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphFEIACgkQp6FrSiUn
Q2q69Qf/QQ7D/ubQuTNcp1tcEtT6RXduO14ysDWGATINIFWwv2VofD0MC/QpKA5w
Y7YbvhJjO2NDqAeTxVLQxz+uqM7nJbP/2E8y8DvZ2mecnpmo4eZ93lXaxr/054mx
9tBFvd+2bC+AQ0RFnyOxZADoOzYOvRF0nz+pyeHnfpJ44AVpRcooXjLRYOpDyCdn
I9oHLPbZWGYa4y+9L73ArbjlmvlAIzjZIdwgVX8ms6PbNofGm5ao6TO7EFOr4LsH
FtYcAKwG9Me/Iv4FmPyTgva37mSaBWdq5MYB70VpTcw17FRGiASHI/6SaxHuHRO8
bDDP7D8FDjFhtIed8n4297LWI/e+KA==
=D7za
-----END PGP SIGNATURE-----

--T3uybE4GekAkE8WlXnJhezoO8EA6oVziY--
