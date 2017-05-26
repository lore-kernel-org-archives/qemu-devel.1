Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEKPS-0002hN-CS
	for qemu-devel@nongnu.org; Fri, 26 May 2017 14:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEKPP-0001nJ-AJ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 14:56:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dEKPP-0001n4-3p
	for qemu-devel@nongnu.org; Fri, 26 May 2017 14:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC6AF17AC5A
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 18:56:21 +0000 (UTC)
Date: Fri, 26 May 2017 15:56:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170526185617.GZ32274@thinpad.lan.raisama.net>
References: <20170526110456.32004-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170526110456.32004-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] numa-test: fix query-cpus leaks
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

On Fri, May 26, 2017 at 03:04:55PM +0400, Marc-Andr=E9 Lureau wrote:
> Fix test leaks introduced in commit 2941020a476.
>=20
> (and small extra space removed)
>=20
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued on numa-next. Thanks!

--=20
Eduardo
