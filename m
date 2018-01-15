Received: from eggs.gnu.org ([2001:4830:134:3::10]:55740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb2Bf-0004VG-Qx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb2Bc-0006LQ-8n
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb2Bb-0006Ko-Si
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:16 -0500
Date: Mon, 15 Jan 2018 10:40:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115104000.GE8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171222152531.1849-1-miika9764@gmail.com>
	<20171222152531.1849-2-miika9764@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171222152531.1849-2-miika9764@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] input: add missing JIS keys to virtio
 input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miika S <miika9764@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Fri, Dec 22, 2017 at 05:25:29PM +0200, Miika S wrote:
> keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana
> 
> Signed-off-by: Miika S <miika9764@gmail.com>
> ---
>  hw/input/virtio-input-hid.c | 7 +++++++
>  qapi/ui.json                | 5 ++++-
>  ui/keycodemapdb             | 2 +-
>  3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
