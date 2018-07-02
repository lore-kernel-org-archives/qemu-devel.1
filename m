Received: from eggs.gnu.org ([2001:4830:134:3::10]:46606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5kF-000346-TQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5kC-0004EP-Ss
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:48:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa5kC-0004Dz-NX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:48:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42D0640255C9
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 20:48:20 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <899e5350-14f1-9e48-f3b3-96fa200b9d50@redhat.com>
Date: Mon, 2 Jul 2018 15:48:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/32] monitor: Spell "I/O thread"
 consistently in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 

Well, we DO have an IOThread C struct (in iothread.h), but I do find 
your use of "I/O thread" more legible.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
