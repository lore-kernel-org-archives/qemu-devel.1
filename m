Received: from eggs.gnu.org ([2001:4830:134:3::10]:38524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpHRg-0006aq-M8
	for Qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpHRd-0001PB-HJ
	for Qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:20:00 -0400
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
Date: Mon, 13 Aug 2018 13:19:54 -0500
MIME-Version: 1.0
In-Reply-To: <5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, John Arbuckle <programmingkidx@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, Qemu-devel@nongnu.org

On 08/13/2018 11:56 AM, Max Reitz wrote:
> 
> Ah, hm, so much for that.  Hm...  I don't quite know what to think of
> this.  It does indeed improve legibility.  But the question is whether
> --help should be as condensed as possible, and if the user finds it hard
> to read, whether they should not just open the man page...
> 
> Then again, our --help text already has 102 lines.
> 
> Let me just think about it for a bit longer. :-)
> (And see whether others have opinions.)

And I've already expressed my opinion that it is already rather long, 
where making it longer is not necessarily making it smarter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
