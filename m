Received: from eggs.gnu.org ([2001:4830:134:3::10]:44076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXV48-0001vO-Es
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXV45-0000MP-8N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXV45-0000Ly-29
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B86BB7CB97
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 16:09:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
Date: Tue, 18 Jul 2017 18:09:33 +0200
In-Reply-To: <20170714190827.4083-1-eblake@redhat.com> (Eric Blake's message
	of "Fri, 14 Jul 2017 14:08:22 -0500")
Message-ID: <87a841raki.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] random qapi cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> Trying to flush some of the random patches I have lying around
> locally.  Some of these may have been posted to the list before,
> perhaps as part of larger series, but I didn't bother to research
> which parts came from where.
>
> I'm not sure if this is in time for softfreeze; and if not, I'm
> not sure how much is appropriate during freeze vs. being deferred
> to 2.11.

A quick peek makes me think this series could in early during freeze,
because it consists of documentation fixes, test enhancements and really
simple bug fixes.
