Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3St5-0005Ag-5I
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3St4-0003Oe-3z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:46:07 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11083e1d-aadd-259b-3dbb-a872e00acf84@redhat.com>
Date: Wed, 26 Apr 2017 14:45:55 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1FTVoMS8LSQfAIspkV9Km1Op4oq7Aw31q"
Subject: Re: [Qemu-devel] [PATCH 7/7] socket: Delete unused helper
 socket_address_crumple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1FTVoMS8LSQfAIspkV9Km1Op4oq7Aw31q
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <11083e1d-aadd-259b-3dbb-a872e00acf84@redhat.com>
Subject: Re: [PATCH 7/7] socket: Delete unused helper socket_address_crumple()
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/sockets.h | 11 -----------
>  util/qemu-sockets.c    | 31 -------------------------------
>  2 files changed, 42 deletions(-)

Code deletion is fun!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1FTVoMS8LSQfAIspkV9Km1Op4oq7Aw31q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAPj0AAoJEKeha0olJ0NqNc8H/0ofRFi2BBLm3+pnhwKnTjop
nCOPV9BmbcoBJbQCEnD55UVr8g/USuM6LNPwCGoNSh1B2HELSoiPaELpaEoO7ETo
yvVgZKZihK9f818IQc86IeTkH/OGx/67wgQBQpg8zI/p3OgIfZRNbVCshc1wVfGj
BDF3I1Ez1d+PBFuPgXwIbqEqbudkLXLnNokVHvibJXN4H4xOC+mswJJXIh+nPItc
e1DdjHeX3vYoVp+LsZaz9NQztmbBXMyKDPqftrct+mgmIIwqWtUd+AF9TBMSzzvx
d/433mpo7RjqfQzTIytycIyehXwDO7GEDNtkUbIo3g6GCMxps5tRGqItHOp9PAU=
=syF4
-----END PGP SIGNATURE-----

--1FTVoMS8LSQfAIspkV9Km1Op4oq7Aw31q--
