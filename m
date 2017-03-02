Received: from eggs.gnu.org ([2001:4830:134:3::10]:53116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjWN5-0006rK-Ua
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjWN1-0007Gd-RT
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:26:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjWN1-0007GM-IV
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:26:35 -0500
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<148847375468.285.999031041241417996@0e2666bad730>
	<F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7aed6281-a647-78bd-3d39-233ca50d8f71@redhat.com>
Date: Thu, 2 Mar 2017 13:26:25 -0600
MIME-Version: 1.0
In-Reply-To: <F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mr58deMkxkujULRB3UX9VOwMi7CtMJ6NF"
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mr58deMkxkujULRB3UX9VOwMi7CtMJ6NF
From: Eric Blake <eblake@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <7aed6281-a647-78bd-3d39-233ca50d8f71@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and sample
 application
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
 <148847375468.285.999031041241417996@0e2666bad730>
 <F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
In-Reply-To: <F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 11:01 AM, Felipe Franciosi wrote:
> Hi Eric,
>=20
> Ping on this?
> http://lists.nongnu.org/archive/html/qemu-devel/2016-10/msg06169.html
>=20

[context: Re: [Qemu-devel] [PATCH 1/2] compiler: add ignore_value() macro=
]

I'm still in favor of the patch, but only when it has a client. And I'm
not sure who the maintainer is for the 2/2 of that series.  But the
easiest way to get ignore_value() added to the source tree is to
(re-)submit it as part of a series that uses it.  It's okay for more
than one patch series to start with a common patch prefix.

For this particular thread, Dan pointed out a nice way to sidestep
ignore_value(), so that doesn't help much on the ping'd patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Mr58deMkxkujULRB3UX9VOwMi7CtMJ6NF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuHHhAAoJEKeha0olJ0NqLMYIAIck/wat4AAnATsDJgvrxoiB
WzdF1Qo10NVruDieL58GIyE3EE7VALudiLlSytJBScJQUgcYWIcB6nXmtYqZFmGG
Nbi22N/Vj/Jk6wcpHeEhpas57JUK6298wzCmP7jU1yL2R8b9qX63MYe2kDu1CDuR
CdHeVz5Gye1VxdeV1AWFgo+69EtRFiFFRacMRJUTvr6MGtZ1YB1H05YrZKo9vr+h
Rc5ntSgRR4qXd9+zsUArAPjzaAZfGye4HSsrB3sX9RK7bZdRJ0paiXGD1r4X8wph
kBDu6Ljzrn6QHrZ3xaIiC7b9F6vHgsYnyokHvDM82vfyp+/XX/aP7qSUlEntDlw=
=4wIa
-----END PGP SIGNATURE-----

--Mr58deMkxkujULRB3UX9VOwMi7CtMJ6NF--
