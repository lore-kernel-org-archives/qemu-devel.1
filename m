Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWixn-0003FM-JI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWixk-0004vj-FF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:24:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWixk-0004vM-8y
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:24:40 -0500
References: <20181210145653.GE5000@localhost.localdomain>
	<20181211072027.GA4465@weckbecker.name>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d51f9d6-7872-c1eb-cdd6-4db8134b859e@redhat.com>
Date: Tue, 11 Dec 2018 08:24:34 -0600
MIME-Version: 1.0
In-Reply-To: <20181211072027.GA4465@weckbecker.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fwd: [PATCH] QEMU patch for PCI handling bug
 (invalid free)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Weckbecker <matthias@weckbecker.name>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On 12/11/18 1:20 AM, Matthias Weckbecker wrote:

>> Maybe some of the explanation above should actually be moved to the
>> commit message of the patch itself?
>>
> 
> yes, I agree. I have --amend'ed my commit message and re-attached it.

It's best to resend the patch as a new top-level thread with v2 in the 
title; 'git send-email -v2' can do that.

More patch submission hints:
https://wiki.qemu.org/Contribute/SubmitAPatch

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
