Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDFCA-0002xm-W2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDFCA-0001X2-6k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:47:02 -0400
References: <20181018202254.6503-1-lyan@suse.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bfd797e1-3ae0-f82d-b440-19b97181d113@redhat.com>
Date: Thu, 18 Oct 2018 15:46:53 -0500
MIME-Version: 1.0
In-Reply-To: <20181018202254.6503-1-lyan@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: update
 qemu-iotests/082.out after 9cbef9d68ee
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Yan <lyan@suse.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 10/18/18 3:22 PM, Liang Yan wrote:
> qemu-img help output is changed after commit 9cbef9d68ee, this is a
> update for iotests.
> 
> Signed-off-by: Liang Yan <lyan@suse.com>
> ---
>   tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
>   1 file changed, 478 insertions(+), 478 deletions(-)

Thanks, but we're still discussing possible other changes to the output:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03042.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
