Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eg7bO-0001PJ-Cu
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eg7bJ-0004Pr-E9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:27:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eg7bJ-0004OR-4X
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:27:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C52E461C5
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:27:47 +0000 (UTC)
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
	<7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
	<64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5fdc573-d44a-ca23-6e51-0cdeb0087771@redhat.com>
Date: Mon, 29 Jan 2018 12:27:40 +0100
MIME-Version: 1.0
In-Reply-To: <64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3QFvYPUy9pPUOQ4z0jgrxb4qkhI7KYFpH"
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add "Understanding QEMU devices"
 blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QFvYPUy9pPUOQ4z0jgrxb4qkhI7KYFpH
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <b5fdc573-d44a-ca23-6e51-0cdeb0087771@redhat.com>
Subject: Re: [qemu-web PATCH] Add "Understanding QEMU devices" blog post
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
 <7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
 <64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
In-Reply-To: <64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.01.2018 15:46, Eric Blake wrote:
> On 01/26/2018 06:40 AM, Paolo Bonzini wrote:
>> On 26/01/2018 10:19, Thomas Huth wrote:
>>> Last July, Eric Blake wrote a nice summary for newcomers about what
>>> QEMU has to do to emulate devices for the guests. So far, we missed
>>> to integrate this somewhere into the QEM web site or wiki, so let's
>>> publish this now as a nice blog post for the users.
>>
>> It's very nice!  Some proofreading and corrections follow.
>=20
> Thanks for digging up my original email, and enhancing it (I guess the
> fact that I don't blog very often, and stick to email, means that I rel=
y
> on others helping to polish my gems for the masses).

Sure ... Would you like to give it a try this time and continue with the
patch, or shall I continue and send a v2?

>>> +++ b/_posts/2018-01-26-understanding-qemu-devices.md
>>> @@ -0,0 +1,139 @@
>>> +---
>>> +layout: post
>>> +title:  "Understanding QEMU devices"
>>> +date:   2018-01-26 10:00:00 +0100
>=20
> That's when you're posting it online, but should it also mention when I=

> first started these thoughts in email form?

At least in the header we should have the current date, or the blog post
will not show up at the top of the blog. Not sure whether there is an
alternate field for the original date ... maybe we could rather add an
"originally written in 2017 ..." sentence at the bottom of the post inste=
ad?

 Thomas


--3QFvYPUy9pPUOQ4z0jgrxb4qkhI7KYFpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJabwUwAAoJEC7Z13T+cC21nGoQAK/kNZkJLuGHvw8ALrlKUnS9
7jNp1ArQOVEOTtidToeRux8yN07ghkGFOaG5tRtCeVNoEy8/CobXcjGXSu5E0xhz
t8SNgx+l3YwhkDnEfrwMIjEXRTkLBDmjWS89kNHug0txHsJjGZUT4LM6DQJZuYRl
rM9PVCEx2CDwt7c/MuJw8M96OygnA9oKcn6eqoWTClJiTgbbklPuktzoikvJEk5O
nKb6mOVeCRAmhzdzO9MA2+RqX7oH6fQM/FBE47PDcQOcv5unt1dY+lUx07x0jMXi
9SfWNUbFfwuRG93nNfxPpRRdPurIwnJNV9Dn3eyrcG9aaxrpYniCaVL+yXxIynnC
+XqGHWnRdmKX7Uk7ySZwV4RbIP9kHOFS043sJze07F/k0nFwx5njSVTq11Wi6bkP
XLod9lNnRf28bKewNK7DVwzk5Zb8b+W/5LXVp980FY82o2YhWRmPAoW7IiNZ8krN
8eScpNjrNIyMWkky7adBal6y4qSyuB+ARRHdPVC5NhJRwiIyWB9rsed7/0fb04iI
2TcRuRkpgXAXw+n1oVu46rCuQmlUaH0LnAnwMULsQcHzQ8Wj+kB/bU58VDH/olN4
D4NCUmjGhcWw+ra3g3InsouXShdinVABKeNBWv52rcqtZH85eIOpr857VtGIDf2M
tX+CuHvAKi0t5K0zBNa8
=TVPx
-----END PGP SIGNATURE-----

--3QFvYPUy9pPUOQ4z0jgrxb4qkhI7KYFpH--
