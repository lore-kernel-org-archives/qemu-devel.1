Received: from eggs.gnu.org ([2001:4830:134:3::10]:56546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capXF-0000EE-U2
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 15:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capXB-0002Cp-Kx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 15:05:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1capXB-0002CJ-Cq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 15:05:09 -0500
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23242d7d-c25c-9486-a845-47b58867b543@redhat.com>
Date: Mon, 6 Feb 2017 14:05:00 -0600
MIME-Version: 1.0
In-Reply-To: <CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rq7mK4tlf5Nvmo0HAr0LQNrAadaFuHoEk"
Subject: Re: [Qemu-devel] [PATCH v10 00/23] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@greensocs.com>, Peter Maydell <peter.maydell@linaro.org>, nikunj@linux.vnet.ibm.com, Jan Kiszka <jan.kiszka@siemens.com>, Mark Burton <mark.burton@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, qemu-devel <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Sergey Fedorov <serge.fdrv@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rq7mK4tlf5Nvmo0HAr0LQNrAadaFuHoEk
From: Eric Blake <eblake@redhat.com>
To: Pranith Kumar <bobby.prani@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, nikunj@linux.vnet.ibm.com,
 Jan Kiszka <jan.kiszka@siemens.com>, Mark Burton
 <mark.burton@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Sergey Fedorov <serge.fdrv@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>,
 =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>
Message-ID: <23242d7d-c25c-9486-a845-47b58867b543@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 00/23] MTTCG Base enabling patches with
 ARM enablement
References: <20170206153113.27729-1-alex.bennee@linaro.org>
 <CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
In-Reply-To: <CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2017 01:06 PM, Pranith Kumar wrote:

>> A version of the tree can be found at:
>>
>>   https://github.com/stsquad/qemu/tree/mttcg/base-patches-v10
>>
>=20
> I've sent my Reviewed-by/tested-by for v9 but those seem to be lost.
> I've tested v10 too.
>=20
> So please add my tested and reviewed tags:
>=20
> Tested-and-Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

I don't know if all the tools honor this spelling; but if it were me,
I'd assume it is better to split it into two lines, one for Tested-by:
and the other for Reviewed-by:

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rq7mK4tlf5Nvmo0HAr0LQNrAadaFuHoEk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmNbsAAoJEKeha0olJ0NqAjIH/i/dSv9SRtm0KR+0nNsOkhJR
EJD8pbzD/h9rHdl1PZyjyEm+w/ATC6eFbWtot5chU+f7IHB94XdZAsJzlslO+k90
v9HwUwYsgbGX0YnR7Gpz+LSExNjSd6x/cXdSOebjalggy6TmXj3mVEWGYGEeZzQV
kqaadn0apQ9USvYZbkrVxDCXjYRCwj4Fo6dV788j29UBVDpi+a5q5Oznt+nW2GMU
yOELjQKq6zwnUsxudAF4wJDTAp09/V5S64B4WT04EkIirt8N4FV6RHrD/bp6E20n
iodisImOPN81nnIauLTC/UBPxZUrSTafdu0CXuI0XIKK0A+b+2YzgFe7Yv1IDs4=
=Ubkb
-----END PGP SIGNATURE-----

--rq7mK4tlf5Nvmo0HAr0LQNrAadaFuHoEk--
