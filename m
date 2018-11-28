Received: from eggs.gnu.org ([2001:4830:134:3::10]:50040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6eJ-0007V8-6a
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6e7-0003fe-Ji
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:41:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6e5-0003bh-GZ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:41:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEE15307D983
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:41:14 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-16-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b5f8ba41-c777-d81a-fa0a-82e4b738d6cd@redhat.com>
Date: Wed, 28 Nov 2018 21:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-16-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/16] virtio: split virtio crypto bits
 rom virtio-pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 26/11/2018 21:00, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/virtio-crypto-pci.c | 14 ++++++++++++++
>  hw/virtio/virtio-pci.h        | 14 --------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
