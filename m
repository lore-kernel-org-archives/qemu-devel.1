Received: from eggs.gnu.org ([2001:4830:134:3::10]:57781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cK9ZI-0004J7-6V
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 15:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cK9ZE-0006iS-A5
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 15:02:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cK9ZE-0006iC-4p
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 15:02:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AAC24E4D8
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 20:02:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-10-marcandre.lureau@redhat.com>
Date: Thu, 22 Dec 2016 21:02:17 +0100
In-Reply-To: <20161206141343.28044-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 6 Dec 2016
	17:13:35 +0300")
Message-ID: <87lgv7u3zq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/17] texi2pod: learn quotation,
 deftp and deftypefn
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

> Learn a few more markups used for API documentation.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I don't know enough about POD to review this.  If nobody else steps up,
and I can't find the time to learn some POD, I'll take it as is.
