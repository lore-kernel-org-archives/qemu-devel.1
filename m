Received: from eggs.gnu.org ([2001:4830:134:3::10]:36790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1feiKP-0006XW-A0
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1feiKM-0005c3-8b
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:48:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1feiKM-0005be-2T
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:48:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62DFB8011454
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 14:48:45 +0000 (UTC)
References: <489fd750574cf761c1f083eaa7d2306e41035004.1522004432.git.crobinso@redhat.com>
	<5b7975a2-d5ff-d975-ea41-e8f67c701df9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2547adf7-4960-a8a8-5c81-b30673263a80@redhat.com>
Date: Sun, 15 Jul 2018 16:48:37 +0200
MIME-Version: 1.0
In-Reply-To: <5b7975a2-d5ff-d975-ea41-e8f67c701df9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH sgabios] Makefile: Add HOSTCC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org

On 03/07/2018 16:40, Cole Robinson wrote:
> I probably should have added more context here...
> 
> We carry this patch to sgabios in Fedora to enable cross compilation. It
> would be nice to get it into the qemu sgabios git repo so we don't have
> to track it downstream anymore
> 
> Thanks,
> Cole

Applied to sgabios.git, thanks!

Paolo
