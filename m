Received: from eggs.gnu.org ([209.51.188.92]:51623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2IBj-0003G9-4o
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2IBi-0006ba-DD
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:17:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h2IBi-0006Y9-1M
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:17:34 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
	<CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
	<20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
	<CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
Date: Fri, 8 Mar 2019 10:17:17 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yQe09y6SAz15ID7RYkbfPTcEgj8GBTrc8"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yQe09y6SAz15ID7RYkbfPTcEgj8GBTrc8
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>
Message-ID: <e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
 <87r2bigarf.fsf@zen.linaroharston>
 <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
 <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
 <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
 <20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
 <CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
 <20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
 <CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
In-Reply-To: <CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/8/19 6:03 AM, Peter Maydell wrote:
> On Fri, 8 Mar 2019 at 11:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> On Fri, Mar 08, 2019 at 10:31:20AM +0000, Peter Maydell wrote:
>>> I think in fact I have just broken in-tree builds with the
>>> Sphinx support patchset :-/
>>
>> Great opportunity!  Stop supporting in-tree build fixes a bug,
>> so this can be merged post soft-freeze.
>=20
> Joking aside, this is quite tempting, because Sphinx simply
> does not support building into the same directory as its
> source documentation files. So we need to either:
>  * create an ad-hoc build directory (eg docs/built)
>    where Sphinx builds the docs to if we're doing an
>    in-tree build, and have the 'make install' phase pull
>    the docs out of there

Lots of work to just throw away if we plan on doing a flag day in 4.1.
But necessary if you want 4.0 to still support in-tree builds for one
last hurrah.

>  * declare in-tree builds to be no longer supported at all

Moves the flag day a bit sooner (today! surprise!), but I can live with
this.

How long do we wait for objections, or should we pull the trigger?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yQe09y6SAz15ID7RYkbfPTcEgj8GBTrc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyClY4ACgkQp6FrSiUn
Q2oE9Qf8CNk0MxII6rHavK7rG/h3n7SSrIOG8s5xBk4B43rsrANOWEbDVHnaXiRW
EcML3sLgWK6cgUTzp6zc2s2HVsLN3LdVge2E7pkqXv+WZgIQ0e+K3yeZ/aaGHgsz
EkId2hG+OFTJlvTn0GzJi53NESdfUNp50UjYQyvE/tWmz51wGRmVEjja34zW3KLJ
+phsoVZH8tnpDwdV6TGqI/02JLN5S6sZM3LCxZrH8DZV2RcOKDMYaG+zkMvVvZfh
3RbtDbDQwDghNa4NginPn+Nqey1/cEoyawEuOHesGi/fNF0n4mfE3FvmwjsShEil
3o9UBLHSUvtM8IuM/LDw/gkxykkoSw==
=ZeuY
-----END PGP SIGNATURE-----

--yQe09y6SAz15ID7RYkbfPTcEgj8GBTrc8--
