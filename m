Received: from eggs.gnu.org ([209.51.188.92]:42026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghdAE-0006UP-34
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghdAD-0006l1-48
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghdAC-0006kl-Ry
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:26:37 -0500
References: <20190107163117.16269-1-peter.maydell@linaro.org>
	<20190107163117.16269-25-peter.maydell@linaro.org>
	<20190109055856.GA30631@comcast.net>
	<CAFEAcA__X_w5Dk1FjM_-bF-Ged_uchjpMagxr27-PwcqNaokRQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c27c1148-6a3f-be11-7e79-16ac2117bca5@redhat.com>
Date: Thu, 10 Jan 2019 10:26:33 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__X_w5Dk1FjM_-bF-Ged_uchjpMagxr27-PwcqNaokRQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ovSVdtMJI0Xxv8E1tOzxeTrTKv3HC4JEA"
Subject: Re: [Qemu-devel] [PULL 24/37] qtest: Add set_irq_in command to set
 IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Matthew Ogilvie <mmogilvi+qemu@zoho.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ovSVdtMJI0Xxv8E1tOzxeTrTKv3HC4JEA
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Matthew Ogilvie <mmogilvi+qemu@zoho.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c27c1148-6a3f-be11-7e79-16ac2117bca5@redhat.com>
Subject: Re: [Qemu-devel] [PULL 24/37] qtest: Add set_irq_in command to set
 IRQ/GPIO level
References: <20190107163117.16269-1-peter.maydell@linaro.org>
 <20190107163117.16269-25-peter.maydell@linaro.org>
 <20190109055856.GA30631@comcast.net>
 <CAFEAcA__X_w5Dk1FjM_-bF-Ged_uchjpMagxr27-PwcqNaokRQ@mail.gmail.com>
In-Reply-To: <CAFEAcA__X_w5Dk1FjM_-bF-Ged_uchjpMagxr27-PwcqNaokRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 9:53 AM, Peter Maydell wrote:

>> Note that my miniinfo email account no longer exists, but I
>> can still be reached at mmogilvi+qemu@zoho.com if desired.
>>
>> Regarding the patch, I haven't kept up with changes to qemu
>> well enough to really have a useful opinion, although superficially
>> it looks good.  Perhaps it would make sense to include both
>> my old and new email addresses in the sign-off section, to both
>> tie it to the old threads and make it easier to reach me
>> if someone wants to contact me?  (But I'm not sure of a "clean"
>> way to do so, and it is probably low priority.  Perhaps this
>> current email is good enough?)
>=20
> Thanks for the followup. Unfortunately the commit is already
> in master so we can't tweak the commit message at this point.
> That shouldn't matter much, people don't often fish emails out
> of old commit message logs to email anyway :-)

We can't change the commit message body, but if you are worried about
people still being able to reach you based about a patch they found
while browsing git history, we DO have .mailmap where you can list a new
preferred email address to use in place of any commits you made under an
old address.  Patching .mailmap is a nice (but optional) way to let
people know how to reach you, if you still expect to be reached.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ovSVdtMJI0Xxv8E1tOzxeTrTKv3HC4JEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3cjkACgkQp6FrSiUn
Q2q44Qf9E6cNH4EJkEEsj/+9X7qzHXchm5DFR8V7t0mOj5+iJ3YaC6kmKxdp6wlQ
bV1BizRHpQf2e6p2511yY1YyK7kHiswJguq+Se7dgO7sDc0PwySmNhICAmmVGQto
ziSwz1yek7VOJRCXLXfpkk2jd6BwY9AWUy/nWhdf/wtg8cpCcOkTpqmZY75ssBxY
D9JDDQANsqG8ptLNw5KRfw+jz8jxjBwDtyYqBrxVXFrQJkFICdKyxhebrRPJXxJh
kdSp02LkCuxAZmwVJ3z/ZoWhsdOVbRSJWbdJsk6FlfwDUxMrbh9TJKVa1t/FA1Fm
4RQYbxf2+AKHxmxvBbI7R5ZcOzBGOw==
=oyTP
-----END PGP SIGNATURE-----

--ovSVdtMJI0Xxv8E1tOzxeTrTKv3HC4JEA--
