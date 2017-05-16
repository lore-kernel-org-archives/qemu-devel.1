Received: from eggs.gnu.org ([2001:4830:134:3::10]:51069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAdga-0004Dm-Gv
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAdgW-0008Qz-L0
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAdgW-0008Q5-Bf
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:42:48 -0400
References: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<48435f6e-a33e-f245-165e-611db0b9105b@redhat.com>
	<5cf0fe20-11b6-d16b-dc60-98523075960d@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acb35bdd-a232-cad2-ea00-1b43296a3517@redhat.com>
Date: Tue, 16 May 2017 09:42:44 -0500
MIME-Version: 1.0
In-Reply-To: <5cf0fe20-11b6-d16b-dc60-98523075960d@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VvVoRWtNvPR7v6aVkTkxSa0auGilTU65g"
Subject: Re: [Qemu-devel] [PATCH RESEND V2 0/3] Optimize filter-mirror and
 filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VvVoRWtNvPR7v6aVkTkxSa0auGilTU65g
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-ID: <acb35bdd-a232-cad2-ea00-1b43296a3517@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V2 0/3] Optimize filter-mirror and
 filter-rewriter
References: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <48435f6e-a33e-f245-165e-611db0b9105b@redhat.com>
 <5cf0fe20-11b6-d16b-dc60-98523075960d@cn.fujitsu.com>
In-Reply-To: <5cf0fe20-11b6-d16b-dc60-98523075960d@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 03:22 AM, Zhang Chen wrote:

>>
>> What's the difference compared with V2? I think I should apply this
>> series?
>=20
> In V2 I forgot remove "," in patch 3/3, Yes, please apply this series.

If you changed the patches, even just to add a ',', then it's best to
post the resend as "v3", not "RESEND V2".  Also, documenting what
changed between versions, rather than just blindly titling a message
RESEND (or even explaining WHY you are resending without change, such as
to correct an incorrect cc to save people the problem of bounce replies
when replying to the thread), is good netiquette.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VvVoRWtNvPR7v6aVkTkxSa0auGilTU65g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGw/kAAoJEKeha0olJ0Nq4lgH/RH9FZbHR3Xxn1cXWPSMvIJP
uE+RJF4oY3BlWxaAcdLD9OR9d2wyI6cc4lJ7rLaiB/UP8U46JWJt73ssWlCxvteU
7mf90HNSctvzLlA+sC71Wgnxxt1srl5+UDpo+D/oOmIWMtBJx8C84JQ7vv4jGFDT
9yZtEq+uB3lJ5fBsjCq/RvvyLpVO8hg5ycpyXSIQ7Qe49iNTI2EM1YUr35zAw8P/
qDIhovZciGxIk5qjYDGFIL8vLjKusis717Rzs80iJaejNQd7Zq/J+DPcP8tftcDX
L94XV6Donbg0D/H5tLjM5n5MD2XigPR/nWUR2vxhWLPfE9EhTtTHGlWdAQnNRE4=
=vuGc
-----END PGP SIGNATURE-----

--VvVoRWtNvPR7v6aVkTkxSa0auGilTU65g--
