Received: from eggs.gnu.org ([2001:4830:134:3::10]:40539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drST6-0003LC-PE
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drST3-0003aQ-M5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drST3-0003Zl-DJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:25:53 -0400
References: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8de5a2a0-a4aa-4e81-4ede-b19d7f72bda3@redhat.com>
Date: Mon, 11 Sep 2017 12:25:45 -0500
MIME-Version: 1.0
In-Reply-To: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XELfSPk4sMnFcsmGFBxu4uJrI59s84CrJ"
Subject: Re: [Qemu-devel] [PATCH v3 0/4] *** Introduce a new vhost-user-blk
 host device to Qemu ***
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org
Cc: james.r.harris@intel.com, mst@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, felipe@nutanix.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XELfSPk4sMnFcsmGFBxu4uJrI59s84CrJ
From: Eric Blake <eblake@redhat.com>
To: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org
Cc: james.r.harris@intel.com, mst@redhat.com, stefanha@gmail.com,
 pbonzini@redhat.com, felipe@nutanix.com, marcandre.lureau@redhat.com
Message-ID: <8de5a2a0-a4aa-4e81-4ede-b19d7f72bda3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] *** Introduce a new vhost-user-blk
 host device to Qemu ***
References: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 02:56 AM, Changpeng Liu wrote:
   ^^^^^^^^^^^^^^^^^^^

Wow, your system clock is off.  According to the mail headers:

> Received: from orsmga004.jf.intel.com ([10.7.209.38])
> 	by fmsmga105.fm.intel.com with ESMTP; 11 Sep 2017 00:36:13 -0700
=2E..
> Date: Tue, 12 Sep 2017 15:56:12 +0800

the intel.com machine received it at 7:36 UTC Monday, even though your
computer sent it at 9:56 UTC Tuesday, 26 hours in the future.  Sending
mail from the future messes with clients that like to display mail
sorted by date of last activity in the thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XELfSPk4sMnFcsmGFBxu4uJrI59s84CrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm2xxkACgkQp6FrSiUn
Q2p7iAf+ItVut5JuRF7VGrOHRuZkFJ0cXIHlayVwrR2DUqZeZloOj7V3yyR2depF
Lwut/cWrC/H/z5PNbm2H9naTYUVuc/nzBajoGep2OdP2/GU/HEB1UwDxuAchsYl5
DIH1Cc5D2ZDnye4DI0u8xRnRKYoHWIMQgMh2m368Lrv2WWs7OX4sSqXGAC8rmshk
eYItVRmNfPho2+AUGe3X0Wz3n5qZbCOvoV7pa0zXgIz0tt4Be3yaBm+I5M7o65ym
sw5Edo9i1i3Grwx0p/mw8Y8sM+jTokM3jX0lfAZ0kgmhw9JUkDJi9HvW0FavJW9M
GFg+Ab3hdjVpmJo1dYnDF6DPsGKZUQ==
=Mbsv
-----END PGP SIGNATURE-----

--XELfSPk4sMnFcsmGFBxu4uJrI59s84CrJ--
