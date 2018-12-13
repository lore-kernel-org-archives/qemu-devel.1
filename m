Received: from eggs.gnu.org ([2001:4830:134:3::10]:48332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXRcG-0000Fj-D0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXRc6-00088F-Ch
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXRc6-00087q-6q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80296309706E
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:05:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-20-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 15:05:09 +0100
In-Reply-To: <20181213123724.4866-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:21 +0400")
Message-ID: <877egdr08a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 19/22] qapi: add 'If:' condition to
 struct members documentation
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Like the previous patch, this will do for now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
