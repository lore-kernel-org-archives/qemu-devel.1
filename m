Received: from eggs.gnu.org ([209.51.188.92]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gm1IW-00089n-J6
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gm1IV-0004uU-SH
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gm1IV-0004tw-Mz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:19 -0500
Date: Tue, 22 Jan 2019 13:23:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190122152355.GR4136@habkost.net>
References: <20190122121048.76469-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122121048.76469-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: enable PVH only for machine
 type >= 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Liam Merwick <liam.merwick@oracle.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 22, 2019 at 01:10:48PM +0100, Stefano Garzarella wrote:
> In order to avoid migration issues, we enable PVH only for
> machine type >= 4.0
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
