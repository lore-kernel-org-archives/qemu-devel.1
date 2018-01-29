Received: from eggs.gnu.org ([2001:4830:134:3::10]:46974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egCH8-000279-U8
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egCH4-000590-4c
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:27:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egCH3-00058N-Sp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:27:14 -0500
References: <20180129033133.31288-1-famz@redhat.com>
	<20180129110426.GA20446@stefanha-x1.localdomain>
	<e3a60e11-3ce4-effe-b87f-b0112e03eaec@redhat.com>
	<20180129161054.GA1191@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c2bc2ca-d476-f39d-fb57-09b8136fe5ab@redhat.com>
Date: Mon, 29 Jan 2018 10:27:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180129161054.GA1191@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y1W55R1EKNgYnXl0N2ZFLZfmGITIjjpME"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y1W55R1EKNgYnXl0N2ZFLZfmGITIjjpME
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>,
 kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 f4bug@amsat.org
Message-ID: <8c2bc2ca-d476-f39d-fb57-09b8136fe5ab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
References: <20180129033133.31288-1-famz@redhat.com>
 <20180129110426.GA20446@stefanha-x1.localdomain>
 <e3a60e11-3ce4-effe-b87f-b0112e03eaec@redhat.com>
 <20180129161054.GA1191@stefanha-x1.localdomain>
In-Reply-To: <20180129161054.GA1191@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/29/2018 10:10 AM, Stefan Hajnoczi wrote:
> On Mon, Jan 29, 2018 at 08:38:29AM -0600, Eric Blake wrote:
>> On 01/29/2018 05:04 AM, Stefan Hajnoczi wrote:
>>> On Mon, Jan 29, 2018 at 11:31:33AM +0800, Fam Zheng wrote:
>>>
>>> Thanks for writing this!
>>>
>>> I have only reviewed some parts in detail.
>>>
>>
>>>> +
>>>> +On top of libqtest, a higher level library, ``libqos``, was created=
 to
>>>> +encapsulate common tasks of device drivers, such as memory manageme=
nt and
>>>> +communicating with system buses or devices. Many virtual device tes=
ts use
>>>
>>> s/buses/busses/
>>
>> That's one of those stupid English words where both spellings are vali=
d,
>> and which one you get is a matter of preference (I can't even call it =
a
>> US-vs.-UK issue).
>=20
> Thanks, I didn't know there were two spellings for this one.

https://www.merriam-webster.com/words-at-play/plural-of-bus

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--y1W55R1EKNgYnXl0N2ZFLZfmGITIjjpME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpvS1kACgkQp6FrSiUn
Q2rbLAf/TCSLrT7+lSJeE6/cAM6aDnswxB+a+N13/eayaiInyu/AhERuHLMnNe42
OYDS+37ICzzzsSGazn0nOKq+oTSxQl+S69KPqE0PBmcNlvDlOIHFmlTqWZTmFKws
cN3jXpWpAjMCGplmy7g8466DrwiiqP0DjqliqMs7JzU4LUaVwZgAIlq+5KSEqmNe
MjrR97z7mQeCP727Fq6ltQ80a+e7OElWFoh5Xl3PcL+4hBjjnkKv2WEIXWcnR6BS
/aw7g4JWBE3sDGJqwZnyf3junhCx+jk6Nm2Cj5wOj5qD9LJ/lMzP8/pMxKtmjGX2
P29hxuGMw3qxJHiLC6eWThkT1TcDuw==
=Pjjf
-----END PGP SIGNATURE-----

--y1W55R1EKNgYnXl0N2ZFLZfmGITIjjpME--
