Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1eRYBg-0000gK-V8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1eRYBc-0000e3-UH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:49:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.vnet.ibm.com>)
	id 1eRYBc-0000V9-Lq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:49:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBK6lUvR035592
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 01:48:51 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eyc76pj67-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 01:48:51 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.vnet.ibm.com>;
	Wed, 20 Dec 2017 06:48:48 -0000
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-10-f4bug@amsat.org>
From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 07:48:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171219173425.8113-10-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1MqntmXQwgVALq34zGMVzaYQc3yT799cv"
Message-Id: <7c0f95d3-3135-b1c8-b7fe-160e18814368@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests.py: use io.StringIO with
 python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1MqntmXQwgVALq34zGMVzaYQc3yT799cv
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>,
 Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <7c0f95d3-3135-b1c8-b7fe-160e18814368@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests.py: use io.StringIO with python3
References: <20171219173425.8113-1-f4bug@amsat.org>
 <20171219173425.8113-10-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.12.2017 18:34, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/iotests.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 4c515d2e6c..0e1b8ab6e6 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -459,13 +459,16 @@ def main(supported_fmts=3D[], supported_oses=3D['=
linux']):
>=20
>      # We need to filter out the time taken from the output so that qem=
u-iotest
>      # can reliably diff the results against master output.
> -    import StringIO
>      if debug:
>          output =3D sys.stdout
>          verbosity =3D 2
>          sys.argv.remove('-d')
>      else:
> -        output =3D StringIO.StringIO()
> +        try:
> +            from StringIO import StringIO
> +        except ImportError:
> +            from io import StringIO
> +        output =3D StringIO()

*Please* make a commit message that mentions that StringIO was moved
into the io package for py3. It took me way too long to make any sense
of this change until I read the except statement.
Maybe also add a comment.



--1MqntmXQwgVALq34zGMVzaYQc3yT799cv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaOgfIAAoJEBcO/8Q8ZEV5b0oQALAlqoOW3oImjIV1R/WkkIJJ
edpxVNFujct/LHL0m1fpCAXcUNHdNNm88tJPXhgynLkK9L+fL+Zc7VcOiO7UtxeO
WjhndpdKtiFJHAPZtHUX2PoMV/W3zQFFLRe53jWzWymqk03IZkDrvc9th+J+Od2T
VRGreMnhI1KCO65fGD1HUyZiWYTZBsZ0mK9ILy4l5Et9SfkdYhX3hiaYOT/U3zC1
JZWUVEsBlUlCa11CKFRkz5TMoDLe0bRADrgfzQ94Py/TB5FEANBIIhw5pC0Ph8tc
f6COJFPr+3bZJGq61ha8ziX6HlvPveu32rRIsKMghzH4ERQNoNdjOaVcrWVakE1o
B9Sq34BhLawKypTpgashnkQaqEGZKrGKDwEcDqsdU/r+8uXOUoijucA7wfupJ854
Ls3vaFQTKunAxTbNQd6AQo3aEDF79pvEnrVtlTJbCQYXtY5OdbcuFANYydqZvNy7
uCn3XenI+IQn7JxgWpemEEwc9mXA3VT+ugAHOODcnbE6iBwSxxfSW7xozdHou5wP
VYyYcMOxI7ZWUE5xeORGIxICVa7LHfunfqQpQinQcpRGtuY4tRCU15XqpROM4tpN
fvOGa53G2Pkcwz5sSIkkue6MdNZw5jrqyquIq0biA6+bGwCesC31y9h9gmIQ+/Tp
6NDtOgy8H8zoOz1n3SXA
=srLx
-----END PGP SIGNATURE-----

--1MqntmXQwgVALq34zGMVzaYQc3yT799cv--
