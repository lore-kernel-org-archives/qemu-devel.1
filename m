Received: from eggs.gnu.org ([2001:4830:134:3::10]:57803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwCD-0000Pg-JO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwCC-00048a-MX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:09:41 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd2610ac-1293-bcd0-8f12-4f1b7a2df57e@redhat.com>
Date: Wed, 2 May 2018 13:09:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] qemu-option: Pull out "Supported
 options" print
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/21/2018 11:54 AM, Max Reitz wrote:
> It really is up to the caller to decide what this list of options means.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c         | 1 +
>   util/qemu-option.c | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
