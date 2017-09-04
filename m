Received: from eggs.gnu.org ([2001:4830:134:3::10]:55482)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dp17j-0008Gh-7g
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dp17e-0001V8-LB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:49:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:50154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dp17e-0001UW-AX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:49:42 -0400
References: <20170903163726.16541-1-n54@gmx.com>
	<20170904072353.GA19748@lemon.lan>
	<17D7366F-5413-4A0B-B984-33ED480A9A3C@daynix.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8c58f1f4-28e2-59e8-e8e6-fa09d546dbca@gmx.com>
Date: Tue, 5 Sep 2017 01:51:48 +0200
MIME-Version: 1.0
In-Reply-To: <17D7366F-5413-4A0B-B984-33ED480A9A3C@daynix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CC3NcwvbpshjEBgfKSp4apCnK1acRe27r"
Subject: Re: [Qemu-devel] [PATCH] e1000: Rename the SEC symbol to SEQEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, Fam Zheng <famz@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, Jonathan Perkin <jperkin@joyent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CC3NcwvbpshjEBgfKSp4apCnK1acRe27r
From: Kamil Rytarowski <n54@gmx.com>
To: Dmitry Fleytman <dmitry@daynix.com>, Fam Zheng <famz@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org,
 Jonathan Perkin <jperkin@joyent.com>
Message-ID: <8c58f1f4-28e2-59e8-e8e6-fa09d546dbca@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] e1000: Rename the SEC symbol to SEQEC
References: <20170903163726.16541-1-n54@gmx.com>
 <20170904072353.GA19748@lemon.lan>
 <17D7366F-5413-4A0B-B984-33ED480A9A3C@daynix.com>
In-Reply-To: <17D7366F-5413-4A0B-B984-33ED480A9A3C@daynix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please put it on a pull-request queue. I don't maintain one myself.

On 04.09.2017 09:29, Dmitry Fleytman wrote:
> Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
>=20
>> On 4 Sep 2017, at 10:23 AM, Fam Zheng <famz@redhat.com> wrote:
>>
>> On Sun, 09/03 18:37, Kamil Rytarowski wrote:
>>> SunOS defines SEC in <sys/time.h> as 1 (commonly used time symbols).
>>>
>>> This fixes build on SmartOS (Joyent).
>>>
>>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>>>
>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>
>> Cc Jason Wang (net maintainer).
>>
>> Fam
>=20


--CC3NcwvbpshjEBgfKSp4apCnK1acRe27r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrecaAAoJEEuzCOmwLnZs1uwP/0nTqqHMAz47caUFP8iotzdZ
0QDlo3IaJF2wS0ZvkwnJJKyRdIFZVSPG/0rSVYO476tmB3Py8X7ubNgSSmSNta5u
DLPjypT0OOV36/hKLTzrS5ipS0wzHpseaX+cTV60GErABPgZUriuf1vGBbM+Fvj+
f6lVKkzmAmAFkrMuVCLc3d85eEpCkYuJtrxfl4Vg8lCTPUv6LHf5Se/Pb43FdWqs
vcYbW3Leh0l8z8oISWAc0mRPD742ez09BB/O57dQ1i6uitiRI+dtIZdz+4k2ziyC
0g4u5cCtH2u0K9yQx9hbYlK8eaoBtvmzYS6/hmcg8dtWz9JfHMYRCagIVYYYc6Ks
S52mB5nB0pZikcN6PnYt7omxgrhTHa/PIgBB43dRvIflpAknh6fyCE1uC30Smttf
YM30ii9f2wgexbPH2jJGYrlyoF/hIyvqs7JHjdVdLDtrm7jGRd2giD2rtBq8lSn4
KDxSXYIeyaRSPAdTEDm+6h73yyWsKOJQoNdUjU85kLmov6glQi7W7d1CxcpycQBK
B/JzH1Sm0PgTSI9+g/fZ9goEdcUinNqj95G1Ohx4k7GBNuiug9VlEUCecF0DCuKL
CUk+lh3/dPV3S5vLKKN7fBzX+1IZ3OKqmNNFVAIpNbj9nfzUKqgWp4GhBTe5dOEi
Jk5hoVXWhdRpU6Z66gU3
=Mq+1
-----END PGP SIGNATURE-----

--CC3NcwvbpshjEBgfKSp4apCnK1acRe27r--
