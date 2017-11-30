Received: from eggs.gnu.org ([2001:4830:134:3::10]:46870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQvG-0001GK-Lk
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQvB-00059M-53
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:38:46 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fd35be1-92f1-fed9-b888-79c24b749216@redhat.com>
Date: Thu, 30 Nov 2017 09:38:25 -0600
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] block/qcow: Add blkdebug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On 11/22/2017 08:08 PM, Max Reitz wrote:
> This is not necessarily complete, but it should include the most
> important places.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Looks reasonable; it doesn't hurt anything, and may make more testing 
feasible, even if we aren't actively maintaining this code.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
