Received: from eggs.gnu.org ([2001:4830:134:3::10]:53921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ebUTf-0005bD-21
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ebUTb-0004og-4P
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:52:47 -0500
Date: Tue, 16 Jan 2018 17:52:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180116175202.4f35fb38.cohuck@redhat.com>
In-Reply-To: <20180116131555.14242-6-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] virtio-ccw: convert
 VirtIOCCWDeviceClass::init -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

On Tue, 16 Jan 2018 10:15:49 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/s390x/virtio-ccw.h |  2 +-
>  hw/s390x/virtio-ccw.c | 35 +++++++++++++++++------------------
>  2 files changed, 18 insertions(+), 19 deletions(-)

I assume someone(tm) will merge that series as a whole?

If so (and with the commit message fixed),

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
