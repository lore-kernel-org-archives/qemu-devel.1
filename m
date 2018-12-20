Received: from eggs.gnu.org ([2001:4830:134:3::10]:58131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ga4cX-00014d-NE
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ga4cS-00041v-PN
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:08:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ga4cS-0003zW-DU
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:08:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAAD7C06C9E4
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 20:08:29 +0000 (UTC)
Date: Thu, 20 Dec 2018 18:08:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181220200825.GO19442@habkost.net>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
	<20181212214850.29953-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181212214850.29953-8-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/28] compat: replace PC_COMPAT_3_0 &
 HW_COMPAT_3_0 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Thu, Dec 13, 2018 at 01:48:29AM +0400, Marc-Andr=E9 Lureau wrote:
> Use static arrays instead.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

In case you need to respin the series: I suggest squashing
patches 07-19 together.

--=20
Eduardo
