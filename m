Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edi8N-0001mZ-8J
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edi8M-0007P7-Fv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:51:59 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-4-vsementsov@virtuozzo.com>
	<887a889a-e5bc-1a38-7fc9-87bf5d7a6e1b@redhat.com>
	<d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6e71cfa-19f6-8b98-4e6a-a5d230129f62@redhat.com>
Date: Mon, 22 Jan 2018 13:51:41 -0600
MIME-Version: 1.0
In-Reply-To: <d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GNRIIJ8p9sneh2Z9FhlpmRtz4Pp7UVVBK"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GNRIIJ8p9sneh2Z9FhlpmRtz4Pp7UVVBK
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com,
 mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com,
 den@openvz.org
Message-ID: <b6e71cfa-19f6-8b98-4e6a-a5d230129f62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add
 block-dirty-bitmap-enable/disable
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
 <20180116125427.18540-4-vsementsov@virtuozzo.com>
 <887a889a-e5bc-1a38-7fc9-87bf5d7a6e1b@redhat.com>
 <d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
In-Reply-To: <d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 03:09 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>
>> I have to admit exposing this interface still makes me nervous, but :)=

>>
>> Mechanically correct, and with suggesting phrasing changes:
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>

Should we go with an x- prefix for now, and let things settle for a
release before promoting it to fully supported, just in case we find
something that justifies your nervousness in accepting the interface?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GNRIIJ8p9sneh2Z9FhlpmRtz4Pp7UVVBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmQM0ACgkQp6FrSiUn
Q2rdpwf/Vma6uUvC7GHlx5bTT+xdMj7/5F4T63sUGkJJgbqXf4MKBZjXS/cD4kpa
felRzVAeXmTYS6+mA5RdvifSYaIOiE3tkVFK5SCRbq89xn+dmmcg64uqBCZWctW3
ptyxSZbwhnWOMmEQ8mAB40CTeyBGky4PxaTDEhlo/w8zabHkm8jv+9e+XGDBQM4H
8voH4nhB7XiZG0o7eKT/XXI7Aqr8IJTB5NeQeHpoFT4hjTFF308tOtFaFEdmmr12
yVzWMjoziHnIPmDOEpwfmRlQ6isxqhwW3c7E1uD6KpUC5UJIXs8iG0KcqwDE7Rpl
uSHqOnPrzA2LcpP24SbMVCRzUyXJEQ==
=hTrh
-----END PGP SIGNATURE-----

--GNRIIJ8p9sneh2Z9FhlpmRtz4Pp7UVVBK--
