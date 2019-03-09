Received: from eggs.gnu.org ([209.51.188.92]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2fVA-0000Ab-8A
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2fV9-0005Vu-Ib
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2fV9-0005VP-Bh
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:11:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3CA730B0844
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 17:11:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190227110812.2185-1-quintela@redhat.com>
	<20190227110812.2185-8-quintela@redhat.com>
Date: Sat, 09 Mar 2019 18:11:08 +0100
In-Reply-To: <20190227110812.2185-8-quintela@redhat.com> (Juan Quintela's
	message of "Wed, 27 Feb 2019 12:08:11 +0100")
Message-ID: <875zss2csz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 7/8] multifd: Drop x-
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Juan Quintela <quintela@redhat.com> writes:

> We make it supported from now on.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c                 | 10 +++++-----
>  migration/migration.c | 26 +++++++++++++-------------
>  qapi/migration.json   | 34 +++++++++++++++++-----------------
>  3 files changed, 35 insertions(+), 35 deletions(-)

Acked-by: Markus Armbruster <armbru@redhat.com>
