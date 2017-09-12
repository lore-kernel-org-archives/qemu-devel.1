Received: from eggs.gnu.org ([2001:4830:134:3::10]:59274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drko7-0003ge-SO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkny-0007Iz-Ei
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkny-0007ID-8x
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:00:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BE2A859F7
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:00:41 +0000 (UTC)
Date: Tue, 12 Sep 2017 14:00:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912130038.GG17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
	<dbd61a0928821348486d0d6260be2bd3b02b6402.1504771369.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbd61a0928821348486d0d6260be2bd3b02b6402.1504771369.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/3] qapi: Rename
 WatchdogExpirationAction enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Thu, Sep 07, 2017 at 10:05:24AM +0200, Michal Privoznik wrote:
> The new name is WatchdogAction which is shorter,
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/watchdog/watchdog.c | 14 +++++++-------
>  monitor.c              |  4 ++--
>  qapi/run-state.json    |  6 +++---
>  3 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
