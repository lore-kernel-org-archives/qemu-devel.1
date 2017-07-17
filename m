Received: from eggs.gnu.org ([2001:4830:134:3::10]:45230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dX6Ge-0002ip-5l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dX6GZ-0004Cb-8M
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:40:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dX6GY-0004C5-Vg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:40:51 -0400
References: <20170717063521.GA7393@lemon>
	<20170717103937.GD5301@noname.redhat.com>
	<CAFEAcA9zoauJw-CnNxtec48VOr6onXiCZ8BV8JJwk7ZeOLxnUw@mail.gmail.com>
	<20170717113115.GE5301@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7cdcea0f-5c26-4e18-d7f0-fa11606ba2c9@redhat.com>
Date: Mon, 17 Jul 2017 15:40:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170717113115.GE5301@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hSRiranaHn1MOXdBiIFPWC0auK3rxQoLD"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hSRiranaHn1MOXdBiIFPWC0auK3rxQoLD
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <7cdcea0f-5c26-4e18-d7f0-fa11606ba2c9@redhat.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
References: <20170717063521.GA7393@lemon>
 <20170717103937.GD5301@noname.redhat.com>
 <CAFEAcA9zoauJw-CnNxtec48VOr6onXiCZ8BV8JJwk7ZeOLxnUw@mail.gmail.com>
 <20170717113115.GE5301@noname.redhat.com>
In-Reply-To: <20170717113115.GE5301@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-17 13:31, Kevin Wolf wrote:
> Am 17.07.2017 um 12:49 hat Peter Maydell geschrieben:
>> On 17 July 2017 at 11:39, Kevin Wolf <kwolf@redhat.com> wrote:
>>> Only today I noticed again that two recently merged pull requests bro=
ke
>>> qemu-iotests cases, so I must assume that apart from some block
>>> maintainers, nobody runs it regularly.
>>
>> If "make check" doesn't run it, it doesn't get run :-)
>> I actually looked into trying to run qemu-iotests tests
>> for the recent patches I sent for vpc and vmdk image format
>> handler fixes, but I couldn't get it to do anything sensible
>> and I couldn't find any documentation, so I gave up and
>> assumed that "make check" plus manual testing was good enough...
>=20
> I think we had it in 'make check' for a while, but I seem to remember
> that people complained about things like the disk space that some of th=
e
> tests needed for temporary files, and some exotic systems didn't suppor=
t
> sparse files or something like that.

Wasn't that exotic system HFS+ on OS X/macOS? As far as I'm informed,
macOS has recently switched to APFS which does have sparse files (and I
think they have automatically converted running systems to APFS).

Max



--hSRiranaHn1MOXdBiIFPWC0auK3rxQoLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZbL5dEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQBkC
B/4/iSL1NBklv5Uzrde7/o86stbCidxoI5mTguAHG2+D3noiMlQQ3U32x7GdjBaY
JKN57tT91yQ58Sn9QpYJJvfkRi8K/5PvSXjbKaaOdn1gmwO8OfXiRBo5MyQ2waU/
opKMmzdubiFWpAQY/im0QoYNWbtKeuxzdWJoaYtiJloiQhq/wWxB8oVtUNpu6v1I
PfrGxUiFuDPbmEf+ZznUf9cy2ecRXmkCJRh57ULCkg56EU52qzkWKmACbO/th7CM
hBfuIAC+HTOR7SWikdmBpWR3dUNL+38z+6Xm9/ShkFUrxAvqRASJZ4hqUlxsPnwV
2/kJF16+546IGOnfJm8CNuEz
=CFOX
-----END PGP SIGNATURE-----

--hSRiranaHn1MOXdBiIFPWC0auK3rxQoLD--
