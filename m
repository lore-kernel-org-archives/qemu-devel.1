Received: from eggs.gnu.org ([2001:4830:134:3::10]:54752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT8Q8-0008Er-7n
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT8Q4-0006Gh-Dn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT8Q4-0006Fh-7k
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 636698535D
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 15:10:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
Date: Thu, 06 Jul 2017 17:10:11 +0200
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Thu, 8 Jun 2017 10:39:01 -0300")
Message-ID: <87o9sxha98.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] Error handling cleanup and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> This series fixes and simplifies some of the existing code that
> assigns to *errp directly.

PATCH 1-3 applied to error-next, thanks!
