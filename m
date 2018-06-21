Received: from eggs.gnu.org ([2001:4830:134:3::10]:49912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVyVK-0004Mw-IE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVyVJ-000549-KE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:15:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
	<152953133362.8870.5068527344743214691@sif>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ea4363f-6711-c6a9-1641-6031eef7cee8@amsat.org>
Date: Thu, 21 Jun 2018 09:15:43 -0300
MIME-Version: 1.0
In-Reply-To: <152953133362.8870.5068527344743214691@sif>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="CSEjHnktLcwr9jjB2R8VRxIb9oCIMZa0X"
Subject: Re: [Qemu-devel] [PATCH 00/113] Patch Round-up for stable 2.11.2,
 freeze on 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CSEjHnktLcwr9jjB2R8VRxIb9oCIMZa0X
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <5ea4363f-6711-c6a9-1641-6031eef7cee8@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 00/113] Patch Round-up for stable 2.11.2,
 freeze on 2018-06-22
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
 <152953133362.8870.5068527344743214691@sif>
In-Reply-To: <152953133362.8870.5068527344743214691@sif>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 06/20/2018 06:48 PM, Michael Roth wrote:
> Quoting Michael Roth (2018-06-18 20:41:26)
>> Hi everyone,
>>
>> The following new patches are queued for QEMU stable v2.11.2:
>>
>>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
>>
>> The release is planned for 2018-06-22:
>>
>>   https://wiki.qemu.org/Planning/2.11
>>
>> Please respond here or CC qemu-stable@nongnu.org on any patches you
>> think should be included in the release.
>=20
> The following additional patches have been queued for 2.11.2:
>=20
>   tpm: lookup cancel path under tpm device class (Marc-Andr=C3=A9 Lurea=
u)
>   tpm-passthrough: don't save guessed cancel_path in options (Marc-Andr=
=C3=A9 Lureau)
>   s390-ccw-virtio: allow for systems larger that 7.999TB (Christian Bor=
ntraeger)
>   crypto: ensure we use a predictable TLS priority setting (Daniel P. B=
errang=C3=A9)
>   qapi: ensure stable sort ordering when checking QAPI entities (Daniel=
 P. Berrange)
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.11-staging

I also noticed these:

9005774b27 gdbstub: fix off-by-one in gdb_handle_packet()
bf78fb1c1b usb: correctly handle Zero Length Packets
62713a2e50 usb/dev-mtp: Fix use of uninitialized values

Regards,

Phil.


--CSEjHnktLcwr9jjB2R8VRxIb9oCIMZa0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsrlvMACgkQ4+MsLN6t
wN5N9RAAsegTg/akEO5skIr0KWgtfCRWKcTLc47A/hkzxBfTC80cd5ay6x1/Lrwr
7/N8Th61CX192NMk3kjOmH80EeFNCLo0Vrd9tiTA9s3nGwHJOZqPnb+yqqYW2a+H
vRz7L0t0TRdOkbAQivr4IBREcUF3P5gxJyxDVMaL9Gid5boDQSpRM+k/b2w64YHv
s1xFMcyrmhHVRCnL05Mjzi/gr+1erg2J5PvCuOAJ1MHCDcpqje9WefDlznPgM7Iu
u3LdXJ6AREEFwcBULqoeGDc2d6gsGUk6FNNEbU/SJtgX4ljryyN4XpOgK1/APysS
12PY/46qDZhQ3w/hcxEPoHGAVKiUwL6jHNJscgtLuQ1wSjgUuIsCINZbF7HFtt00
B59ghfaDgIej4mYn1fwxMQaHCObwDzqDTy8WyU9xPbPMvPsNoYsFsfltfrVTcrvg
htTiCzGD84DCLD/QRmU04kAXhe/4NE1g2tdAq8n9Gao5SZ06eY1Sx45mmxhVxvly
ezCEKmUj0UNEtx2tJd+mrd7IlRgCYjtBczRUtyHVxyud0d/UxPdhUNISVLrXuK2S
NERffKLN9XxjxzxAlJBckSZz9XWO4+I7WkmmXuVSNK8hG/jliHtRE1LSpkPsKpI+
c6y2v4KuwLLBM5I671y5hGm+F3MlbmfSTEnmdqwmKqbqPzAmKnM=
=XeEL
-----END PGP SIGNATURE-----

--CSEjHnktLcwr9jjB2R8VRxIb9oCIMZa0X--
