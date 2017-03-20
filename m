Received: from eggs.gnu.org ([2001:4830:134:3::10]:32782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq39F-0001mM-W3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq39C-0000cD-Qg
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cq39C-0000b8-Jq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83A588047D
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:39:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170316122026.GB2567@work-vm> (David Alan Gilbert's message of
	"Thu, 16 Mar 2017 12:20:27 +0000")
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-3-quintela@redhat.com>
	<20170316122026.GB2567@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 20 Mar 2017 20:39:14 +0100
Message-ID: <87bmsvagbh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/31] ram: Add dirty_rate_high_cnt to
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We need to add a parameter to several functions to make this work.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

[...]

> Is that undoing false spaces from the previous patch?

Yes O:-)

>
> anyway,
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.
