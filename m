Received: from eggs.gnu.org ([2001:4830:134:3::10]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGIi-0006Rc-9M
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGIe-0007F5-8F
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYGId-0007Ed-Qt
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D102E79700
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 18:35:46 +0000 (UTC)
Date: Thu, 20 Jul 2017 15:35:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170720183538.GX2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-9-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720162815.19802-9-ldoktor@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/11] qmp.py: Avoid "has_key" usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

On Thu, Jul 20, 2017 at 06:28:12PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> The "has_key" is deprecated in favor of "__in__" operator.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
