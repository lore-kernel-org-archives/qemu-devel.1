Received: from eggs.gnu.org ([2001:4830:134:3::10]:42475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQCDM-0001xK-0V
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQCDI-0003FH-U4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:37:00 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-14-vsementsov@virtuozzo.com>
	<f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da795837-2945-d3b1-bd92-e6ced22817bc@redhat.com>
Date: Wed, 28 Jun 2017 07:36:44 -0500
MIME-Version: 1.0
In-Reply-To: <f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m8sNN9MqVgu7HV9VKv80cCPie7rODGuiQ"
Subject: Re: [Qemu-devel] [PATCH v22 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m8sNN9MqVgu7HV9VKv80cCPie7rODGuiQ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <da795837-2945-d3b1-bd92-e6ced22817bc@redhat.com>
Subject: Re: [PATCH v22 13/30] block: new bdrv_reopen_bitmaps_rw interface
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-14-vsementsov@virtuozzo.com>
 <f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
In-Reply-To: <f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[meta-comment]

On 06/28/2017 07:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> 28.06.2017 15:05, Vladimir Sementsov-Ogievskiy wrote:
>> Add format driver handler, which should mark loaded read-only
>> bitmaps as 'IN_USE' in the image and unset read_only field in
>> corresponding BdrvDirtyBitmap's.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>> Reviewed-by: John Snow<jsnow@redhat.com>

Your original message had spaces before '<' in the email addresses, but
it got lost here...

>=20
>=20
> Forgot to add:
>=20
> Reviewed-by: Max Reitz<mreitz@redhat.com>

=2E..this one also lacks the space.  I'm not sure if git cares, but it ma=
y
be worth investigating why your mailer eats the space when you reply
manually rather than sending via git; and for consistency, it is worth
keeping the space (for example, we like to grep 'git log' for learning
how active various contributors are, and having a consistent usage of
space before < in an email address can make the task easier).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m8sNN9MqVgu7HV9VKv80cCPie7rODGuiQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU6LcAAoJEKeha0olJ0NqZaAH/3+mv6eBpL27e+HXvzR5sqSo
HUlvrdveXawx2/gIgPAEjb7/Afh7mRMplxn/JgMCrYasEBelL98ejanSKWa6VrLd
YbGbVZ/1yqiifYl4mCV7Kt5Fj/oFd86NclVZ+0ozal43ELlaqSsunovY55fS3gPL
QKr6NWZFVzPM9L6S0Y/iW5KOiNxoQhd4eGFCIo+U+fBPNDdkViVhzz6K6vk+mM4Q
23rN4zfwt8hEPF49kdk+2nniLOvI1flXjDyoIxw9XXJ647oTyKSF2C8/3OAGKnOp
8uWZtYd/cLk853hBSkeUqz2+lojBGCPudsjsjsuUQmzbCsWX/E6IrDbbytmAiTA=
=oK53
-----END PGP SIGNATURE-----

--m8sNN9MqVgu7HV9VKv80cCPie7rODGuiQ--
