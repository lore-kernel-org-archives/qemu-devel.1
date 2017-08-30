Received: from eggs.gnu.org ([2001:4830:134:3::10]:56372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dn7a6-0003FN-Jv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dn7a1-00057o-SQ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:19:14 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:63763)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dn7a1-00057Y-Lo
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:19:09 -0400
Date: Wed, 30 Aug 2017 19:19:06 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170830181906.GB979@jhogan-linux.le.imgtec.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817172249.31cf5e3d@nial.brq.redhat.com>
	<e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
	<20170830155008.1babd407@nial.brq.redhat.com>
	<bef4e017-02f3-62c4-1621-ec118709717c@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <bef4e017-02f3-62c4-1621-ec118709717c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, Aug 30, 2017 at 11:41:38AM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Igor,
>=20
> On 08/30/2017 10:50 AM, Igor Mammedov wrote:
> >> [...]
> >>>> Also I couldn't test it with KVM.
> [..]
> >>
> >> I'll wait to see if there is some KVM feedback from imgtec folks before
> >> spaming a v2.

Sorry for the delay,

> >=20
> > Philippe,
> >=20
> > Are you going to respin series soon?
>=20
> I'm waiting 2.11 officially announced open to send it which should be=20
> tomorrow, in the meaning time it is available in my git repository at:
>=20
>    git://github.com/philmd/qemu.git tags/mips-qomify-20170830

A sanity check of your branch doesn't reveal any obvious regressions
when booting a Malta KVM guest kernel with KVM.

Cheers
James

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlmnAZAACgkQbAtpk944
dnqE8hAAi2/iUjfeUM699IqRcgAHxP2HKePXp/3fzzcjePOtNQYtkFC7uAOuF8u3
YMsX0huQ42oQSXlXCIFF5UcFNWEfBvh8ltWKc88WkMO6EiltE8C6etAMlCqp1YWp
kYQKa9QHtJLOY+2XHfKFK5MBhPdnzOFiC6Myxy6iIHtyQbKreEfjFNYJe9jy2OMK
+rshM+M/NBS/wyuxKYt4f6yZFN8M6oWDkGhTZ3Q0POIBaTOzQRxFXN8wM8qofzZE
4AY/ipWHNEZhYpaZx7DApChaV77FI2Db4e9Iret1bpzpm97NaGOWANiAnlRJ/w8b
rVIT7FTWFJGTNCr7JqIjlCh5jsuVBMsbu7N1G99gwojc1DX99czVCnl/bNtvrdvd
iaTZQGWYtMA3xNJSNZOgG6AAUe7fRIZhBS6KZmC5ZYYeb8krQ5/JOEHzQG9XdFyq
VGqt5p3U3fGqXA+m2JuVljmyPtHifIZo9bWg832+AvlgJlNMrxkANH2wVeJk1B68
6oEoE0iefZILzKh2gZCZ5IE+4zUNiimGakdsKs/a5U0lyunA/J1AIwJV3SuoKVks
LoeY6W0fdCHjYBJnhzJl2th+3rbfHUSvcRiz7Uj4oDhuZMZ7BMficOon511BpTcX
x7kbArwfP5LVxwppV9e3rg6BAJEW+ZDzqftSIjLZL130vuVz+mw=
=R3/Q
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
