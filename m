Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZLWd-0006dc-By
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZLWa-0006qR-1d
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:59:31 -0500
References: <20181115211752.1295571-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae6d8857-0d5f-f70c-1547-2f75d1a74cf6@redhat.com>
Date: Tue, 18 Dec 2018 13:59:23 -0600
MIME-Version: 1.0
In-Reply-To: <20181115211752.1295571-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] typedefs.h cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, Laurent Vivier <lvivier@redhat.com>

On 11/15/18 3:17 PM, Eric Blake wrote:
> Prompted by my review of xiezhide's work.  No semantic change, but
> not technically a bug fix, so I don't care if it goes in 3.1 or
> waits for 4.0.
> 
> Eric Blake (2):
>    typedefs: (Re-)sort entries alphabetically
>    numa: Match struct to typedef name
> 

Ping. Patch 2 is now in master (aec90730) via numa, but patch 1 got 
overlooked in the trivial queue, even though it has reviews.

>   include/qemu/typedefs.h | 12 ++++++------
>   include/sysemu/numa.h   |  2 +-
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
