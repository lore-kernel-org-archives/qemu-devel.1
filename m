Received: from eggs.gnu.org ([2001:4830:134:3::10]:57047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy3RS-0002ZS-96
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy3RO-0003ux-04
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cy3RN-0003uA-Ns
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:35:09 -0400
References: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<ced60264-e022-7880-cba5-97afe7976c0e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f986163-2885-95ad-b15a-9eec2ba1db5b@redhat.com>
Date: Tue, 11 Apr 2017 16:34:57 -0500
MIME-Version: 1.0
In-Reply-To: <ced60264-e022-7880-cba5-97afe7976c0e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uk7KfKvXbT4cOHpkSEU3OTA5oakJ2nV8T"
Subject: Re: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and
 g_free in util/envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uk7KfKvXbT4cOHpkSEU3OTA5oakJ2nV8T
From: Eric Blake <eblake@redhat.com>
To: Prerna Garg <Prerna.Garg@live.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3f986163-2885-95ad-b15a-9eec2ba1db5b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and
 g_free in util/envlist.c
References: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
 <ced60264-e022-7880-cba5-97afe7976c0e@redhat.com>
In-Reply-To: <ced60264-e022-7880-cba5-97afe7976c0e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 04:30 PM, Eric Blake wrote:

> You're also missing a category, and patches should generally favor
> imperative tense (think "[apply this patch to] do this") rather than
> past tense ("[this patch] did this").  Also, you want the subject line
> to be a short how; the commit body can be used for further explanations=
=2E

I hit send too soon; I was trying to say:

the subject line is a short "what"; the commit body goes into "why" or
more details "how" as needed.

At any rate, these suggestions, and more, can be found at:
http://wiki.qemu-project.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uk7KfKvXbT4cOHpkSEU3OTA5oakJ2nV8T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7UwBAAoJEKeha0olJ0NqZQ8IAI0872GAnfNDcwIPEzjOCoXb
pqcBeLoU61gfrQNHkpLhqCE+ZMGzpmToILSQ9PKILd9KKb2C4B0EKmIaQ52es8Gk
cvUmOpACn44uBVAcVpKa5l/94urMdio8UqqFzZgyrxtMT9SDSapaXPGV3GGrPWkx
UBjf7awYf67sRCTtISyJbgJlwNyF6eTL6RKOFQNKZHPW1JyvfwERi0f4+psnWrd8
i+L700Wq51Rev7yniKcDAWBAJ6eWqm6+oKfUqhkPT2F7ASQ0WjB3GTdUKpG0G92w
bFu3JCe2atV6paKE6WQsHybqM0t2yDgHjKCAgikJXIsXXAXB6e+8f/ewx/MkspA=
=ejhK
-----END PGP SIGNATURE-----

--uk7KfKvXbT4cOHpkSEU3OTA5oakJ2nV8T--
