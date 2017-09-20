Received: from eggs.gnu.org ([2001:4830:134:3::10]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duf6J-0006qB-Rs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duf6E-0007C7-7R
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1duf6D-0007Ak-SH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:34 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1504081950-2528-5-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 30 Aug 2017 16:32:01 +0800")
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-5-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 20 Sep 2017 10:44:32 +0200
Message-ID: <878th9lpxr.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 04/33] migration: dump str in
 migrate_set_state trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Strings are more readable for debugging.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
