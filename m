Received: from eggs.gnu.org ([2001:4830:134:3::10]:45313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX8ue-00058h-SK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX8ua-0001d3-Ui
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX8ua-0001ce-Ni
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 845287A167
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:30:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-3-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 17 Jul 2017 16:26:02 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-3-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 18:30:05 +0200
Message-ID: <87d18z10xe.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/11] migration: export parameters to
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Export migration parameters to qdev properties. Then we can use, for
> example:
>
>   -global migration.x-cpu-throttle-initial=xxx
>
> To specify migration parameters during init.
>
> Prefix "x-" is appended for each parameter exported to show that this is
> not a stable interface, and only for debugging/testing purpose.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

YESS!!!!!!


The number of types that I have typed that on the command line .....
