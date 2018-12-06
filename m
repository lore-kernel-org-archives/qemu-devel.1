Received: from eggs.gnu.org ([2001:4830:134:3::10]:34969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUwFN-0006o2-6t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUwFJ-0002lW-8m
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:11:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUwFJ-0002ij-1f
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:11:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2666C307C941
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:11:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-18-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 17:11:19 +0100
In-Reply-To: <20180706105753.26700-18-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:43 +0200")
Message-ID: <87va46bpp4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 17/27] qapi: add 'if' to implicit struct
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Generated code is not changed by this patch, but with "qapi: add #if
> conditions to generated code" patch.

My suggestion on PATCH 13's commit message applies.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Other than that,
Reviewed-by: Markus Armbruster <armbru@redhat.com>
