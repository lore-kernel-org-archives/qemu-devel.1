Received: from eggs.gnu.org ([209.51.188.92]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grLYg-0001Tv-7Z
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grLYf-0002JP-IF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:40:02 -0500
References: <20190206112729.37761-1-sgarzare@redhat.com>
	<20190206112729.37761-7-sgarzare@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce44833e-87e3-041d-43bd-4d2c0a796e84@redhat.com>
Date: Wed, 6 Feb 2019 12:39:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190206112729.37761-7-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/6] tests/virtio-blk: add test for
 WRITE_ZEROES command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 2019-02-06 12:27, Stefano Garzarella wrote:
> If the WRITE_ZEROES feature is enabled, we check this command
> in the test_basic().
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/virtio-blk-test.c | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>
