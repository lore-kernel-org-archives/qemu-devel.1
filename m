Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS5oK-0007Y5-4F
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS5oG-0000T6-2C
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:43:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS5oF-0000RM-Rk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:43:11 -0500
References: <151387102500.6441.11333264832773390059.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e09c289a-fed0-5164-dda0-80dfcee6c705@redhat.com>
Date: Thu, 21 Dec 2017 12:43:09 -0600
MIME-Version: 1.0
In-Reply-To: <151387102500.6441.11333264832773390059.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix type in *_parse_opts declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 12/21/2017 09:43 AM, Greg Kurz wrote:
> To comply with the QEMU coding style.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/9pfs/9p-handle.c |    2 +-
>   hw/9pfs/9p-local.c  |    2 +-
>   hw/9pfs/9p-proxy.c  |    2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
