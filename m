Received: from eggs.gnu.org ([209.51.188.92]:48951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Xf-0001VL-A9
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Xd-0000GM-Ct
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:21:11 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<7b3e80fd-e982-20d1-5885-255eb7a123ae@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4e90b32-3cee-fa88-0901-73850cf41af0@redhat.com>
Date: Thu, 17 Jan 2019 08:20:49 -0600
MIME-Version: 1.0
In-Reply-To: <7b3e80fd-e982-20d1-5885-255eb7a123ae@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xipUG9SljjalBzsXE3ZcOkfznwLAlF5Gn"
Subject: Re: [Qemu-devel] [PATCH v3 00/19] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xipUG9SljjalBzsXE3ZcOkfznwLAlF5Gn
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <a4e90b32-3cee-fa88-0901-73850cf41af0@redhat.com>
Subject: Re: [PATCH v3 00/19] nbd: add qemu-nbd --list
References: <20190112175812.27068-1-eblake@redhat.com>
 <7b3e80fd-e982-20d1-5885-255eb7a123ae@virtuozzo.com>
In-Reply-To: <7b3e80fd-e982-20d1-5885-255eb7a123ae@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 5:38 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Since v2:
>> - Several patches merged already
>> - 3 new patches based on audit of off_t vs. strtol
>> - rebase patches on top of other changes, such as qemu-nbd --bitmap
>> - address various review comments [Vladimir, Rich]
>> - drop patch 12/22
>>
>> 001/19:[0020] [FC] 'maint: Allow for EXAMPLES in texi2pod'
>> 002/19:[0030] [FC] 'qemu-nbd: Enhance man page'
>=20
> Strange, but I don't have 02 in my mailbox..

I'll bounce a copy to you...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xipUG9SljjalBzsXE3ZcOkfznwLAlF5Gn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAj0EACgkQp6FrSiUn
Q2pAKwf+OlcIalcIfTqlYpIqUPh1l4R138c81EG9dvTM+LpNmvlTDTo/cKoci5TS
bDYfLrFf1FFUreeWvwfElEXnevnhr6dpSTCF7+n6WxLZLnYEshovUB97XhmU7UZu
9FvrCj2Id3xWEt6x/+P/yH540EKctuFMVvE7ID1zaqAhIHGpxhOWWDInJLTDO8nk
CKYGw/x0vsi+Q7ZpJs8PjQQylgkpiI4nwH53nK9CJLPkNzeb0PRwLxUSRggqHD5K
xyms+7HDMO6tjtZdfwsgTRe/9klmHItT9z39Kbi0n4thjHW0z//vxWrChB2WOvtC
UIpZRzkvMERgmoGw+sQ1uGy6f+cAFw==
=sAIn
-----END PGP SIGNATURE-----

--xipUG9SljjalBzsXE3ZcOkfznwLAlF5Gn--
