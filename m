Received: from eggs.gnu.org ([2001:4830:134:3::10]:40326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dcowi-0000zT-Go
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dcowd-0002X0-AM
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dcowd-0002W2-4j
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DE2C3744
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 08:23:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1501644321-17721-2-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 2 Aug 2017 11:25:20 +0800")
References: <1501644321-17721-1-git-send-email-peterx@redhat.com>
	<1501644321-17721-2-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 02 Aug 2017 10:23:49 +0200
Message-ID: <877eymgyy2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: fix comment disorder in
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Comments for "migration_dirty_pages" and "bitmap_mutex" are switched.
> Fix it.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
