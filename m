Received: from eggs.gnu.org ([2001:4830:134:3::10]:58121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOmEh-0007P1-81
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOmEg-0000JU-9j
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:45:03 -0400
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
	<8ccfcf94-2282-b56b-4b79-41c05551d26d@tuxera.com>
	<582811be-f110-9045-1fb8-9bf186d6dd7b@redhat.com>
	<e6bbc05d-eaf1-dffc-6f62-c8a5005189e2@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6055b0e1-d073-e504-dd9f-1cf8e161ded0@redhat.com>
Date: Fri, 1 Jun 2018 10:44:55 -0500
MIME-Version: 1.0
In-Reply-To: <e6bbc05d-eaf1-dffc-6f62-c8a5005189e2@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>, Kevin Wolf <kwolf@redhat.com>

On 06/01/2018 10:15 AM, Ari Sundholm wrote:
> Thank you.
> 
> I'll try to get a new, more proper version of the patchset out for 
> review/comments next week. Sorry for the sloppiness in this first version!

Looking forward to it, even if, as Stefan pointed out, we can already do 
everything by use of the existing quorum driver and a custom NBD server.

And don't worry about the patch not being perfect the first time - 
that's just a typical part of the review process.  Although unintended 
on my end, I know that my reviews can be perceived as coming across 
rather negatively, especially when I don't always remember to also 
express my appreciation for the efforts you've already put into writing 
a patch.  The community is always better when we remember to treat 
newcomers (and long-time contributors) nicely, regardless of the outcome 
of the patch review process; and the reason we review things is so that 
however sloppy a first draft was, the final product is a lot better!

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
