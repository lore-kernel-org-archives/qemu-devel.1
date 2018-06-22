Received: from eggs.gnu.org ([2001:4830:134:3::10]:42791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWB0t-0003lu-O5
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWB0q-0007gz-Lg
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:37:23 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWB0q-0007gv-GZ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:37:20 -0400
Received: by mail-qk0-x242.google.com with SMTP id g14-v6so2902511qkm.6
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 18:37:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<20180622005134.GC612@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <84aa3623-0b93-182e-d9bb-6acca7a7d7ea@amsat.org>
Date: Thu, 21 Jun 2018 22:37:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180622005134.GC612@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="gmTXuPk9PZ9PO6Ndv0BEQUeL7Nz6R4Kai"
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gmTXuPk9PZ9PO6Ndv0BEQUeL7Nz6R4Kai
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <84aa3623-0b93-182e-d9bb-6acca7a7d7ea@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
References: <cover.1529568501.git.balaton@eik.bme.hu>
 <20180622005134.GC612@umbus.fritz.box>
In-Reply-To: <20180622005134.GC612@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Cc'ing Gerd who maintains many hw/display/ files.

On 06/21/2018 09:51 PM, David Gibson wrote:
> On Thu, Jun 21, 2018 at 10:08:21AM +0200, BALATON Zoltan wrote:
>> These are fixes to sm501 emulation that were found while testing with
>> AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we have=

>> no way to verify it against hardware). While this is mainly to improve=

>> sam460ex emulation this is now a separate series with the sm501
>> specific patches because that's also used on SH emulation. I hope
>> someone can review and merge this.
[...]
> hw/display/sm501.c                 | 166
+++++++++++++++++++++++++++++++++++--
>=20
> I'm not really familiar with the sm501 hardware, so I can't speak to
> these technically, beyond the fact that there's nothing obviously
> bogus.
>=20
> I can say that BALATON Zoltan is the only person who's made
> non-trivial changes to sm501 lately, and there don't seem to have been
> any screams, so I'm pretty happy to assume he knows what he's doing.
>=20


--gmTXuPk9PZ9PO6Ndv0BEQUeL7Nz6R4Kai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlssUscACgkQ4+MsLN6t
wN484A/9HZ6Mxu1LEttT40duQTlliF2aODAFXHVUzhabRTPhrqx7QkCh1akWmoEx
NnxNynENYYdEu1YDrW5TIj1DwvRZiTjWmJuJjmXnPbnky8y2aEVJa6bceqORj7ZM
W86XzZ7YIAa3pHQGLcBcb4Rtf11X+a8dXrMGn8aqlCUc3OSbgz44784vqNA4eAud
Q67NjTxo0iD7T9QeofDsq8VqJD+K3U4lKB750CIzH2cpKV+JZdmO93pGAi9XpjTc
GlG2Cl4q2FFQGvrMeLyF0v0LhHKn9VtktTToMmeecQs8bKt01maE7TjH7H9+1Ehr
aOBsAMYFqppYSqSNLXhj+hmWg/LQnxHJfXfIgVzKCggA3nfKQjGXpErUnvjo8oMe
Qf68W/2UxoIwt+5cf4jV5y+7LLyvqNpqiUSZu6qx9D1piT/C3+mq2thph3pz2new
1DQZ1FYpwiWHfACb0Z1Zl+9iVSGCfG/piURytD92mTR2dhRHUY9h3qOmvh6i+Imt
fdW4Vs8CWrKsZrlBvStq8DCUZvdfsPOuAYcjzC55yJk+08Na/ivXvYnOfdK3Xtnm
MbMdatmuzSEa/iHhZnp0UL9w+6Hz6+dKcbUKuFudYUqWS2wl76iJtOb9L44wPMsL
E3vaTYwtBkbILEirRrxZs/DTADyDa18suwvTTGqlIBg/R3jDbB8=
=vRnp
-----END PGP SIGNATURE-----

--gmTXuPk9PZ9PO6Ndv0BEQUeL7Nz6R4Kai--
