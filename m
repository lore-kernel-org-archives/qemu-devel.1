Received: from eggs.gnu.org ([209.51.188.92]:34322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqemv-0008Lg-D9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqemu-0005yP-SU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:59:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gqemu-0005wR-My
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 151408E5AE
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 13:59:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190204095725.27259-1-marcandre.lureau@redhat.com>
Date: Mon, 04 Feb 2019 14:59:47 +0100
In-Reply-To: <20190204095725.27259-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 4 Feb 2019 10:57:25 +0100")
Message-ID: <874l9jpsbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qemu-gdb: add a QObject pretty printer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, crosa@redhat.com

Is your subject accurate?  To my (admittedly ignorant) eyes, the patch
looks like an *Object* pretty-printer, not a *QObject* pretty-printer.
