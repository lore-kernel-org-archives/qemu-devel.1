Received: from eggs.gnu.org ([2001:4830:134:3::10]:55433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ia5-0000V8-C7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6IZz-0006ua-QV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6IZz-0006u7-KK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C5457F4BE
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:22:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
Date: Thu, 04 May 2017 17:22:02 +0200
In-Reply-To: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 4 May 2017 16:54:28 +0400")
Message-ID: <878tmc8x5x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] qmp-shell: learn to connect to qemu-ga
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

> Hi,
>
> This series adds a -N option to skip negotiate phase that qemu-ga
> doesn't implement. This allows to use qmp-shell with qemu-ga for
> testing.

Applied to qapi-next, thanks!
