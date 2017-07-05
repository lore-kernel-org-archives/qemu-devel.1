Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlzL-00039e-VJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlzL-0004Vh-3I
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSlzK-0004VF-Ss
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:13:11 -0400
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8cda5c4-7f82-e2f9-7657-e7d014ae541f@redhat.com>
Date: Wed, 5 Jul 2017 17:12:59 +0200
MIME-Version: 1.0
In-Reply-To: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/13] chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com



On 05/07/2017 16:01, Anton Nefedov wrote:
> Changed in v5:
>   - rebased
>   - patch 6 fixed (wouldn't compile until patch 7 (broken by previous rebase))
>   - patch 11 commit message added

I commented on a few patches, but v6 should be the final one.

Thanks,

Paolo
