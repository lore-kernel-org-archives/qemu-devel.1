Received: from eggs.gnu.org ([2001:4830:134:3::10]:41392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uwr-0004jG-2E
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uwn-0006Eu-Vp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1Uwn-0006Ep-Q0
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C116875ED1
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:33:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1491034725-23968-4-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Sat, 1 Apr 2017 16:18:44 +0800")
References: <1491034725-23968-1-git-send-email-peterx@redhat.com>
	<1491034725-23968-4-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 21 Apr 2017 11:33:45 +0200
Message-ID: <878tmuds06.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hmp: info migrate_capability format
 tunes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "\\ Dr . David Alan Gilbert \\ " <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Dump the info in a single line is hard to read. Do it one per line.
> Also, the first "capabilities:" didn't help much. Let's remove it.
>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
