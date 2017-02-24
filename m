Received: from eggs.gnu.org ([2001:4830:134:3::10]:55879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFpE-0004s7-8i
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFpB-00025R-2T
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:22:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1chFpA-000259-Sq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:22:16 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1396C85376
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 13:22:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170206173306.20603-8-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 6 Feb 2017 17:32:57 +0000")
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-8-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Feb 2017 14:22:07 +0100
Message-ID: <87fuj3k9kw.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 07/16] postcopy: Record largest page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Record the largest page size in use; we'll need it soon for allocating
> temporary buffers.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
