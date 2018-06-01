Received: from eggs.gnu.org ([2001:4830:134:3::10]:57966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgUp-0005yH-49
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgUo-0005SN-Ah
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:37:19 -0400
Date: Fri, 1 Jun 2018 10:37:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180601093709.GD8687@stefanha-x1.localdomain>
References: <20180601062849.28641-1-famz@redhat.com>
	<152783551554.348.11775495549488216762@d39dc562802a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <152783551554.348.11775495549488216762@d39dc562802a>
Subject: Re: [Qemu-devel] [PATCH v8 00/11] qemu-img convert with copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, pl@kamp.de, f4bug@amsat.org, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, alex.bennee@linaro.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 11:45:17PM -0700, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c: In function =E2=
=80=98iscsi_populate_target_desc=E2=80=99:
> /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c:2242:15: error: =
=E2=80=98IDENT_DESCR_TGT_DESCR=E2=80=99 undeclared (first use in this funct=
ion); did you mean =E2=80=98IDENT_DESCR_TGT_DESCR_SIZE=E2=80=99?
>      desc[0] =3D IDENT_DESCR_TGT_DESCR;
>                ^~~~~~~~~~~~~~~~~~~~~
>                IDENT_DESCR_TGT_DESCR_SIZE
> /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c:2242:15: note: eac=
h undeclared identifier is reported only once for each function it appears =
in

Fam, is this failure expected?

Aside from this I'm happy with the series.

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbERPFAAoJEJykq7OBq3PIJIIIAJyLlMUyhqmtp9yow4qzjgkx
u7u7E77EaDROH56OL8LgIwb9KZ34ksVfEFNZRsVPJzK89wKPGOWdG+cXbKaUJwhj
nwcyo0mgh9d+HZOkI+IejfvJaBL3IeY7GipoZOVvYxrHwVCVX1g7lkmftvVwkvWV
AUfu5CQ1NpOtsBsDmoQ+udo7+E493ufZzwdYOfJjT80K+3hCG2go0z17m8dnJLBu
mzJDVuYxEhBRPJ2zVraEFPMQ3xco0gHITHw6wYSrb0H0NPBmzDBM0uhXE3KIMI30
Vu6PjEVZPkEec7zeNKObGc+269mh65/EgYoKl8hEVKRlxq8OAXcMZvJme+aXQfk=
=AvB1
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
