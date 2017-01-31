Received: from eggs.gnu.org ([2001:4830:134:3::10]:59789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYYNX-00005W-Id
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYYNT-0001Mi-Lf
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:21:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYYNT-0001MW-GS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:21:43 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FACA7E9CD
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 13:21:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-13-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 6 Jan 2017 18:28:20 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-13-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jan 2017 14:21:38 +0100
Message-ID: <87lgtrs6u5.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/15] postcopy: Allow hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Allow huge pages in postcopy.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/postcopy-ram.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
>

Reviewed-by: Juan Quintela <quintela@redhat.com>
