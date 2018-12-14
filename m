Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXjfm-0004CZ-6f
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXjfh-0000Py-8A
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:22:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXjfg-0000Oz-Vi
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:22:13 -0500
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-15-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <23c12427-4612-9851-8b13-220e829b2dbf@redhat.com>
Date: Fri, 14 Dec 2018 10:22:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181213210057.3676-15-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 14/16] virtio: split virtio gpu bits rom
 virtio-pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>

On 2018-12-13 22:00, Juan Quintela wrote:
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/display/virtio-gpu-pci.c | 14 ++++++++++++++
>  hw/display/virtio-vga.c     |  1 +
>  hw/virtio/virtio-pci.h      | 14 --------------
>  3 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
