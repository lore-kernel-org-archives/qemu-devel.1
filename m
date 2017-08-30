Received: from eggs.gnu.org ([2001:4830:134:3::10]:46195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8rU-0005Pr-1A
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8rT-00081b-9P
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:41:16 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<393d6a245f52394f0aa094ec1e97194aef9ab0bc.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9dd3482-6797-2518-16aa-ed4ba4d8f4f2@redhat.com>
Date: Wed, 30 Aug 2017 14:41:08 -0500
MIME-Version: 1.0
In-Reply-To: <393d6a245f52394f0aa094ec1e97194aef9ab0bc.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ILk7Th8ie1MQAceHhHbBXC1SXRGvlF5dd"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block/ssh: make compliant with
 coding guidelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ILk7Th8ie1MQAceHhHbBXC1SXRGvlF5dd
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <a9dd3482-6797-2518-16aa-ed4ba4d8f4f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block/ssh: make compliant with coding
 guidelines
References: <cover.1504112061.git.jcody@redhat.com>
 <393d6a245f52394f0aa094ec1e97194aef9ab0bc.1504112061.git.jcody@redhat.com>
In-Reply-To: <393d6a245f52394f0aa094ec1e97194aef9ab0bc.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:56 AM, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/ssh.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ILk7Th8ie1MQAceHhHbBXC1SXRGvlF5dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnFNQACgkQp6FrSiUn
Q2rYjgf9GxZtgtqj8pUWyQ26/uvZO+V1pmUoFpKdO1Y16HtTaDHmV2Kt5+9tKOxp
q0SRZzWHGloZU45fagEOJgSc8me7SgY5zVLamS57Q6Gixz5jIjdLj+wPAQDvs/yT
QaEx7/nMwtMGnBk3eCG3q0w/b3J3RJz2tIZbSEOtDxw2rNw7QKeOu0LFOH49PZ9b
JDCZQLsWUApAFJkxcJDWL/HROVauHjo/glA+GeatqMmgmIjVu7GoXQU8eWIgUaD6
WoggEYFozbUAmhye6qU2SfQLRYE8+sDqTSrmJLwuvitgvHqOMN9iOENGOqyzaLou
lm8+6KGPLWvGTWUdU351VOzzII9esw==
=Bhlv
-----END PGP SIGNATURE-----

--ILk7Th8ie1MQAceHhHbBXC1SXRGvlF5dd--
