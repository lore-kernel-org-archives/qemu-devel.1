Received: from eggs.gnu.org ([2001:4830:134:3::10]:36504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDzL-0006Dy-Ri
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDzL-0007zN-3e
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:58:55 -0400
References: <1505465181-4147-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <582c16a3-36c9-e06c-de01-26e87a1ba184@msgid.tls.msk.ru>
Date: Sun, 24 Sep 2017 23:58:53 +0300
MIME-Version: 1.0
In-Reply-To: <1505465181-4147-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/display/virtio-gpu: Put the
 virtio-gpu-device into the display category
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

15.09.2017 11:46, Thomas Huth wrote:
> The virtio-gpu-pci device is already in the display category, so the
> virtio-gpu-device should be there, too.

Applied to -trivial, thanks!

/mjt
