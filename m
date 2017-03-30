Received: from eggs.gnu.org ([2001:4830:134:3::10]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctcaQ-0004x4-3U
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctcaK-0001O5-EF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctcaK-0001Ne-9L
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59F878FD18
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:06:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170330062714.GF20667@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 30 Mar 2017 14:27:14 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-28-quintela@redhat.com>
	<20170330062714.GF20667@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Thu, 30 Mar 2017 18:05:51 +0200
Message-ID: <87lgrmn40w.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 27/51] ram: Use the RAMState
 bytes_transferred parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 23, 2017 at 09:45:20PM +0100, Juan Quintela wrote:
>> Somewhere it was passed by reference, just use it from RAMState.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> (Is this a self-review above? :-)

Of course O:-)

Fat fingers and macros make that to me O:-)

Thanks.

>
> Reviewed-by: Peter Xu <peterx@redhat.com>
