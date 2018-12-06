Received: from eggs.gnu.org ([2001:4830:134:3::10]:40879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUwUS-0001iG-GD
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUwUR-0006Q3-EW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUwUR-0006Ox-54
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:27:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55480C04AC54
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:27:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-19-marcandre.lureau@redhat.com>
	<871s6ubp1g.fsf@dusky.pond.sub.org>
Date: Thu, 06 Dec 2018 17:26:57 +0100
In-Reply-To: <871s6ubp1g.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 06 Dec 2018 17:25:31 +0100")
Message-ID: <87r2euaaem.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 18/27] qapi: add an error in case a
 discriminator is conditionnal
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

One more thing: in the subject, s/conditionnal/conditional/.
