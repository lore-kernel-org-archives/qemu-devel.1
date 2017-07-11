Received: from eggs.gnu.org ([2001:4830:134:3::10]:34253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUvy4-0003VD-M1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUvy3-0005fw-Mv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUvy3-0005fm-GK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:16:47 -0400
Date: Tue, 11 Jul 2017 16:16:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711161640.68620703@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499781397-19749-7-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<1499781397-19749-7-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/11] pc-bios/s390-ccw: Remove unused
 structs from virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Tue, 11 Jul 2017 15:56:32 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Looks like they have never beend used, so let's simply remove them.

s/beend/been/

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/virtio.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Huh. At least their style had been fixed in the past ;)

Acked-by: Cornelia Huck <cohuck@redhat.com>
