Received: from eggs.gnu.org ([2001:4830:134:3::10]:37251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duf2e-0003jZ-53
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duf2d-0004qI-1k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1duf2c-0004pi-RZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:50 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1504081950-2528-2-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 30 Aug 2017 16:31:58 +0800")
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-2-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 20 Sep 2017 10:41:29 +0200
Message-ID: <87d16llq2u.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 01/33] bitmap: remove BITOP_WORD()
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
> We have BIT_WORD(). It's the same.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

It is the same, and it don't ever exist on linux code.
