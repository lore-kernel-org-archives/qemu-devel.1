Received: from eggs.gnu.org ([2001:4830:134:3::10]:41668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQIa-0006BC-Bj
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQIV-0006SR-F0
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:23:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsQIV-0006SH-8Y
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9E2940216E8
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:23:30 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-6-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5a5b695c-3617-5aee-0d73-e786d55f3630@redhat.com>
Date: Wed, 22 Aug 2018 12:23:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095421.11765-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/10] x86_64-softmmu: Configuration is
 identical to i386-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2018-08-22 11:54, Juan Quintela wrote:
> If we ever changed that, just make the things that are different
> explicit.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/x86_64-softmmu.mak | 67 +-----------------------------
>  1 file changed, 1 insertion(+), 66 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
