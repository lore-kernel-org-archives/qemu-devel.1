Received: from eggs.gnu.org ([2001:4830:134:3::10]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebmsA-0002nE-40
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebms4-00023K-Jb
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:31:18 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-6-f4bug@amsat.org>
	<20180116175202.4f35fb38.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <86d47e4f-4942-3406-caaf-927b0e370c7f@amsat.org>
Date: Wed, 17 Jan 2018 09:30:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180116175202.4f35fb38.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

On 01/16/2018 01:52 PM, Cornelia Huck wrote:
> On Tue, 16 Jan 2018 10:15:49 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/s390x/virtio-ccw.h |  2 +-
>>  hw/s390x/virtio-ccw.c | 35 +++++++++++++++++------------------
>>  2 files changed, 18 insertions(+), 19 deletions(-)
> 
> I assume someone(tm) will merge that series as a whole?

I suppose this series is candidate for Paolo's "ninja^H^H^H^H^Hmisc" tree.

> 
> If so (and with the commit message fixed),
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Sure, thanks!
