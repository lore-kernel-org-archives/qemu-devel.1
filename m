Received: from eggs.gnu.org ([2001:4830:134:3::10]:47324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dkDCg-00036K-1E
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dkDCd-0002QI-0i
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:43:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dkDCc-0002Oz-PN
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:42:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65F3E61475
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 17:42:57 +0000 (UTC)
References: <1503384739-17207-1-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e120901a-9c70-6953-0f4c-321ee571de1e@redhat.com>
Date: Tue, 22 Aug 2017 19:42:52 +0200
MIME-Version: 1.0
In-Reply-To: <1503384739-17207-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BgGDMabPB0A4tbDKNagGHQj7lSTiTrrcU"
Subject: Re: [Qemu-devel] [PATCH] qobject: Explain how QNum works, and why
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgGDMabPB0A4tbDKNagGHQj7lSTiTrrcU
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <e120901a-9c70-6953-0f4c-321ee571de1e@redhat.com>
Subject: Re: [PATCH] qobject: Explain how QNum works, and why
References: <1503384739-17207-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1503384739-17207-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-22 08:52, Markus Armbruster wrote:
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qnum.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Thanks again!

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BgGDMabPB0A4tbDKNagGHQj7lSTiTrrcU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmcbRwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8KsIAJgBLrbUnH3fRy6RhDCl1OJBKENyDUh9
fifYBOtxxB0NpUYNwMbJWl538GpTtmfjKdMYFlcfb8K+AfrRA24dzfqlDEpsOtzb
99hqeIVWjO5Syc1F7UmkV3SWOEZaalQRxhrRoNEPAWWkiMqx2h9Oh5F58x/2NTlZ
XJCvmS/4nUFt34NbY93WhZ18i2t7KupV8aSC5fYtnWnIk+S8lbiVEylkpF/Mt92M
Mi/ApO/52cBfCumT3GV2rJfuY2mi14zHR6a8Im1gX1kdz+XdDRslwznPBb2DqERF
wvJLOmHQfzP4r4HnDdLbCvbmbgRKChXn4AmLuEu7HOVVZ9UlkuHYfMM=
=DQM+
-----END PGP SIGNATURE-----

--BgGDMabPB0A4tbDKNagGHQj7lSTiTrrcU--
