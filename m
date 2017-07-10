Received: from eggs.gnu.org ([2001:4830:134:3::10]:39106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZsg-00068o-GL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZsd-0004ru-Fm
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dUZsd-0004r0-5t
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:41:43 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-2-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e709b24-65f4-3ae4-b8c8-18b2d0a8e8ac@redhat.com>
Date: Mon, 10 Jul 2017 09:41:38 -0500
MIME-Version: 1.0
In-Reply-To: <1499182263-19139-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="brRo9ij9VCeAwgsHHxEDbdb8jvF6Gqbnk"
Subject: Re: [Qemu-devel] [PATCH v7 1/6] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--brRo9ij9VCeAwgsHHxEDbdb8jvF6Gqbnk
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <8e709b24-65f4-3ae4-b8c8-18b2d0a8e8ac@redhat.com>
Subject: Re: [PATCH v7 1/6] throttle: factor out duplicate code
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1499182263-19139-2-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1499182263-19139-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 10:30 AM, Pradeep Jagadeesh wrote:
> This patch factor out the duplicate throttle code that was present in

s/This patch factor/Factor/

It's okay to write commit messages in the imperative tense; the easiest
way I know to start a good message is to use an implied "Apply this
patch to ..." in front of the sentence.  But "Apply this patch to This
patch ..." obviously doesn't flow, compared to "Apply this patch to
factor ..."

> block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--brRo9ij9VCeAwgsHHxEDbdb8jvF6Gqbnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY5IiAAoJEKeha0olJ0NqMegH+gKv0ayMw4Re0w66asL6FBBI
PuXU+UnsXkqKoM8r65fI2kl4ylzfFQ78ICvz4YwRMde7s1DexjzmH6e8DrhQlYv0
3z/rGhzIP1kjhnXixpls3/THq8G+efG1JBbm8S74wRPipRZGCfMlEbvsM6Kl7+I/
6vr3J8MTV0UKw1rQhpBpPFDgeaZAAiEisKeLSGPhR2k7JNl+ZjFLQz0qslOsyTs7
Fba9v7UXztN9INFSB4tZG+MgYpyCcFJ4cynoRTaSpfrMEx6u5BtXcneWQNnPda7B
7LmPBhki8iczfn8wsSpGIiuQdp3hQqvA0ecQmg7ZE3NidjvfJem8AtcKjr08ByU=
=KU0W
-----END PGP SIGNATURE-----

--brRo9ij9VCeAwgsHHxEDbdb8jvF6Gqbnk--
