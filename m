Received: from eggs.gnu.org ([2001:4830:134:3::10]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKAjW-0005ou-8R
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 16:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKAjV-0004v4-Gt
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 16:17:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cKAjV-0004uY-BJ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 16:17:01 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 932A6804EF
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 21:17:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-17-marcandre.lureau@redhat.com>
Date: Thu, 22 Dec 2016 22:16:58 +0100
In-Reply-To: <20161206141343.28044-17-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 6 Dec 2016
	17:13:42 +0300")
Message-ID: <87a8bnr7ed.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 16/17] build-sys: add txt documentation
 rules
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

> Build txt documentation, and install it.

Suggest "Build plain text documentation".  Can touch up on commit.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
