Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fcrgN-0000YE-GE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fcrgJ-00080F-Fc
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:23:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fcrgJ-0007zO-Bu
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:23:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180710091902.28780-10-peterx@redhat.com> (Peter Xu's message
	of "Tue, 10 Jul 2018 17:19:01 +0800")
References: <20180710091902.28780-1-peterx@redhat.com>
	<20180710091902.28780-10-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 10 Jul 2018 14:23:43 +0200
Message-ID: <87lgajgtyo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 09/10] tests: add postcopy
 recovery test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Balamuruhan S <bala24@linux.vnet.ibm.com>

Peter Xu <peterx@redhat.com> wrote:
> Test the postcopy recovery procedure by emulating a network failure
> using migrate-pause command.
>
> Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
