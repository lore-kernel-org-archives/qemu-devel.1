Received: from eggs.gnu.org ([2001:4830:134:3::10]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cswBV-0000gD-Fb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cswBS-0000NF-F3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cswBS-0000N3-8k
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 269CD7E9DE
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 18:49:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490708752-26902-1-git-send-email-armbru@redhat.com>
	<1490708752-26902-2-git-send-email-armbru@redhat.com>
	<f3b944ed-303c-31fa-7379-78f5076086cf@redhat.com>
Date: Tue, 28 Mar 2017 20:49:31 +0200
In-Reply-To: <f3b944ed-303c-31fa-7379-78f5076086cf@redhat.com> (Paolo
	Bonzini's message of "Tue, 28 Mar 2017 16:18:18 +0200")
Message-ID: <87zig5s0ck.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/03/2017 15:45, Markus Armbruster wrote:
>> It's been a long journey, but here we are.
>> 
>> The supported blockdev-add is not compatible to its experimental
>> predecessors; bump all Since: tags to 2.9.
>
> Can you document the differences in the 2.9 changelog?

Not sure I can before I drop off for a week of vacation.  Kevin, Max,
can you chip in?
