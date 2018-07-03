Received: from eggs.gnu.org ([2001:4830:134:3::10]:35231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faBBO-0004cN-VS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faBBL-00075M-PD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:36:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faBBL-00075F-J7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20002406E1D6
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:36:43 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-32-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebd98fab-11de-1c79-93f8-7454675b495c@redhat.com>
Date: Mon, 2 Jul 2018 21:36:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-32-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 31/32] monitor: Improve some comments
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

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 100 ++++++++++++++++++++++++------------------------------
>   1 file changed, 45 insertions(+), 55 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
